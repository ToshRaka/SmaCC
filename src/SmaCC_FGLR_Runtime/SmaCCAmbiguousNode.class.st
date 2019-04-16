"
I represent an ambiguous node in the Fibered-GLR algorithm.

I am used to merge multiple nodes resulting from an ambiguity into a single entity behaving similarly to a node.
I can forward messages to my children nodes.

I am created through the merging algorithm of SmaCCFGLRFiber.

Public API and Key Messages

- with: aSmaCCParseNode		| create a SmaCCAmbiguousNode with aSmaCCParseNode as child
- withAll: aCollection   			| create a SmaCCAmbiguousNode with all the nodes in aCollection as children			
 
Internal Representation and Key Implementation Points.

    Instance Variables
	possibleNodes:		<Collection>
"
Class {
	#name : #SmaCCAmbiguousNode,
	#superclass : #SmaCCParseNode,
	#instVars : [
		'possibleNodes'
	],
	#category : #'SmaCC_FGLR_Runtime-Core'
}

{ #category : #'instance creation' }
SmaCCAmbiguousNode class >> with: aSmaCCParseNodeOrCollection [
	^ self new 
		addPossibleNode: aSmaCCParseNodeOrCollection;
		yourself 
]

{ #category : #'instance creation' }
SmaCCAmbiguousNode class >> withAll: aCollection [
	^ self new 
		addPossibleNodes: aCollection;
		yourself 
]

{ #category : #comparing }
SmaCCAmbiguousNode >> = anObject [
	^ self == anObject
		or: [ self class = anObject class and: [ self possibleNodes = anObject possibleNodes ] ]
]

{ #category : #initialization }
SmaCCAmbiguousNode >> addPossibleNode: aSmaCCParseNode [
	possibleNodes addLast: aSmaCCParseNode 
]

{ #category : #initialization }
SmaCCAmbiguousNode >> addPossibleNode: aSmaCCParseNode ifNil: aBlock [
	aSmaCCParseNode ifNotNil: [ ^ possibleNodes addLast: aSmaCCParseNode ].
	^ aBlock value
]

{ #category : #initialization }
SmaCCAmbiguousNode >> addPossibleNodes: aSmaCCParseNodeCollection [
	"possibly check if not in here already"
	aSmaCCParseNodeCollection do: [ :each |
		self addPossibleNode: each ]
]

{ #category : #'reflective operations' }
SmaCCAmbiguousNode >> at: anIndex [
	^ self forward: (Message selector: #at:ifAbsent: arguments: {anIndex. [ ^nil ] }) 
]

{ #category : #'reflective operations' }
SmaCCAmbiguousNode >> doesNotUnderstand: aMessage [
	^ self forward: aMessage 
]

{ #category : #'reflective operations' }
SmaCCAmbiguousNode >> forward: aMessage [
	| node |
	node := SmaCCAmbiguousNode new.
	possibleNodes do: [ :each | 
		node addPossibleNode: (aMessage sendTo: each) ifNil: [ ^ nil ] ].
	^ OrderedCollection with: node
]

{ #category : #initialization }
SmaCCAmbiguousNode >> initialize [
	super initialize.
	possibleNodes := OrderedCollection new
]

{ #category : #initialization }
SmaCCAmbiguousNode >> possibleNodes [
	^ possibleNodes 
]

{ #category : #initialization }
SmaCCAmbiguousNode >> possibleNodes: aSmaCCParseNodeCollection [
	possibleNodes := aSmaCCParseNodeCollection
]

{ #category : #printing }
SmaCCAmbiguousNode >> printOn: aStream [
	aStream nextPutAll: 'AmN(';
		nextPutAll: possibleNodes first printString.
	self possibleNodes allButFirstDo: [ :each | 
		aStream nextPut: $,;
			nextPutAll: each printString ].
	aStream nextPut: $)
]
