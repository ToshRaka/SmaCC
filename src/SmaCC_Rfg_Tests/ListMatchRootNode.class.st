Class {
	#name : #ListMatchRootNode,
	#superclass : #ListMatchProgramNode,
	#instVars : [
		'lists',
		'semicolonTokens'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
ListMatchRootNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitRoot: self
]

{ #category : #generated }
ListMatchRootNode >> compositeNodeVariables [
	^ #(#lists)
]

{ #category : #generated }
ListMatchRootNode >> compositeTokenVariables [
	^ #(#semicolonTokens)
]

{ #category : #'generated-initialize-release' }
ListMatchRootNode >> initialize [
	super initialize.
	lists := OrderedCollection new: 2.
	semicolonTokens := OrderedCollection new: 2.
]

{ #category : #generated }
ListMatchRootNode >> lists [
	^ lists
]

{ #category : #generated }
ListMatchRootNode >> lists: anOrderedCollection [
	self setParents: self lists to: nil.
	lists := anOrderedCollection.
	self setParents: self lists to: self
]

{ #category : #generated }
ListMatchRootNode >> semicolonTokens [
	^ semicolonTokens
]

{ #category : #generated }
ListMatchRootNode >> semicolonTokens: anOrderedCollection [
	semicolonTokens := anOrderedCollection
]
