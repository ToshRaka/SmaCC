Class {
	#name : #ExampleBinaryNode,
	#superclass : #ExampleProgramNode,
	#instVars : [
		'left',
		'operator',
		'right'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
ExampleBinaryNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitBinary: self
]

{ #category : #generated }
ExampleBinaryNode >> left [
	^ left
]

{ #category : #generated }
ExampleBinaryNode >> left: anExampleProgramNode [
	self left notNil
		ifTrue: [ self left parent: nil ].
	left := anExampleProgramNode.
	self left notNil
		ifTrue: [ self left parent: self ]
]

{ #category : #generated }
ExampleBinaryNode >> nodeVariables [
	^ #(#left #right)
]

{ #category : #generated }
ExampleBinaryNode >> operator [
	^ operator
]

{ #category : #generated }
ExampleBinaryNode >> operator: aSmaCCToken [
	operator := aSmaCCToken
]

{ #category : #generated }
ExampleBinaryNode >> right [
	^ right
]

{ #category : #generated }
ExampleBinaryNode >> right: anExampleProgramNode [
	self right notNil
		ifTrue: [ self right parent: nil ].
	right := anExampleProgramNode.
	self right notNil
		ifTrue: [ self right parent: self ]
]

{ #category : #generated }
ExampleBinaryNode >> tokenVariables [
	^ #(#operator)
]
