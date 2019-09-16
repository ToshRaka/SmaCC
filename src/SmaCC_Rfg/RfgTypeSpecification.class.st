Class {
	#name : #RfgTypeSpecification,
	#superclass : #RfgAbstractTypeSpecification,
	#instVars : [
		'typeId',
		'symbolType',
		'nodeType',
		'action'
	],
	#category : #'SmaCC_Rfg-Types'
}

{ #category : #'instance creation' }
RfgTypeSpecification class >> nodeType: aString [
	^ self new
		nodeType: aString;
		yourself
]

{ #category : #'instance creation' }
RfgTypeSpecification class >> symbolType: aString nodeType: bString [
	^ self new
		symbolType: aString;
		nodeType: bString;
		yourself
]

{ #category : #'instance creation' }
RfgTypeSpecification class >> typeId: anInteger symbolType: aString nodeType: bString action: bInteger [
	^ self new
		typeId: anInteger;
		symbolType: aString;
		nodeType: bString;
		action: bInteger;
		yourself
]

{ #category : #comparing }
RfgTypeSpecification >> = aRfgTypeSpecification [
	^ self class = aRfgTypeSpecification class
		and: [ (self valueEquivalentTo: aRfgTypeSpecification)
				and: [ self cardinalityEquivalentTo: aRfgTypeSpecification ] ]
]

{ #category : #accessing }
RfgTypeSpecification >> action [
	^ action
]

{ #category : #accessing }
RfgTypeSpecification >> action: anObject [
	action := anObject
]

{ #category : #'as yet unclassified' }
RfgTypeSpecification >> checkAgainst: aCollection withParserClass: aClass [
	| validTypes |
	super checkAgainst: aCollection withParserClass: aClass.
	validTypes := aCollection select: [ :each | self matchInferredType: each ].
	validTypes := validTypes
		ifEmpty: [ aCollection select: [ :each | self subtypeOf: each ] ].
	validTypes do: [ :each | self copyCardinalityTo: each ].
	^ validTypes
]

{ #category : #accessing }
RfgTypeSpecification >> current [
	^ self
]

{ #category : #comparing }
RfgTypeSpecification >> matchInferredType: aRfgTypeSpecification [
	"Way more understandable with ifTrue/ifFalse than and/or"
	(nodeType isNil and: [ symbolType isNil ])
		ifTrue: [ ^ true ].
	aRfgTypeSpecification nodeType = nodeType
		ifTrue: [ nodeType = #SmaCCToken
			ifTrue: [ ^ aRfgTypeSpecification symbolType = symbolType ]
			ifFalse: [ ^ true ] ].
	^ false
]

{ #category : #'as yet unclassified' }
RfgTypeSpecification >> mergeWithInferredType: aRfgTypeSpecification [
	typeId := aRfgTypeSpecification typeId.
	action := aRfgTypeSpecification action.
	symbolType := aRfgTypeSpecification symbolType.
	nodeType ifNil: [ nodeType := aRfgTypeSpecification nodeType ]
]

{ #category : #accessing }
RfgTypeSpecification >> next [
	^ nil
]

{ #category : #accessing }
RfgTypeSpecification >> nodeType [
	^ nodeType
]

{ #category : #accessing }
RfgTypeSpecification >> nodeType: anObject [
	nodeType := anObject
]

{ #category : #comparing }
RfgTypeSpecification >> subtypeOf: aRfgTypeSpecification [
	^ nodeType ~= #SmaCCToken
		and: [ ((self class environment at: nodeType)
				includesBehavior: (self class environment at: aRfgTypeSpecification nodeType))
				and: [ aRfgTypeSpecification nodeType: nodeType.
					true ] ]
]

{ #category : #accessing }
RfgTypeSpecification >> symbolType [
	^ symbolType
]

{ #category : #accessing }
RfgTypeSpecification >> symbolType: anObject [
	symbolType := anObject
]

{ #category : #accessing }
RfgTypeSpecification >> typeId [
	^ typeId
]

{ #category : #accessing }
RfgTypeSpecification >> typeId: anObject [
	typeId := anObject
]

{ #category : #comparing }
RfgTypeSpecification >> valueEquivalentTo: aRfgTypeSpecification [
	^ nodeType = aRfgTypeSpecification nodeType
		and: [ symbolType = aRfgTypeSpecification symbolType
				and: [ action = aRfgTypeSpecification action
						and: [ typeId = aRfgTypeSpecification typeId ] ] ]
]
