Class {
	#name : #GrammarwareTermsTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'terms'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareTermsTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitTerms: self
]

{ #category : #generated }
GrammarwareTermsTNode >> compositeNodeVariables [
	^ #(#terms #rules)
]

{ #category : #'generated-initialize-release' }
GrammarwareTermsTNode >> initialize [
	super initialize.
	terms := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareTermsTNode >> terms [
	^ terms
]

{ #category : #generated }
GrammarwareTermsTNode >> terms: anOrderedCollection [
	self setParents: self terms to: nil.
	terms := anOrderedCollection.
	self setParents: self terms to: self
]
