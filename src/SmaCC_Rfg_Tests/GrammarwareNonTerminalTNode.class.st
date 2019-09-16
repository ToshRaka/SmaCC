Class {
	#name : #GrammarwareNonTerminalTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'symbolnameToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareNonTerminalTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitNonTerminal: self
]

{ #category : #generated }
GrammarwareNonTerminalTNode >> symbolnameToken [
	^ symbolnameToken
]

{ #category : #generated }
GrammarwareNonTerminalTNode >> symbolnameToken: aSmaCCToken [
	symbolnameToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareNonTerminalTNode >> tokenVariables [
	^ #(#symbolnameToken)
]
