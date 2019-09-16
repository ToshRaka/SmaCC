Class {
	#name : #GrammarwareUnicodeTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'unicodeToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareUnicodeTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitUnicode: self
]

{ #category : #generated }
GrammarwareUnicodeTNode >> tokenVariables [
	^ #(#unicodeToken)
]

{ #category : #generated }
GrammarwareUnicodeTNode >> unicodeToken [
	^ unicodeToken
]

{ #category : #generated }
GrammarwareUnicodeTNode >> unicodeToken: aSmaCCToken [
	unicodeToken := aSmaCCToken
]
