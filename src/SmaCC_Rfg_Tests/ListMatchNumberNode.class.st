Class {
	#name : #ListMatchNumberNode,
	#superclass : #ListMatchProgramNode,
	#instVars : [
		'token'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
ListMatchNumberNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNumber: self
]

{ #category : #generated }
ListMatchNumberNode >> token [
	^ token
]

{ #category : #generated }
ListMatchNumberNode >> token: aSmaCCToken [
	token := aSmaCCToken
]

{ #category : #generated }
ListMatchNumberNode >> tokenVariables [
	^ #(#token)
]
