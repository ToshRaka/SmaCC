Class {
	#name : #GrammarwareKeywordTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'keywordToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareKeywordTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitKeyword: self
]

{ #category : #generated }
GrammarwareKeywordTNode >> keywordToken [
	^ keywordToken
]

{ #category : #generated }
GrammarwareKeywordTNode >> keywordToken: aSmaCCToken [
	keywordToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareKeywordTNode >> tokenVariables [
	^ #(#keywordToken)
]
