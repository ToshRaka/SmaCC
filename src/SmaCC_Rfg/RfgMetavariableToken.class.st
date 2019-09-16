Class {
	#name : #RfgMetavariableToken,
	#superclass : #SmaCCToken,
	#instVars : [
		'identifier',
		'type',
		'metaparent'
	],
	#category : #'SmaCC_Rfg-Types'
}

{ #category : #converting }
RfgMetavariableToken >> asNodeWithType: aRfgAbstractTypeSpecification [
	| node |
	node := RfgMetavariableNode identifier: identifier.
	node type: aRfgAbstractTypeSpecification.
	node metaparent: metaparent.
	metaparent ifNotNil: [ metaparent metachildren addLast: node ].
	^ node 
]

{ #category : #'as yet unclassified' }
RfgMetavariableToken >> checkAgainst: aCollection withParserClass: aClass [
	^ type checkAgainst: aCollection withParserClass: aClass
]

{ #category : #accessing }
RfgMetavariableToken >> identifier [
	^ identifier
]

{ #category : #accessing }
RfgMetavariableToken >> identifier: anObject [
	identifier := anObject
]

{ #category : #testing }
RfgMetavariableToken >> isPattern [
	^ true
]

{ #category : #accessing }
RfgMetavariableToken >> metaparent [
	^ metaparent
]

{ #category : #accessing }
RfgMetavariableToken >> metaparent: anObject [
	metaparent := anObject
]

{ #category : #copying }
RfgMetavariableToken >> postCopy [
	super postCopy.
	type := type copy
]

{ #category : #printing }
RfgMetavariableToken >> printOn: aStream [
	aStream
		nextPut: ${;
		nextPutAll: self identifier;
		nextPut: $:;
		nextPutAll: self type printString;
		nextPutAll: '}'
]

{ #category : #accessing }
RfgMetavariableToken >> type [
	^ type
]

{ #category : #accessing }
RfgMetavariableToken >> type: anObject [
	type := anObject
]
