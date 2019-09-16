Class {
	#name : #GrammarwareCharacterBlockTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'characterblockToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareCharacterBlockTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitCharacterBlock: self
]

{ #category : #generated }
GrammarwareCharacterBlockTNode >> characterblockToken [
	^ characterblockToken
]

{ #category : #generated }
GrammarwareCharacterBlockTNode >> characterblockToken: aSmaCCToken [
	characterblockToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareCharacterBlockTNode >> tokenVariables [
	^ #(#characterblockToken)
]
