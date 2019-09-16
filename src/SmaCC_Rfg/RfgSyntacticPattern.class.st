Class {
	#name : #RfgSyntacticPattern,
	#superclass : #RfgPattern,
	#instVars : [
		'startingState',
		'abstractMatches'
	],
	#category : #'SmaCC_Rfg-Matching'
}

{ #category : #'instance-creation' }
RfgSyntacticPattern class >> parserClass: aClass patternString: aString startingState: anInteger [
	^ (self parserClass: aClass patternString: aString)
		startingState: anInteger;
		yourself
	
]

{ #category : #accessing }
RfgSyntacticPattern >> concreteMatches [
	| cmatches |
	cmatches := abstractMatches flatCollect: [ :amatch | amatch concreteMatches ] as: RfgConcreteMatchCollection.
	^ cmatches purgeDuplicates
]

{ #category : #compiling }
RfgSyntacticPattern >> getAbstractMatches [
	"TODO: Should insert inputs when its possible"

	| trees |
	abstractMatches ifNotNil: [ ^ abstractMatches ].
	trees := (startingState
		ifNil: [ parserClass parseAllStartingStatesAndScopes: patternString ]
		ifNotNil: [ parserClass parseAllScopes: patternString startingAt: startingState ]) asSet asOrderedCollection.
	abstractMatches := (trees isKindOf: SmaCCParseNode)
		ifTrue: [ OrderedCollection with: (RfgAbstractMatch with: trees) ]
		ifFalse: [ trees collect: [ :each | RfgAbstractMatch with: each ] ].
	^ abstractMatches asOrderedCollection
]

{ #category : #matching }
RfgSyntacticPattern >> matchAgainst: aSmaCCParseNode [
	abstractMatches ifNil: [ self getAbstractMatches ].
	abstractMatches ifEmpty: [ ^ nil ].
	abstractMatches do: [ :each | each resetMatches ].
	^ self matchAgainstNode: aSmaCCParseNode. 
]

{ #category : #matching }
RfgSyntacticPattern >> matchAgainstNode: aSmaCCParseNode [
	abstractMatches do: [ :amatch | amatch matchAgainst: aSmaCCParseNode ].
	(aSmaCCParseNode isKindOf: SmaCCParseNode)
		ifTrue: [ aSmaCCParseNode sortedNodesAndTokens do: [ :each | self matchAgainstNode: each ] ].
	^ self concreteMatches
]

{ #category : #matching }
RfgSyntacticPattern >> matchAgainstSource: aString [
	^ self matchAgainst: (parserClass parse: aString)
]

{ #category : #matching }
RfgSyntacticPattern >> matchAgainstSource: aString withParser: aClass [
	^ self matchAgainst: (aClass parse: aString)
]

{ #category : #accessing }
RfgSyntacticPattern >> startingState: anInteger [
	startingState := anInteger
]
