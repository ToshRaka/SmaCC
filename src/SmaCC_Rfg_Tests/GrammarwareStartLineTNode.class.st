Class {
	#name : #GrammarwareStartLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'startToken',
		'startingSymbolses'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareStartLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitStartLine: self
]

{ #category : #generated }
GrammarwareStartLineTNode >> compositeNodeVariables [
	^ #(#startingSymbolses #rules)
]

{ #category : #'generated-initialize-release' }
GrammarwareStartLineTNode >> initialize [
	super initialize.
	startingSymbolses := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareStartLineTNode >> startToken [
	^ startToken
]

{ #category : #generated }
GrammarwareStartLineTNode >> startToken: aSmaCCToken [
	startToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareStartLineTNode >> startingSymbolses [
	^ startingSymbolses
]

{ #category : #generated }
GrammarwareStartLineTNode >> startingSymbolses: anOrderedCollection [
	self setParents: self startingSymbolses to: nil.
	startingSymbolses := anOrderedCollection.
	self setParents: self startingSymbolses to: self
]

{ #category : #generated }
GrammarwareStartLineTNode >> tokenVariables [
	^ #(#startToken)
]
