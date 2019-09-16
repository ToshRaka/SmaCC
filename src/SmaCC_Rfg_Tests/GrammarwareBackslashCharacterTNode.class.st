Class {
	#name : #GrammarwareBackslashCharacterTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'backslashcharacterToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareBackslashCharacterTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitBackslashCharacter: self
]

{ #category : #generated }
GrammarwareBackslashCharacterTNode >> backslashcharacterToken [
	^ backslashcharacterToken
]

{ #category : #generated }
GrammarwareBackslashCharacterTNode >> backslashcharacterToken: aSmaCCToken [
	backslashcharacterToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareBackslashCharacterTNode >> tokenVariables [
	^ #(#backslashcharacterToken)
]
