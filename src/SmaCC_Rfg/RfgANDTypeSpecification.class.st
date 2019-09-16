Class {
	#name : #RfgANDTypeSpecification,
	#superclass : #RfgCompositeTypeSpecification,
	#category : #'SmaCC_Rfg-Types'
}

{ #category : #'as yet unclassified' }
RfgANDTypeSpecification >> checkAgainst: aCollection withParserClass: aClass [
	super checkAgainst: aCollection withParserClass: aClass.
	^ subtypes first
		checkAgainst: aCollection
		withParserClass: aClass
]

{ #category : #accessing }
RfgANDTypeSpecification >> current [
	^ subtypes first
]

{ #category : #'as yet unclassified' }
RfgANDTypeSpecification >> mergeWithInferredType: aRfgTypeSpecification [
	subtypes first mergeWithInferredType: aRfgTypeSpecification
]

{ #category : #accessing }
RfgANDTypeSpecification >> next [
	subtypes size = 1
		ifTrue: [ ^ nil ].
	subtypes removeFirst.
	^ self
]
