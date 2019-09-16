Class {
	#name : #GrammarwareIgnoreCaseTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'ignorecaseToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareIgnoreCaseTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitIgnoreCase: self
]

{ #category : #generated }
GrammarwareIgnoreCaseTNode >> ignorecaseToken [
	^ ignorecaseToken
]

{ #category : #generated }
GrammarwareIgnoreCaseTNode >> ignorecaseToken: aSmaCCToken [
	ignorecaseToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareIgnoreCaseTNode >> tokenVariables [
	^ #(#ignorecaseToken)
]
