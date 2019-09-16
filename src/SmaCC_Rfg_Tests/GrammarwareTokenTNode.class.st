Class {
	#name : #GrammarwareTokenTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'tokennameToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareTokenTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitToken: self
]

{ #category : #generated }
GrammarwareTokenTNode >> tokenVariables [
	^ #(#tokennameToken)
]

{ #category : #generated }
GrammarwareTokenTNode >> tokennameToken [
	^ tokennameToken
]

{ #category : #generated }
GrammarwareTokenTNode >> tokennameToken: aSmaCCToken [
	tokennameToken := aSmaCCToken
]
