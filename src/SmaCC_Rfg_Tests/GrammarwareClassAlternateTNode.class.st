Class {
	#name : #GrammarwareClassAlternateTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'rhsTerms',
		'classLeftToken',
		'_className',
		'classRightToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareClassAlternateTNode >> _className [
	^ _className
]

{ #category : #generated }
GrammarwareClassAlternateTNode >> _className: aSmaCCToken [
	_className := aSmaCCToken
]

{ #category : #generated }
GrammarwareClassAlternateTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitClassAlternate: self
]

{ #category : #generated }
GrammarwareClassAlternateTNode >> classLeftToken [
	^ classLeftToken
]

{ #category : #generated }
GrammarwareClassAlternateTNode >> classLeftToken: aSmaCCToken [
	classLeftToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareClassAlternateTNode >> classRightToken [
	^ classRightToken
]

{ #category : #generated }
GrammarwareClassAlternateTNode >> classRightToken: aSmaCCToken [
	classRightToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareClassAlternateTNode >> nodeVariables [
	^ #(#rhsTerms)
]

{ #category : #generated }
GrammarwareClassAlternateTNode >> rhsTerms [
	^ rhsTerms
]

{ #category : #generated }
GrammarwareClassAlternateTNode >> rhsTerms: aGrammarwareTermsTNode [
	self rhsTerms notNil
		ifTrue: [ self rhsTerms parent: nil ].
	rhsTerms := aGrammarwareTermsTNode.
	self rhsTerms notNil
		ifTrue: [ self rhsTerms parent: self ]
]

{ #category : #generated }
GrammarwareClassAlternateTNode >> tokenVariables [
	^ #(#classLeftToken #_className #classRightToken)
]
