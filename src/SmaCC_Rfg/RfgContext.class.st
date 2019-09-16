Class {
	#name : #RfgContext,
	#superclass : #OrderedDictionary,
	#category : #'SmaCC_Rfg-Matching'
}

{ #category : #accessing }
RfgContext class >> newFromKey: aRfgMetavariableNode andValue: aSmaCCParseNode [
	^ self new
		at:aRfgMetavariableNode put: aSmaCCParseNode;
		yourself
]

{ #category : #accessing }
RfgContext >> at: aRfgMetavariableNode ifAbsentPut: aCollectionOrNode [
	(self includesKey: aRfgMetavariableNode)
		ifFalse: [ | metaparent |
			metaparent := aRfgMetavariableNode metaparent.
			metaparent
				ifNotNil: [ (self includesKey: metaparent)
						ifTrue: [ ^ (self at: metaparent)
								at: aRfgMetavariableNode
								put: aCollectionOrNode ]
						ifFalse: [ ^ (self at: metaparent put: self class new)
								at: aRfgMetavariableNode
								put: aCollectionOrNode ] ] ].
	^ self at: aRfgMetavariableNode put: aCollectionOrNode
]

{ #category : #accessing }
RfgContext >> atNamed: aString [
	self keysAndValuesDo: [ :key :val |
		(key identifier = aString)
			ifTrue: [ ^ val ] ].
	^ nil
]

{ #category : #accessing }
RfgContext >> atNamed: aString ifAbsent: aBlock [
	^ self at: (self keyAtNamed: aString) ifAbsent: aBlock.
	
]

{ #category : #accessing }
RfgContext >> atNamed: aString ifAbsentPut: anObject [
	^ self at: (self keyAtNamed: aString) ifAbsentPut: anObject.
	
]

{ #category : #'as yet unclassified' }
RfgContext >> import: aString from: aRfgContext [
	^ self atNamed: aString ifAbsentPut: (aRfgContext atNamed: aString) copy
]

{ #category : #testing }
RfgContext >> isDuplicateWith: aRfgContext [
	self size = aRfgContext size
		ifFalse: [ ^ false ].
	self keysAndValuesDo: [ :key :val |
		| keyb valb |
		keyb := aRfgContext keyAtNamed: key identifier.
		keyb ifNil: [ ^ false ].
		valb := aRfgContext at: keyb.
		val = valb
			ifFalse: [ ^ false ].
		key = keyb 
			or: [ 
				| classa classb |	
				classa := self class environment at: key type nodeType.
				classb := self class environment at: keyb type nodeType.
				((classa includesBehavior: classb) or: [ classb includesBehavior: classa ])
					ifFalse: [ ^ false ]
			]
		 ].
	^ true
]

{ #category : #accessing }
RfgContext >> keyAtNamed: aString [
	self keysAndValuesDo: [ :key :val |
		(key identifier = aString)
			ifTrue: [ ^ key ] ].
	^ nil
]

{ #category : #accessing }
RfgContext >> mergeWith: aRfgContext [
	| conflicting |
	conflicting := OrderedCollection new.
	aRfgContext keysAndValuesDo: [ :key :val | self at: key ifPresent: [ conflicting add: key ] ifAbsentPut: val ].
	^ conflicting
	
]

{ #category : #removing }
RfgContext >> removeNamed: aString [
	^ self removeKey: (self keyAtNamed: aString)
]

{ #category : #'as yet unclassified' }
RfgContext >> sourceAtNamed: aString [
	| val |
	val := self atNamed: aString.
	^ (val isKindOf: Collection)
		ifTrue: [ (val collect: [ :each | each source ]) concatenation ]
		ifFalse: [ val source ]
]

{ #category : #'as yet unclassified' }
RfgContext >> sourceAtNamed: aString ifAbsent: aBlock [
	| val |
	val := self atNamed: aString.
	val ifNil: [ ^ aBlock value ].
	^ (val isKindOf: Collection)
		ifTrue: [ (val collect: [ :each | each source ]) concatenation ]
		ifFalse: [ (val isKindOf: SmaCCParseNode)
				ifTrue: [ val source ]
				ifFalse: [ val value ] ]
]

{ #category : #'as yet unclassified' }
RfgContext >> valueAtIndex: anInteger [
	anInteger > self size
		ifTrue: [ ^ nil ].
	^ self at: (self keyAtIndex: anInteger)
]
