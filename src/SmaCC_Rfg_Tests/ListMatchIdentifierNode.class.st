Class {
	#name : #ListMatchIdentifierNode,
	#superclass : #ListMatchProgramNode,
	#instVars : [
		'token'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
ListMatchIdentifierNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitIdentifier: self
]

{ #category : #generated }
ListMatchIdentifierNode >> token [
	^ token
]

{ #category : #generated }
ListMatchIdentifierNode >> token: aSmaCCToken [
	token := aSmaCCToken
]

{ #category : #generated }
ListMatchIdentifierNode >> tokenVariables [
	^ #(#token)
]
