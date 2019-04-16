"
I represent a Fibered-GLR cooperative scheduling fiber. 

I hold all the parser internals for a specific parsing alternative, mainly the LR state stack, the AST node stack, the position of the parser, the current token lookahead and the next action to be executed on me. I can merge with other fibers if they are in a compatible state.

The SmaCCFGLRScheduler schedules me, copies me when it finds an ambiguity (fork), and ask me to merge after each of my executions.
The SmaCCFGLRParser executes my next action on my parser internals.

Public API and Key Messages

- canBeMergedWith: aSmaCCFGLRFiber 		| checks whether I can be merged with aSmaCCFGLRFiber
- mergeWith: aCollection 					| merge my nodes with those of the fibers in aCollection
- duplicateWithId: anInteger 				| create a return a copy of the fiber with the id anInteger

Internal Representation and Key Implementation Points.

    Instance Variables
	attributes:		<Dictionary>
	comments:		<Object>
	currentToken:	<SmaCCToken>
	errorToken:		<SmaCCToken>
	id:				<Integer>
	nextAction:		<Integer>
	nodeStack:		<OrderedCollection>
	position:			<Integer>
	state:			<Integer>
	stateStack:		<OrderedCollection>


    Implementation Points
"
Class {
	#name : #SmaCCFGLRFiber,
	#superclass : #Object,
	#instVars : [
		'id',
		'stateStack',
		'nodeStack',
		'currentToken',
		'errorToken',
		'nextAction',
		'position',
		'scope',
		'comments',
		'attributes'
	],
	#category : #'SmaCC_FGLR_Runtime-Core'
}

