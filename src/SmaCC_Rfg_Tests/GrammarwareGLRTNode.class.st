Class {
	#name : #GrammarwareGLRTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'glrToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareGLRTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitGLR: self
]

{ #category : #generated }
GrammarwareGLRTNode >> glrToken [
	^ glrToken
]

{ #category : #generated }
GrammarwareGLRTNode >> glrToken: aSmaCCToken [
	glrToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareGLRTNode >> tokenVariables [
	^ #(#glrToken)
]
