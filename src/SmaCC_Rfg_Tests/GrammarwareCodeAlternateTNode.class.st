Class {
	#name : #GrammarwareCodeAlternateTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'rhsTerms',
		'code'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareCodeAlternateTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitCodeAlternate: self
]

{ #category : #generated }
GrammarwareCodeAlternateTNode >> code [
	^ code
]

{ #category : #generated }
GrammarwareCodeAlternateTNode >> code: aSmaCCToken [
	code := aSmaCCToken
]

{ #category : #generated }
GrammarwareCodeAlternateTNode >> nodeVariables [
	^ #(#rhsTerms)
]

{ #category : #generated }
GrammarwareCodeAlternateTNode >> rhsTerms [
	^ rhsTerms
]

{ #category : #generated }
GrammarwareCodeAlternateTNode >> rhsTerms: aGrammarwareTermsTNode [
	self rhsTerms notNil
		ifTrue: [ self rhsTerms parent: nil ].
	rhsTerms := aGrammarwareTermsTNode.
	self rhsTerms notNil
		ifTrue: [ self rhsTerms parent: self ]
]

{ #category : #generated }
GrammarwareCodeAlternateTNode >> tokenVariables [
	^ #(#code)
]
