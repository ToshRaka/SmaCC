"
I represent a cooperative (non-preemptive) scheduler for the Fibered-GLR algorithm, handling fibers as my scheduling unit.

I schedule fibers (SmaCCFGLRFiber) stored in 4 priority lists (reduces, shifts, waiting and accepted) depending on their next action.
If a fiber represent a failing parsing possibility, it will be unregistered from the scheduler.
If the parser reaches an ambiguity, I fork the current fiber.
I report back all the possible trees representing the input string.

I ask the SmaCCFGLRParser to execute fibers and ask fibers to merge if they are compatible.

Public API and Key Messages

- start								| start the scheduling process
- parser: aSmaCCFGLRParser 			| create a SmaCCFGLRScheduler with parser aSmaCCFGLRParser
 
Internal Representation and Key Implementation Points.

    Instance Variables
	accepted:		<OrderedCollection>
	lastId:			<Integer>
	parser:			<SmaCCFGLRParser>
	reduces:			<SortedCollection>
	shifts:			<OrderedCollection>
	shouldMerge:	<Boolean>
	waiting:			<OrderedCollection>

"
Class {
	#name : #SmaCCFGLRScheduler,
	#superclass : #Object,
	#instVars : [
		'reduces',
		'shifts',
		'waiting',
		'accepted',
		'parser',
		'lastId',
		'shouldMerge'
	],
	#category : #'SmaCC_FGLR_Runtime-Core'
}

