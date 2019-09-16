Class {
	#name : #GrammarwareCharacterTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'characterToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareCharacterTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitCharacter: self
]

{ #category : #generated }
GrammarwareCharacterTNode >> characterToken [
	^ characterToken
]

{ #category : #generated }
GrammarwareCharacterTNode >> characterToken: aSmaCCToken [
	characterToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareCharacterTNode >> tokenVariables [
	^ #(#characterToken)
]
