Class {
	#name : #ExampleNumberNode,
	#superclass : #ExampleProgramNode,
	#instVars : [
		'numberToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
ExampleNumberNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNumber: self
]

{ #category : #generated }
ExampleNumberNode >> numberToken [
	^ numberToken
]

{ #category : #generated }
ExampleNumberNode >> numberToken: aSmaCCToken [
	numberToken := aSmaCCToken
]

{ #category : #generated }
ExampleNumberNode >> tokenVariables [
	^ #(#numberToken)
]
