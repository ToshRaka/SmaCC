Class {
	#name : #GrammarwareRightLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'rightToken',
		'rightTokenses'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareRightLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitRightLine: self
]

{ #category : #generated }
GrammarwareRightLineTNode >> compositeNodeVariables [
	^ #(#rightTokenses #rules)
]

{ #category : #'generated-initialize-release' }
GrammarwareRightLineTNode >> initialize [
	super initialize.
	rightTokenses := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareRightLineTNode >> rightToken [
	^ rightToken
]

{ #category : #generated }
GrammarwareRightLineTNode >> rightToken: aSmaCCToken [
	rightToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareRightLineTNode >> rightTokenses [
	^ rightTokenses
]

{ #category : #generated }
GrammarwareRightLineTNode >> rightTokenses: anOrderedCollection [
	self setParents: self rightTokenses to: nil.
	rightTokenses := anOrderedCollection.
	self setParents: self rightTokenses to: self
]

{ #category : #generated }
GrammarwareRightLineTNode >> tokenVariables [
	^ #(#rightToken)
]
