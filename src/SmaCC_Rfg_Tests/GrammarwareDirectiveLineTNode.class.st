Class {
	#name : #GrammarwareDirectiveLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'directiveToken',
		'directive',
		'semicolonToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareDirectiveLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitDirectiveLine: self
]

{ #category : #generated }
GrammarwareDirectiveLineTNode >> directive [
	^ directive
]

{ #category : #generated }
GrammarwareDirectiveLineTNode >> directive: aGrammarwareFileTNode [
	self directive notNil
		ifTrue: [ self directive parent: nil ].
	directive := aGrammarwareFileTNode.
	self directive notNil
		ifTrue: [ self directive parent: self ]
]

{ #category : #generated }
GrammarwareDirectiveLineTNode >> directiveToken [
	^ directiveToken
]

{ #category : #generated }
GrammarwareDirectiveLineTNode >> directiveToken: aSmaCCToken [
	directiveToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareDirectiveLineTNode >> nodeVariables [
	^ #(#directive)
]

{ #category : #generated }
GrammarwareDirectiveLineTNode >> semicolonToken [
	^ semicolonToken
]

{ #category : #generated }
GrammarwareDirectiveLineTNode >> semicolonToken: aSmaCCToken [
	semicolonToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareDirectiveLineTNode >> tokenVariables [
	^ #(#directiveToken #semicolonToken)
]
