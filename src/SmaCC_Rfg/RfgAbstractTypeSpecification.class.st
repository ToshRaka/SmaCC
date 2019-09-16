Class {
	#name : #RfgAbstractTypeSpecification,
	#superclass : #Object,
	#instVars : [
		'cardinality',
		'parserClass'
	],
	#category : #'SmaCC_Rfg-Types'
}

{ #category : #accessing }
RfgAbstractTypeSpecification >> beNonGreedy [
	cardinality beNonGreedy
]

{ #category : #accessing }
RfgAbstractTypeSpecification >> beOption [
	cardinality beOption 
]

{ #category : #accessing }
RfgAbstractTypeSpecification >> bePlus [
	cardinality bePlus
]

{ #category : #accessing }
RfgAbstractTypeSpecification >> beStar [
	cardinality beStar
]

{ #category : #accessing }
RfgAbstractTypeSpecification >> cardinality [
	^ cardinality
]

{ #category : #accessing }
RfgAbstractTypeSpecification >> cardinality: anObject [
	cardinality := anObject
]

{ #category : #comparing }
RfgAbstractTypeSpecification >> cardinalityEquivalentTo: aRfgAbstractTypeSpecification [
	^ self cardinality = aRfgAbstractTypeSpecification cardinality
]

{ #category : #'as yet unclassified' }
RfgAbstractTypeSpecification >> checkAgainst: aCollection withParserClass: aClass [
	self parserClass: aClass
]

{ #category : #'as yet unclassified' }
RfgAbstractTypeSpecification >> copyCardinalityTo: aRfgAbstractTypeSpecification [
	aRfgAbstractTypeSpecification cardinality: self cardinality
]

{ #category : #initialization }
RfgAbstractTypeSpecification >> initialize [
	super initialize.
	cardinality := RfgCardinality new
]

{ #category : #'as yet unclassified' }
RfgAbstractTypeSpecification >> mergeWithInferredType: aRfgTypeSpecification [
	self subclassResponsibility
]

{ #category : #accessing }
RfgAbstractTypeSpecification >> parserClass: aClass [
	parserClass ifNil: [ parserClass := aClass ]
	
]
