Class {
	#name : #GrammarwareDefaultClassAlternateTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'rhsTerms',
		'classLeftToken',
		'classRightToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareDefaultClassAlternateTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitDefaultClassAlternate: self
]

{ #category : #generated }
GrammarwareDefaultClassAlternateTNode >> classLeftToken [
	^ classLeftToken
]

{ #category : #generated }
GrammarwareDefaultClassAlternateTNode >> classLeftToken: aSmaCCToken [
	classLeftToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareDefaultClassAlternateTNode >> classRightToken [
	^ classRightToken
]

{ #category : #generated }
GrammarwareDefaultClassAlternateTNode >> classRightToken: aSmaCCToken [
	classRightToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareDefaultClassAlternateTNode >> nodeVariables [
	^ #(#rhsTerms)
]

{ #category : #generated }
GrammarwareDefaultClassAlternateTNode >> rhsTerms [
	^ rhsTerms
]

{ #category : #generated }
GrammarwareDefaultClassAlternateTNode >> rhsTerms: aGrammarwareTermsTNode [
	self rhsTerms notNil
		ifTrue: [ self rhsTerms parent: nil ].
	rhsTerms := aGrammarwareTermsTNode.
	self rhsTerms notNil
		ifTrue: [ self rhsTerms parent: self ]
]

{ #category : #generated }
GrammarwareDefaultClassAlternateTNode >> tokenVariables [
	^ #(#classLeftToken #classRightToken)
]