{ #category : #'instance creation' }
SmaCCFGLRFiber class >> id: anInteger [
	^ self new
		id: anInteger;
		yourself
]

{ #category : #'instance creation' }
SmaCCFGLRFiber class >> stateStack: stateStack nodeStack: nodeStack [
	^ self new
		stateStack: stateStack nodeStack: nodeStack;
		yourself
]

{ #category : #'instance creation' }
SmaCCFGLRFiber class >> stateStack: stateStack nodeStack: nodeStack id: anInteger [
	^ self new
		stateStack: stateStack nodeStack: nodeStack;
		id: anInteger;
		yourself
]

{ #category : #'instance creation' }
SmaCCFGLRFiber class >> stateStack: stateStack nodeStack: nodeStack id: anInteger scannerState: aSymbol [
	^ self new
		stateStack: stateStack nodeStack: nodeStack;
		id: anInteger;
		state: aSymbol;
		yourself
]

{ #category : #comparing }
SmaCCFGLRFiber >> = anObject [
	^ self == anObject
		or: [ self class = anObject class
			and: [ self id = anObject id
				and: [ self stateStack = anObject stateStack
					and: [ self nodeStack = anObject nodeStack
						and: [ self scannerThread = anObject scannerThread 
							and: [ self nextAction = anObject nextAction ] ] ] ] ] ]
]

{ #category : #'accessing-attributes' }
SmaCCFGLRFiber >> attributeNamed: aSymbol [
	^attributes ifNil: [ nil ] ifNotNil: [ attributes at: aSymbol ]
]

{ #category : #'accessing-attributes' }
SmaCCFGLRFiber >> attributeNamed: aSymbol put: aValue [
	(attributes ifNil: [ attributes := Dictionary new ]) at: aSymbol put: aValue
]

{ #category : #testing }
SmaCCFGLRFiber >> canBeMergedWith: aSmaCCParserState [
	^ self stateStack = aSmaCCParserState stateStack
		and: [ self position = aSmaCCParserState position 
			and: [ self state = aSmaCCParserState state ] ]
]

{ #category : #accessing }
SmaCCFGLRFiber >> comments [
	^ comments
]

{ #category : #accessing }
SmaCCFGLRFiber >> comments: anObject [
	comments := anObject
]

{ #category : #accessing }
SmaCCFGLRFiber >> currentToken [
	^ currentToken
]

{ #category : #accessing }
SmaCCFGLRFiber >> currentToken: aSmaCCToken [
	currentToken := aSmaCCToken 
]

{ #category : #copying }
SmaCCFGLRFiber >> duplicateWithId: anInteger [
	| newThread |
	newThread := self copy.
	newThread stateStack: stateStack copy nodeStack: nodeStack copy.
	newThread currentToken: currentToken copy.
	newThread nextAction: nextAction copy.
	newThread position: position copy.
	newThread state: scope copy.
	newThread comments: comments copy.
	newThread id: anInteger.
	^ newThread 
]

{ #category : #accessing }
SmaCCFGLRFiber >> errorToken [
	^ errorToken
]

{ #category : #accessing }
SmaCCFGLRFiber >> errorToken: anObject [
	errorToken := anObject
]

{ #category : #accessing }
SmaCCFGLRFiber >> id [
	^ id 
]

{ #category : #accessing }
SmaCCFGLRFiber >> id: anInteger [
	id := anInteger 
]

{ #category : #initialization }
SmaCCFGLRFiber >> initialize [
	super initialize.
	stateStack := OrderedCollection new.
	nodeStack := OrderedCollection new.
	currentToken := nil.
	errorToken := nil.
	nextAction := nil.
	position := 0.
	scope := #default
]

{ #category : #testing }
SmaCCFGLRFiber >> isStackNode [
	^ nodeStack size = 1 and: [ nodeStack first isKindOf: SmaCCParseNode ]
]

{ #category : #merging }
SmaCCFGLRFiber >> merge: aCollection andPullDown: aSmaCCNodeOrCollection [
	| collectionClasses defaultBlock |
	defaultBlock := [ SmaCCAmbiguousNode
		withAll:
			(aCollection
				addLast: aSmaCCNodeOrCollection;
				yourself) ].
	(aCollection allSatisfy: [ :each | each = aSmaCCNodeOrCollection ])
		ifTrue: [ ^ aSmaCCNodeOrCollection ].
	collectionClasses := {Array. OrderedCollection}.
	((collectionClasses includes: aSmaCCNodeOrCollection class)
		and: [ aCollection allSatisfy: [ :each | collectionClasses includes: each class ] ])
		ifTrue: [ | indexes newNode |
			(aCollection allSatisfy: [ :each | aSmaCCNodeOrCollection size = each size ])
				ifFalse: [ ^ defaultBlock value ].
			indexes := OrderedCollection new.
			aSmaCCNodeOrCollection
				withIndexDo: [ :item :index | 
					(aCollection anySatisfy: [ :each | (each at: index) ~= item ])
						ifTrue: [ indexes addLast: index ] ].
			indexes size = 1
				ifFalse: [ ^ defaultBlock value ].
			newNode := self
				merge: (aCollection collect: [ :each | each at: indexes first ])
				andPullDown: (aSmaCCNodeOrCollection at: indexes first).
			^ aSmaCCNodeOrCollection
				at: indexes first put: newNode;
				yourself ].
	(aCollection
		allSatisfy: [ :each | (each isKindOf: SmaCCParseNode) and: [ each class = aSmaCCNodeOrCollection class ] ])
		ifTrue: [ | childSelectors oldNode newNode |
			childSelectors := OrderedCollection new.
			aSmaCCNodeOrCollection variableSelectors
				do: [ :selectors | 
					(aSmaCCNodeOrCollection perform: selectors)
						do: [ :selector | 
							(aCollection allSatisfy: [ :each | (each perform: selector) ~= (aSmaCCNodeOrCollection perform: selector) ])
								ifTrue: [ childSelectors addLast: selector ] ] ].
			childSelectors size = 1
				ifFalse: [ ^ defaultBlock value ].
			oldNode := aSmaCCNodeOrCollection perform: childSelectors first.
			newNode := self merge: (aCollection collect: [ :each | each perform: childSelectors first ]) andPullDown: oldNode.
			^ aSmaCCNodeOrCollection perform: (aSmaCCNodeOrCollection convertToSetter: childSelectors first) with: newNode ].
	^ defaultBlock value
]

{ #category : #merging }
SmaCCFGLRFiber >> mergeWith: aCollection [
	| nodes newNode |
	nodes := aCollection collect: [ :each | each nodeStack last ].
	newNode := self merge: nodes andPullDown: nodeStack last .
	nodeStack removeLast.
	nodeStack addLast: newNode.
	
]

{ #category : #accessing }
SmaCCFGLRFiber >> nextAction [
	^ nextAction 
]

{ #category : #accessing }
SmaCCFGLRFiber >> nextAction: anInteger [
	nextAction := anInteger
]

{ #category : #accessing }
SmaCCFGLRFiber >> nodeStack [
	^ nodeStack
]

{ #category : #accessing }
SmaCCFGLRFiber >> nodeStack: anObject [
	nodeStack := anObject
]

{ #category : #accessing }
SmaCCFGLRFiber >> position [
	^ position
]

{ #category : #accessing }
SmaCCFGLRFiber >> position: anObject [
	position := anObject
]

{ #category : #copying }
SmaCCFGLRFiber >> postCopy [
	super postCopy.
	attributes notNil
		ifTrue: [ attributes := attributes copy ]
]

{ #category : #printing }
SmaCCFGLRFiber >> printOn: aStream [
	aStream nextPut: ${.
	self stateStack printElementsOn: aStream.
	aStream nextPut: $,.
	self nodeStack printElementsOn: aStream.
	aStream nextPut: $;;
		nextPutAll: self nextAction printString;
		nextPut: $;.
	self currentToken printOn: aStream.
	aStream nextPut: $}
]

{ #category : #accessing }
SmaCCFGLRFiber >> scope [
	^ scope
]

{ #category : #accessing }
SmaCCFGLRFiber >> scope: anObject [
	scope := anObject
]

{ #category : #accessing }
SmaCCFGLRFiber >> stateStack [
	^ stateStack
]

{ #category : #accessing }
SmaCCFGLRFiber >> stateStack: anObject [
	stateStack := anObject
]

{ #category : #accessing }
SmaCCFGLRFiber >> stateStack: stateCollection nodeStack: nodeCollection [
	stateStack := stateCollection.
	nodeStack := nodeCollection.
]
