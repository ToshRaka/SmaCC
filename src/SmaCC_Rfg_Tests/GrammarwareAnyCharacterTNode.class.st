Class {
	#name : #GrammarwareAnyCharacterTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'anycharacterToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareAnyCharacterTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitAnyCharacter: self
]

{ #category : #generated }
GrammarwareAnyCharacterTNode >> anycharacterToken [
	^ anycharacterToken
]

{ #category : #generated }
GrammarwareAnyCharacterTNode >> anycharacterToken: aSmaCCToken [
	anycharacterToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareAnyCharacterTNode >> tokenVariables [
	^ #(#anycharacterToken)
]
