Class {
	#name : #MetavKeywordNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'keywordName'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavKeywordNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitKeyword: self
]

{ #category : #generated }
MetavKeywordNode >> keywordName [
	^ keywordName
]

{ #category : #generated }
MetavKeywordNode >> keywordName: aSmaCCToken [
	keywordName := aSmaCCToken
]

{ #category : #generated }
MetavKeywordNode >> tokenVariables [
	^ #(#keywordName)
]
