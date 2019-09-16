Class {
	#name : #RfgCompositeTypeSpecification,
	#superclass : #RfgAbstractTypeSpecification,
	#instVars : [
		'subtypes'
	],
	#category : #'SmaCC_Rfg-Types'
}

{ #category : #accessing }
RfgCompositeTypeSpecification class >> subtypes: aCollection [
	^ self new
		subtypes: aCollection;
		yourself
]

{ #category : #comparing }
RfgCompositeTypeSpecification >> = aRfgANDTypeSpecification [
	^ self class = aRfgANDTypeSpecification class
		and: [ self subtypes = aRfgANDTypeSpecification types ]
]

{ #category : #initialization }
RfgCompositeTypeSpecification >> initialize [ 
	super initialize.
	subtypes := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
RfgCompositeTypeSpecification >> mergeWithInferredType: aRfgTypeSpecification [
	self subclassResponsibility
]

{ #category : #copying }
RfgCompositeTypeSpecification >> postCopy [
	super postCopy.
	subtypes := subtypes copy
]

{ #category : #accessing }
RfgCompositeTypeSpecification >> subtypes [
	^ subtypes
]

{ #category : #accessing }
RfgCompositeTypeSpecification >> subtypes: anObject [
	subtypes := anObject
]
