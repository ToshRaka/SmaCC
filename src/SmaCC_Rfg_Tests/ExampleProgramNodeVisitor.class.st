Class {
	#name : #ExampleProgramNodeVisitor,
	#superclass : #SmaCCParseNodeVisitor,
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
ExampleProgramNodeVisitor >> visitBinary: aBinary [
	^ self visitProgram: aBinary
]

{ #category : #generated }
ExampleProgramNodeVisitor >> visitNumber: aNumber [
	^ self visitProgram: aNumber
]

{ #category : #generated }
ExampleProgramNodeVisitor >> visitProgram: aProgram [
	^ self visitSmaCCParseNode: aProgram
]
