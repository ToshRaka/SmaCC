Class {
	#name : #RfgMetavariableNode,
	#superclass : #SmaCCParseNode,
	#instVars : [
		'identifier',
		'type',
		'origin',
		'metaparent',
		'metachildren'
	],
	#category : #'SmaCC_Rfg-Types'
}

{ #category : #'instance creation' }
RfgMetavariableNode class >> identifier: aString [
	^ self new 
		identifier: aString;
		yourself
]

{ #category : #'instance creation' }
RfgMetavariableNode class >> identifier: aString type: aRfgTypeSpecification [
	^ self new 
		identifier: aString;
		type: aRfgTypeSpecification;
		yourself
]

{ #category : #'instance creation' }
RfgMetavariableNode class >> origin: aString [
	^ self new 
		origin: aString;
		identify;
		yourself
]

{ #category : #comparing }
RfgMetavariableNode >> = aRfgMetavariableNode [
	^ self class = aRfgMetavariableNode class
		and: [ self identifier = aRfgMetavariableNode identifier
			and: [ self type = aRfgMetavariableNode type ] ]
]

{ #category : #accessing }
RfgMetavariableNode >> beNonGreedy [
	type beNonGreedy
]

{ #category : #accessing }
RfgMetavariableNode >> beOption [
	type beOption
]

{ #category : #accessing }
RfgMetavariableNode >> bePlus [
	type bePlus
]

{ #category : #accessing }
RfgMetavariableNode >> beStar [
	type beStar
]

{ #category : #matching }
RfgMetavariableNode >> greedyMatchCollection: matchNodes index: matchIndex to: programNodes index: programIndex inContext: aRfgContext [
	| currentIndex currentNodes |
	currentIndex := programIndex.
	currentNodes := OrderedCollection new.
	[ currentIndex <= programNodes size
		and: [ (self syntacticMatch: (programNodes at: currentIndex))
				and: [ currentNodes addLast: (programNodes at: currentIndex).
					true ] ] ] whileTrue: [ currentIndex := currentIndex + 1 ].
	(currentNodes isEmpty and: [ self isStar not ])
		ifTrue: [ ^ false ].
	(aRfgContext at: self ifAbsentPut: currentNodes) = currentNodes
		ifFalse: [ ^ false ].
	"(type cardinality matchSize: currentNodes size)
		ifFalse: [ ^ false ]."
	matchNodes size < (matchIndex + 1)
		ifTrue: [ ^ currentIndex > programNodes size ].
	^ (matchNodes at: matchIndex + 1)
		syntacticMatchCollection: matchNodes
		index: matchIndex + 1
		to: programNodes
		index: currentIndex
		inContext: aRfgContext
]

{ #category : #accessing }
RfgMetavariableNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RfgMetavariableNode >> identifier: anObject [
	identifier := anObject
]

{ #category : #initialization }
RfgMetavariableNode >> identify [
	
	identifier := origin ifNotNil: [
		(origin indexOf: $: ifAbsent: [ nil ])
			ifNotNil: [ :index | origin copyFrom: 1 to: index - 1 ]
			ifNil: [ origin copy ] ]
]

{ #category : #accessing }
RfgMetavariableNode >> isGreedy [
	^ type cardinality isGreedy
]

{ #category : #accessing }
RfgMetavariableNode >> isOption [
	^ type cardinality isOption
]

{ #category : #accessing }
RfgMetavariableNode >> isPlus [
	^ type cardinality isPlus
]

{ #category : #accessing }
RfgMetavariableNode >> isStar [
	^ type cardinality isStar
]

{ #category : #accessing }
RfgMetavariableNode >> metachildren [
	metachildren ifNil: [ metachildren := OrderedCollection new ].
	^ metachildren
]

{ #category : #accessing }
RfgMetavariableNode >> metachildren: anObject [
	metachildren := anObject
]

{ #category : #accessing }
RfgMetavariableNode >> metaparent [
	^ metaparent
]

{ #category : #accessing }
RfgMetavariableNode >> metaparent: anObject [
	metaparent := anObject
]

{ #category : #matching }
RfgMetavariableNode >> nonGreedyMatchCollection: matchNodes index: matchIndex to: programNodes index: programIndex inContext: aRfgContext [
	| currentIndex currentContext currentNodes |
	currentIndex := programIndex - 1.
	[ currentContext := aRfgContext copy.
		programNodes size < currentIndex
		or:
			[ (self
				syntacticMatchCollection: matchNodes
				index: matchIndex + 1
				to: programNodes
				index: currentIndex + 1
				inContext: currentContext)
					and:
						[ currentNodes := programNodes copyFrom: programIndex to: currentIndex.
							(self syntacticMatch: currentNodes inContext: currentContext)
								ifTrue:
									[ currentContext
										keysAndValuesDo: [ :key :value | aRfgContext at: key put: value ].
									^ true ].
						false ] ] ] whileFalse: [ currentIndex := currentIndex + 1 ].
	"Not sure this should be here"
	(currentNodes isEmpty and: [ self isStar not ])
		ifTrue: [ ^ false ].
	(aRfgContext at: self ifAbsentPut: currentNodes) = currentNodes
		ifFalse: [ ^ false ].
	matchNodes size < (matchIndex + 1)
		ifTrue: [ ^ programNodes size = currentIndex ].
	^ (matchNodes at: matchIndex + 1)
		syntacticMatchCollection: matchNodes
		index: matchIndex + 1
		to: programNodes
		index: programIndex + 1
		inContext: aRfgContext

]

{ #category : #accessing }
RfgMetavariableNode >> origin [
	^ origin
]

{ #category : #accessing }
RfgMetavariableNode >> origin: aString [
	origin := aString
]

{ #category : #printing }
RfgMetavariableNode >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: identifier printString;
		nextPut: $)
]

{ #category : #matching }
RfgMetavariableNode >> syntacticMatch: aSmaCCParseNode [
	^ (self syntacticMatchToken: aSmaCCParseNode)
		or: [ (self syntacticMatchNode: aSmaCCParseNode)
			or: [ self syntacticMatchCollection: aSmaCCParseNode] ]
]

{ #category : #matching }
RfgMetavariableNode >> syntacticMatch: aSmaCCParseNode inContext: aRfgContext [	
	^ (self syntacticMatch: aSmaCCParseNode)
		and: [ (type cardinality isPlus or: [ type cardinality isStar ]) not 
			and: [ (aRfgContext at: self ifAbsentPut: aSmaCCParseNode) = aSmaCCParseNode ] ]
]

{ #category : #matching }
RfgMetavariableNode >> syntacticMatchCollection: aCollection [
	(aCollection isKindOf: Collection)
		ifFalse: [ ^ false ].
	aCollection isEmpty
		ifTrue: [ ^ self isStar ].
	^ (self isStar 	or: [ self isPlus ])
			and: [ aCollection allSatisfy: [ :each | self syntacticMatch: each ] ]
]

{ #category : #matching }
RfgMetavariableNode >> syntacticMatchNode: aSmaCCParseNode [
	^ (aSmaCCParseNode isKindOf: SmaCCParseNode)
		and: [ aSmaCCParseNode class asString asSymbol = type nodeType
			"Big problem here"
			or: [ aSmaCCParseNode class includesBehavior: (self class environment at: type nodeType) ] ]
]

{ #category : #matching }
RfgMetavariableNode >> syntacticMatchToken: aSmaCCToken [
	^ aSmaCCToken class = SmaCCToken and: [ aSmaCCToken ids first = type typeId ]
]

{ #category : #accessing }
RfgMetavariableNode >> type [
	^ type
]

{ #category : #accessing }
RfgMetavariableNode >> type: anObject [
	type := anObject
]
