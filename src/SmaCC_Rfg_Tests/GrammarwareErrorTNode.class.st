Class {
	#name : #GrammarwareErrorTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'errorToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareErrorTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitError: self
]

{ #category : #generated }
GrammarwareErrorTNode >> errorToken [
	^ errorToken
]

{ #category : #generated }
GrammarwareErrorTNode >> errorToken: aSmaCCToken [
	errorToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareErrorTNode >> tokenVariables [
	^ #(#errorToken)
]
