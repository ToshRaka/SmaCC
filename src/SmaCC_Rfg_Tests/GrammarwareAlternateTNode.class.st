Class {
	#name : #GrammarwareAlternateTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'rhsTerms'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareAlternateTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitAlternate: self
]

{ #category : #generated }
GrammarwareAlternateTNode >> nodeVariables [
	^ #(#rhsTerms)
]

{ #category : #generated }
GrammarwareAlternateTNode >> rhsTerms [
	^ rhsTerms
]

{ #category : #generated }
GrammarwareAlternateTNode >> rhsTerms: aGrammarwareTermsTNode [
	self rhsTerms notNil
		ifTrue: [ self rhsTerms parent: nil ].
	rhsTerms := aGrammarwareTermsTNode.
	self rhsTerms notNil
		ifTrue: [ self rhsTerms parent: self ]
]