{ #category : #accessing }
SmaCCFGLRScheduler class >> parser: aSmaCCSGLRParser [
	^ self
		new parser: aSmaCCSGLRParser;
		yourself
]

{ #category : #accessing }
SmaCCFGLRScheduler >> accepted [
	^ accepted
]

{ #category : #scheduling }
SmaCCFGLRScheduler >> executeFiber: aSmaCCFGLRFiber [
	(aSmaCCFGLRFiber currentToken isPattern)
		ifTrue: [ ^ parser performActionForMetavariable: aSmaCCFGLRFiber nextAction ].
	^ parser performAction: aSmaCCFGLRFiber nextAction


]

{ #category : #forking }
SmaCCFGLRScheduler >> forkFiber: aSmaCCFGLRFiber withActions: aCollection [
	aCollection
		ifNotEmpty: [ aCollection
				allButFirstDo: [ :action | self forkFiberWithAction: action ].
			self registerFiber: aSmaCCFGLRFiber withAction: aCollection first ]
]

{ #category : #'pattern-matching' }
SmaCCFGLRScheduler >> forkFiberForMetavariable: aSmaCCFLGRFiber [
	| inferredTypes |
	parser restoreFiber: aSmaCCFLGRFiber.
	inferredTypes := aSmaCCFLGRFiber currentToken 
		checkAgainst: parser typesFromCurrentState
		withParserClass: parser class.
	inferredTypes do: [ :each | self forkFiberWithMetavariableType: each ]
]

{ #category : #forking }
SmaCCFGLRScheduler >> forkFiberForNextActions: aSmaCCFGLRFiber [
	parser restoreFiber: aSmaCCFGLRFiber.
	(shouldMerge not and: [ parser isEOFToken ])
		ifTrue: [ parser
				filteredReduceActionsDo: [ :each | self forkFiberWithAction: each ].
			aSmaCCFGLRFiber isStackNode
				ifTrue: [ accepted addLast: aSmaCCFGLRFiber ] ]
		ifFalse: [ aSmaCCFGLRFiber currentToken isPattern
				ifTrue: [ self forkFiberForMetavariable: aSmaCCFGLRFiber ]
				ifFalse: [ self
						forkFiber: aSmaCCFGLRFiber
						withActions: (parser filterReduceActions: parser actionsForCurrentToken) ] ]
]

{ #category : #forking }
SmaCCFGLRScheduler >> forkFiberWithAction: anInteger [
	| newFiber |
	newFiber := parser fiber duplicateWithId: self newId.
	self registerFiber: newFiber withAction: anInteger
]

{ #category : #'pattern-matching' }
SmaCCFGLRScheduler >> forkFiberWithMetavariableNode: aSmaCCMetavariableNode [
	| newFiber |
	newFiber := parser fiber duplicateWithId: self newId.
	newFiber currentToken: aSmaCCMetavariableNode.
	self 
		registerFiber: newFiber 
		withAction: aSmaCCMetavariableNode type action
]

{ #category : #'pattern-matching' }
SmaCCFGLRScheduler >> forkFiberWithMetavariableType: aSmaCCMetavariableType [
	| newFiber |
	newFiber := parser fiber duplicateWithId: self newId.
	newFiber currentToken type mergeWithInferredType: aSmaCCMetavariableType.
	self 
		registerFiber: newFiber
		withAction: aSmaCCMetavariableType action
]

{ #category : #testing }
SmaCCFGLRScheduler >> hasNoFiber [
	^ reduces isEmpty and: [ shifts isEmpty and: [ waiting isEmpty and: [ accepted isEmpty ] ] ]
]

{ #category : #initialization }
SmaCCFGLRScheduler >> initialize [
	super initialize.
	reduces := SortedCollection new.
	reduces sortBlock: [ :first :second | 
			| firstSizePost secondSizePost |
			firstSizePost := first stateStack size - ((parser reduceTable at: (first nextAction bitShift: -2)) at: 2).
			secondSizePost := second stateStack size - ((parser reduceTable at: (second nextAction bitShift: -2)) at: 2).
			firstSizePost > secondSizePost ].
	shifts := OrderedCollection new.
	waiting := OrderedCollection new.
	accepted := OrderedCollection new.
	lastId := 0.
	shouldMerge := true
]

{ #category : #accessing }
SmaCCFGLRScheduler >> lastId [
	^ lastId
]

{ #category : #merging }
SmaCCFGLRScheduler >> mergeFiber: aSmaCCFLGRFiber [
	| otherFibers candidates currentFiber |
	currentFiber := aSmaCCFLGRFiber.
	otherFibers := (OrderedCollection withAll: reduces)
		addAll: shifts;
		addAll: waiting;
		yourself.
	candidates := otherFibers select: [ :each | currentFiber canBeMergedWith: each ].
	candidates 
		ifEmpty: [ ^ currentFiber ].
	currentFiber id: self newId.
	currentFiber mergeWith: candidates.
	candidates 
		do: [ :each | self unregisterFiber: each ].
	^ currentFiber
]

{ #category : #forking }
SmaCCFGLRScheduler >> newId [
	lastId := lastId + 1.
	^ lastId.
]

{ #category : #scheduling }
SmaCCFGLRScheduler >> nextReduce [
	^ reduces first
]

{ #category : #scheduling }
SmaCCFGLRScheduler >> nextShift [
	^ shifts first
]

{ #category : #accessing }
SmaCCFGLRScheduler >> parser: aSmaCCFGLRParser [
	parser := aSmaCCFGLRParser
]

{ #category : #scheduling }
SmaCCFGLRScheduler >> processWaitingList [
	[ waiting isEmpty ]
		whileFalse: [ | waitingFiber |
			waitingFiber := waiting removeFirst.
			waitingFiber nextAction = parser acceptAction
				ifTrue: [ accepted add: waitingFiber ]
				ifFalse: [ parser restoreFiber: waitingFiber.
					parser getNextToken.
					waitingFiber currentToken isPattern
						ifTrue: [ self forkFiberForMetavariable: waitingFiber ]
						ifFalse: [ self forkFiberForNextActions: waitingFiber ] ] ]
]

{ #category : #registering }
SmaCCFGLRScheduler >> registerAllFibers [
	parser statesThatShift
		do: [ :each |
			self registerFiber:
					(parser fiberClass
						stateStack: (OrderedCollection with: each)
						nodeStack: OrderedCollection new
						id: self newId
						scope: parser scope) ]
]

{ #category : #registering }
SmaCCFGLRScheduler >> registerFiber: aSmaCCFGLRFiber [
	aSmaCCFGLRFiber currentToken isNil
		ifTrue: [ ^ waiting add: aSmaCCFGLRFiber ].
	aSmaCCFGLRFiber nextAction = parser acceptAction
		ifTrue: [ ^ waiting addFirst: aSmaCCFGLRFiber ].
	(parser isReduce: aSmaCCFGLRFiber nextAction)
		ifTrue: [ ^ reduces add: aSmaCCFGLRFiber ].
	(parser isShift: aSmaCCFGLRFiber nextAction)
		ifTrue: [ ^ shifts add: aSmaCCFGLRFiber ].

]

{ #category : #registering }
SmaCCFGLRScheduler >> registerFiber: aSmaCCFGLRFiber withAction: anInteger [
	aSmaCCFGLRFiber nextAction: anInteger.
	self registerFiber: aSmaCCFGLRFiber
]

{ #category : #registering }
SmaCCFGLRScheduler >> registerInitialFiberIfNone [
	self hasNoFiber
		ifTrue:
			[ self registerFiber: parser fiber ]
]

{ #category : #scheduling }
SmaCCFGLRScheduler >> reschedule: aSmaCCFLGRFiber [
	aSmaCCFLGRFiber currentToken
		ifNil: [ waiting add: aSmaCCFLGRFiber ]
		ifNotNil: [ self forkFiberForNextActions: aSmaCCFLGRFiber ]
]

{ #category : #scheduling }
SmaCCFGLRScheduler >> scheduleFiber: aSmaCCFLGRFiber [
	| newThread |
	parser restoreFiber: aSmaCCFLGRFiber.
	self unregisterFiber: aSmaCCFLGRFiber.
	self executeFiber: aSmaCCFLGRFiber.
	newThread := shouldMerge 
		ifTrue: [ self mergeFiber: aSmaCCFLGRFiber ]
		ifFalse: [ aSmaCCFLGRFiber ].
	self reschedule: newThread
]

{ #category : #scheduling }
SmaCCFGLRScheduler >> schedulingLoop [
	[ [ reduces isNotEmpty or: [ shifts isNotEmpty ] ]
		whileTrue: [ 
			[ reduces isNotEmpty ]
				whileTrue: [ self scheduleFiber: self nextReduce ].
			shifts isNotEmpty
				ifTrue: [ self scheduleFiber: self nextShift ] ].
	waiting isNotEmpty ] 
		whileTrue: [ self processWaitingList ]
]

{ #category : #'pattern-matching' }
SmaCCFGLRScheduler >> shouldNotMerge [
	shouldMerge := false
]

{ #category : #scheduling }
SmaCCFGLRScheduler >> start [
	| trees |
	self schedulingLoop.
	trees := accepted collect: [ :each | each nodeStack first ].
	^ trees size = 1 ifTrue: [ trees first ] ifFalse: [ trees ]
]

{ #category : #registering }
SmaCCFGLRScheduler >> unregisterFiber: aSmaCCFLGRFiber [
	| action |
	action := aSmaCCFLGRFiber nextAction.
	(aSmaCCFLGRFiber currentToken isNil or: [ action = parser acceptAction ])
		ifTrue: [ ^ waiting remove: aSmaCCFLGRFiber ].
	(parser isReduce: action)
		ifTrue: [ ^ reduces remove: aSmaCCFLGRFiber ].
	(parser isShift: action)
		ifTrue: [ ^ shifts remove: aSmaCCFLGRFiber ].
	^ nil
]
