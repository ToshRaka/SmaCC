"
I represent a Fibered-GLR parser capable of handling conflicts by forking when those are found.

I am responsible for parsing an input string.
My subclasses are generated from the SmaCC parser generator tool.

Contrary to a standard LR parser, I execute LR actions on fibers (SmaCCFGLRFiber) and use a scheduler (SmaCCFGLRScheduler) to schedule all the current fibers for the input.

Public API and Key Messages

- parse: aString 			| parse aString a return a list of trees corresponding to each possible parse
 
Internal Representation and Key Implementation Points.

    Instance Variables
	fiber:			<SmaCCFGLRFiber>
	scheduler:		<SmaCCFGLRScheduler>
"
Class {
	#name : #SmaCCFGLRParser,
	#superclass : #SmaCCParser,
	#instVars : [
		'scheduler',
		'fiber'
	],
	#classInstVars : [
		'cachedTrees'
	],
	#category : #'SmaCC_FGLR_Runtime-Core'
}

{ #category : #accessing }
SmaCCFGLRParser class >> cachedTrees [
	^ cachedTrees ifNil: [ cachedTrees := Dictionary new ]
]

{ #category : #'instance creation' }
SmaCCFGLRParser class >> on: aStream [
	| parser scanner |
	self checkCaches.
	scanner := self scannerClass on: aStream.
	parser := self new.
	parser scanner: scanner.
	^ parser
]

{ #category : #parsing }
SmaCCFGLRParser class >> parseAll: aString [
	"Returns all possible parse nodes that can be created from aString starting from any place in the parser."

	| parser |
	parser := self on: (ReadStream on: aString).
	parser scheduler registerAllFibers.
	parser scheduler shouldNotMerge.
	^ parser parse
]

{ #category : #parsing }
SmaCCFGLRParser class >> parseAll: aString startingAt: anInteger [
	"Returns all possible parse nodes that can be created from aString starting from state anInteger."

	| parser |
	parser := self on: (ReadStream on: aString).
	parser setStartingState: anInteger.
	parser scheduler shouldNotMerge.
	^ parser parse
]

{ #category : #parsing }
SmaCCFGLRParser class >> parseAll: aString startingAt: anInteger withScope: aSymbol [
	"Returns all possible parse nodes that can be created from aString starting from state anInteger in the parser with scanner state aSymbol."

	| parser |
	parser := self on: (ReadStream on: aString).
	parser setStartingState: anInteger.
	parser scope: aSymbol.
	parser scheduler shouldNotMerge.
	^ parser parse
]

{ #category : #parsing }
SmaCCFGLRParser class >> parseAll: aString withScope: aSymbol [
	"Returns all possible parse nodes that can be created from aString starting from any place in the parser with scanner state aSymbol."

	| parser |
	parser := self on: (ReadStream on: aString).
	parser scope: aSymbol.
	parser scheduler registerAllFibers.
	parser scheduler shouldNotMerge.
	^ parser parse
]

{ #category : #parsing }
SmaCCFGLRParser class >> parseAllScopes: aString startingAt: anInteger [
	"Returns all possible parse nodes that can be created from aString starting from any place in the parser."

	^ (self scannerClass states
		collect: [ :each |
			| parser |
			parser := self on: (ReadStream on: aString).
			parser scope: each.
			parser setStartingState: anInteger.
			parser scheduler shouldNotMerge.
			parser parse ]) flattened
]

{ #category : #parsing }
SmaCCFGLRParser class >> parseAllStartingStatesAndScopes: aString [
	"Returns all possible parse nodes that can be created from aString starting from any place in the parser."

	^ (self scannerClass states
		collect: [ :each |
			| parser |
			parser := self on: (ReadStream on: aString).
			parser scope: each.
			parser scheduler registerAllFibers.
			parser scheduler shouldNotMerge.
			parser parse ]) flattened
]

{ #category : #parsing }
SmaCCFGLRParser class >> parseAndCacheAll: aString [
	^ self cachedTrees at: (Array with: aString with: nil) ifAbsentPut: [ self parseAll: aString ]
]

{ #category : #parsing }
SmaCCFGLRParser class >> parseAndCacheAll: aString startingAt: anInteger [
	^ self cachedTrees at: (Array with: aString with: anInteger) ifAbsentPut: [ self parseAll: aString startingAt: anInteger ]
]

{ #category : #testing }
SmaCCFGLRParser class >> parserType [
	^ #fglr
]

{ #category : #accessing }
SmaCCFGLRParser class >> resetCaches [
	super resetCaches.
	cachedTrees := nil
]

{ #category : #accessing }
SmaCCFGLRParser class >> scannerClass [
	^ SmaCCFGLRScanner
]

{ #category : #accessing }
SmaCCFGLRParser class >> schedulerClass [
	^ SmaCCFGLRScheduler
]

{ #category : #private }
SmaCCFGLRParser >> actionsDo: aBlock [
	| row actionBlock |
	actionBlock := [ :action | 
	(self isAmbiguous: action)
		ifTrue: [ | ambiguous |
			ambiguous := OrderedCollection new.
			self ambiguousTransitionsAt: (action bitShift: -2) into: ambiguous.
			ambiguous do: aBlock ]
		ifFalse: [ aBlock value: action ] ].
	row := self transitionTable at: self currentState.
	(row at: 1) == 0
		ifTrue: [ actionBlock value: ((row at: 2) bitShift: 8) + (row at: 3) ]
		ifFalse: [ 2 to: row size by: 4 do: [ :i | actionBlock value: ((row at: i) bitShift: 8) + (row at: i + 1) ] ]
]

{ #category : #private }
SmaCCFGLRParser >> actionsForCurrentToken [
	| actions ids |
	ids := (fiber currentToken isKindOf: RfgMetavariableNode)
		ifTrue: [ OrderedCollection with: (fiber currentToken type typeId) ]
		ifFalse: [ fiber currentToken ids ].
	actions := OrderedCollection new: 1.
	self tryAllTokens
		ifTrue: [ ids do: [ :each | self addActionsFor: each to: actions ] ]
		ifFalse: [ self addActionsFor: ids first to: actions ].
	^ actions
]

{ #category : #private }
SmaCCFGLRParser >> addAction: action to: anOrderedCollection [
	(anOrderedCollection includes: action)
		ifTrue: [ ^ self ].
	anOrderedCollection add: action
]

{ #category : #private }
SmaCCFGLRParser >> addActionsFor: anInteger to: anOrderedCollection [
	| state |
	state := self currentState.
	self
		addActionsForState: state
		symbol: anInteger
		to: anOrderedCollection
]

{ #category : #private }
SmaCCFGLRParser >> addActionsForState: state symbol: anInteger to: anOrderedCollection [
	| action |
	action := self actionForState: state and: anInteger.
	action = self errorAction
		ifTrue: [ ^ self ].
	(self isAmbiguous: action)
		ifTrue: [ self
				ambiguousTransitionsAt: (action bitShift: -2)
				into: anOrderedCollection ]
		ifFalse: [ self addAction: action to: anOrderedCollection ]
]

{ #category : #private }
SmaCCFGLRParser >> ambiguousTransitions [
	^ #()
]

{ #category : #private }
SmaCCFGLRParser >> ambiguousTransitionsAt: anIndex into: anOrderedCollection [
	| ambiguousTransitions |
	ambiguousTransitions := self ambiguousTransitions at: anIndex.
	1 to: ambiguousTransitions size by: 2 do:
		[ :i | 
		self
			addAction:
				((ambiguousTransitions at: i) bitShift: 8)
					+ (ambiguousTransitions at: i + 1)
			to: anOrderedCollection ]
]

{ #category : #'error handling' }
SmaCCFGLRParser >> checkForErrors [
	"If we have an error correction installed, we might have handled the errors. If we did, we don't 
	want to return the result, so we raise a final exception that can't be proceeded."

	fiber errorToken isNil
		ifTrue: [ ^ self ].
	fiber currentToken: fiber errorToken.
	self reportErrorMessage: 'Token not expected'
]

{ #category : #accessing }
SmaCCFGLRParser >> currentState [
	^ fiber stateStack last
]

{ #category : #accessing }
SmaCCFGLRParser >> currentToken [
	^ fiber currentToken 
]

{ #category : #'error handling' }
SmaCCFGLRParser >> dismissErrorToken [
	fiber currentToken: nil.
	fiber nextAction: nil
]

{ #category : #'error handling' }
SmaCCFGLRParser >> dismissStackTopForErrorRecovery [
	fiber stateStack removeLast.
	^ fiber nodeStack removeLast
]

{ #category : #'error handling' }
SmaCCFGLRParser >> errorHandlerStates [
	^ fiber stateStack
		collect:
			[ :each | 
			| action |
			action := self actionForState: each and: self errorTokenId.
			(action bitAnd: self actionMask) = 1
				ifTrue: [ action bitShift: -2 ]
				ifFalse: [ 0 ] ]
]

{ #category : #accessing }
SmaCCFGLRParser >> fiber [
	^ fiber
]

{ #category : #private }
SmaCCFGLRParser >> fiberClass [
	^ SmaCCFGLRFiber 
]

{ #category : #'pattern-matching' }
SmaCCFGLRParser >> filterReduceActions: aCollection [
	^ aCollection reject: [ :action | (self isReduce: action) and: [ fiber nodeStack size - ((self reduceTable at: (action bitShift: -2)) at: 2) < 0 ] ]
]

{ #category : #private }
SmaCCFGLRParser >> filteredReduceActionsDo: aBlock [
	self
		actionsDo: [ :each | 
			(self isFilteredReduce: each)
				ifTrue: [ aBlock value: each ] ]
]

{ #category : #'error handling' }
SmaCCFGLRParser >> findErrorHandlerIfNoneUseErrorNumber: anInteger [
	| handlerStates index startingErrorToken |
	handlerStates := self errorHandlerStates reverse.
	startingErrorToken := fiber currentToken.
	[ index := (1 to: handlerStates size)
		detect:
			[ :each | 
			| state newStack |
			state := handlerStates at: each.
			state ~= 0
				and:
					[ newStack := fiber stateStack copyFrom: 1 to: handlerStates size - each + 1.
					newStack addLast: state.
					self willShift: newStack ] ]
		ifNone: [ nil ].
	index isNil ]
		whileTrue:
			[ self dismissErrorToken.
			self isEOFToken
				ifTrue:
					[ fiber currentToken: startingErrorToken.
					self reportError: anInteger ] ].
	index - 1 timesRepeat: [ self dismissStackTopForErrorRecovery ].
	fiber stateStack addLast: (handlerStates at: index).
	fiber nodeStack addLast: startingErrorToken
]

{ #category : #private }
SmaCCFGLRParser >> getNextToken [
	fiber currentToken isNil
		ifFalse: [ ^ self ].
	fiber currentToken: scanner next
]

{ #category : #'error handling' }
SmaCCFGLRParser >> handleError: anInteger [
	fiber errorToken isNil
		ifTrue: [ fiber errorToken: fiber currentToken ].
	(self isEOFToken or: [ self hasErrorHandler not ])
		ifTrue: [ self reportError: anInteger ].
	self findErrorHandlerIfNoneUseErrorNumber: anInteger
]

{ #category : #'initialize-release' }
SmaCCFGLRParser >> initialize [
	super initialize.
	scheduler := self class schedulerClass parser: self.
	fiber := self fiberClass id: 0
]

{ #category : #private }
SmaCCFGLRParser >> isAmbiguous: action [
	^ (action bitAnd: self actionMask) = 2r11
]

{ #category : #testing }
SmaCCFGLRParser >> isEOFToken [
	^ (fiber currentToken isKindOf: SmaCCToken) and: [ fiber currentToken ids first = self emptySymbolTokenId]
]

{ #category : #private }
SmaCCFGLRParser >> isFilteredReduce: anInteger [
	^ (self isReduce: anInteger) and: [ fiber nodeStack size - ((self reduceTable at: (anInteger bitShift: -2)) at: 2) >= 0 ]
]

{ #category : #testing }
SmaCCFGLRParser >> isReduce: anAction [
	^ (anAction bitAnd: self actionMask) == self reduceAction  
]

{ #category : #testing }
SmaCCFGLRParser >> isShift: anAction [
	^ (anAction bitAnd: self actionMask) == self shiftAction 
]

{ #category : #parsing }
SmaCCFGLRParser >> parse [
	| result |
	result := self performParsingLoop.
	(result respondsTo: #comments:)
		ifTrue: [ result comments: scanner comments ].
	^ result
]

{ #category : #'error handling' }
SmaCCFGLRParser >> partialReset [
	fiber nodeStack: OrderedCollection new.
	fiber stateStack: (OrderedCollection with: self class defaultStartingState).
	fiber errorToken: nil
]

{ #category : #'pattern-matching' }
SmaCCFGLRParser >> performActionForMetavariable: anAction [
	fiber currentToken type nodeType = #SmaCCToken
		ifTrue: [ self performAction: anAction ]
		ifFalse: [ self shift: (anAction bitShift: -2) ]
]

{ #category : #private }
SmaCCFGLRParser >> performParsingLoop [
	self setDefaultStartingStateIfNone.
	scheduler registerInitialFiberIfNone.
	^ scheduler start. 
]

{ #category : #parsing }
SmaCCFGLRParser >> popNodeStack [
	^ fiber nodeStack removeLast 
]

{ #category : #accessing }
SmaCCFGLRParser >> position [
	^ fiber currentToken isNil
		ifTrue: [ scanner position ]
		ifFalse: [ fiber currentToken startPosition ]
]

{ #category : #accessing }
SmaCCFGLRParser >> position: anInteger [
	fiber position: anInteger.
]

{ #category : #private }
SmaCCFGLRParser >> reduce: anInteger [
	| reduceEntry items size |
	reduceEntry := self reduceTable at: anInteger.
	items := Array new: (size := reduceEntry at: 2).
	fiber nodeStack size < size
		ifTrue: [ ^ scheduler unregister: fiber ].
	size to: 1 by: -1 do:
		[ :i | 
		items at: i put: self popNodeStack.
		fiber stateStack removeLast ].
	fiber nodeStack
		addLast: (self performReduceMethod: (reduceEntry at: 3) with: items).
	fiber stateStack
		addLast: ((self actionFor: (reduceEntry at: 1)) bitShift: -2)
]

{ #category : #private }
SmaCCFGLRParser >> reduceActionsDo: aBlock [
	self
		actionsDo: [ :each | 
			(each bitAnd: self actionMask) = self reduceAction
				ifTrue: [ aBlock value: each ] ]
]

{ #category : #forking }
SmaCCFGLRParser >> restoreFiber: aSmaCCFGLRFiber [
	fiber := aSmaCCFGLRFiber.
	scanner fiber: aSmaCCFGLRFiber
]

{ #category : #accessing }
SmaCCFGLRParser >> scanner: aSmaCCScanner [
	scanner := aSmaCCScanner.
	scanner fiber: fiber.
]

{ #category : #accessing }
SmaCCFGLRParser >> scheduler [
	^ scheduler
]

{ #category : #'initialize-release' }
SmaCCFGLRParser >> setDefaultStartingStateIfNone [
	fiber stateStack isEmpty
		ifTrue: [ self setStartingState: self class defaultStartingState ]
]

{ #category : #'initialize-release' }
SmaCCFGLRParser >> setStartingState: startingState [
	fiber stateStack: (OrderedCollection with: startingState)
]

{ #category : #private }
SmaCCFGLRParser >> shift: stateIndex [
	fiber stateStack addLast: stateIndex.
	fiber nodeStack addLast: fiber currentToken.
	fiber currentToken: nil
]

{ #category : #'pattern-matching' }
SmaCCFGLRParser >> shiftMetavariableNode: stateIndex [
	fiber stateStack addLast: stateIndex.
	fiber nodeStack addLast: fiber currentToken.
	fiber currentToken: nil
]

{ #category : #accessing }
SmaCCFGLRParser >> state [
	^ fiber state
]

{ #category : #accessing }
SmaCCFGLRParser >> state: aSymbol [
	fiber state: aSymbol
]

{ #category : #accessing }
SmaCCFGLRParser >> stateStack [
	^ fiber stateStack
]

{ #category : #'pattern-matching' }
SmaCCFGLRParser >> statesThatShift [
	^ (1 to: self transitionTable size)
		select:
			[ :each | 
			(1 to: self symbolTypes size)
				anySatisfy:
					[ :i | 
					| actions |
					actions := OrderedCollection new.
					self addActionsForState: each symbol: i to: actions.
					actions
						anySatisfy: [ :action | (action bitAnd: self actionMask) = self shiftAction ] ] ]
]

{ #category : #'pattern-matching' }
SmaCCFGLRParser >> typesFromCurrentState [
	| types |
	types := OrderedCollection new.
	self symbolTypes
		keysAndValuesDo: [ :symbol :type | 
			| actions |
			(symbol ~= scanner emptySymbolTokenId and: [ symbol ~= scanner errorTokenId ])
				ifTrue: [ actions := OrderedCollection new.
					self addActionsFor: symbol to: actions.
					(self filterReduceActions: actions)
						do: [ :each | 
							((self symbolTypes at: symbol) isNil or: [ (self symbolTypes at: symbol) = #OrderedCollection ])
								ifFalse: [ types
										addLast:
											(RfgTypeSpecification
												typeId: symbol
												symbolType: (self symbolNames at: symbol)
												nodeType: (self symbolTypes at: symbol)
												action: each) ] ] ] ].
	^ types
]

{ #category : #'error handling' }
SmaCCFGLRParser >> willShift: potentialStateStack [
	| action compoundAction reduceEntry size |
	compoundAction := self
		actionForState: potentialStateStack last
		and: fiber currentToken ids first.
	action := compoundAction bitAnd: self actionMask.
	action == self shiftAction
		ifTrue: [ ^ true ].
	action == self reduceAction
		ifTrue:
			[ reduceEntry := self reduceTable at: (compoundAction bitShift: -2).
			size := reduceEntry at: 2.
			size timesRepeat: [ potentialStateStack removeLast ].
			potentialStateStack
				add:
					((self
						actionForState: potentialStateStack last
						and: (reduceEntry at: 1)) bitShift: -2).
			^ self willShift: potentialStateStack ].
	^ false
]
