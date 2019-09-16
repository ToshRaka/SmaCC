Class {
	#name : #GrammarwareAnnotateTokensTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'annotate_tokensToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareAnnotateTokensTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitAnnotateTokens: self
]

{ #category : #generated }
GrammarwareAnnotateTokensTNode >> annotate_tokensToken [
	^ annotate_tokensToken
]

{ #category : #generated }
GrammarwareAnnotateTokensTNode >> annotate_tokensToken: aSmaCCToken [
	annotate_tokensToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareAnnotateTokensTNode >> tokenVariables [
	^ #(#annotate_tokensToken)
]
