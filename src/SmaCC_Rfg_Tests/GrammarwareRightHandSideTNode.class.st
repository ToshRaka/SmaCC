Class {
	#name : #GrammarwareRightHandSideTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'alternates',
		'orTokens'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareRightHandSideTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitRightHandSide: self
]

{ #category : #generated }
GrammarwareRightHandSideTNode >> alternates [
	^ alternates
]

{ #category : #generated }
GrammarwareRightHandSideTNode >> alternates: anOrderedCollection [
	self setParents: self alternates to: nil.
	alternates := anOrderedCollection.
	self setParents: self alternates to: self
]

{ #category : #generated }
GrammarwareRightHandSideTNode >> compositeNodeVariables [
	^ #(#alternates #rules)
]

{ #category : #generated }
GrammarwareRightHandSideTNode >> compositeTokenVariables [
	^ #(#orTokens)
]

{ #category : #'generated-initialize-release' }
GrammarwareRightHandSideTNode >> initialize [
	super initialize.
	alternates := OrderedCollection new: 2.
	orTokens := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareRightHandSideTNode >> orTokens [
	^ orTokens
]

{ #category : #generated }
GrammarwareRightHandSideTNode >> orTokens: anOrderedCollection [
	orTokens := anOrderedCollection
]
