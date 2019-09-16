Class {
	#name : #RfgORTypeSpecification,
	#superclass : #RfgCompositeTypeSpecification,
	#category : #'SmaCC_Rfg-Types'
}

{ #category : #'as yet unclassified' }
RfgORTypeSpecification >> checkAgainst: aCollection withParserClass: aClass [
	super checkAgainst: aCollection withParserClass: aClass.
	^ aCollection select: [ :each | 
		subtypes anySatisfy: [ :subtype | subtype matchInferredType: each ] ]
]
