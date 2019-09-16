Class {
	#name : #ExampleProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
ExampleProgramNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProgram: self
]
