Class {
	#name : #GrammarwareGroupTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'leftParenToken',
		'terms',
		'orTokens',
		'rightParenToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareGroupTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitGroupTerm: self
]

{ #category : #generated }
GrammarwareGroupTermTNode >> compositeNodeVariables [
	^ #(#terms #rules)
]

{ #category : #generated }
GrammarwareGroupTermTNode >> compositeTokenVariables [
	^ #(#orTokens)
]

{ #category : #'generated-initialize-release' }
GrammarwareGroupTermTNode >> initialize [
	super initialize.
	terms := OrderedCollection new: 2.
	orTokens := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareGroupTermTNode >> leftParenToken [
	^ leftParenToken
]

{ #category : #generated }
GrammarwareGroupTermTNode >> leftParenToken: aSmaCCToken [
	leftParenToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareGroupTermTNode >> orTokens [
	^ orTokens
]

{ #category : #generated }
GrammarwareGroupTermTNode >> orTokens: anOrderedCollection [
	orTokens := anOrderedCollection
]

{ #category : #generated }
GrammarwareGroupTermTNode >> rightParenToken [
	^ rightParenToken
]

{ #category : #generated }
GrammarwareGroupTermTNode >> rightParenToken: aSmaCCToken [
	rightParenToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareGroupTermTNode >> terms [
	^ terms
]

{ #category : #generated }
GrammarwareGroupTermTNode >> terms: anOrderedCollection [
	self setParents: self terms to: nil.
	terms := anOrderedCollection.
	self setParents: self terms to: self
]

{ #category : #generated }
GrammarwareGroupTermTNode >> tokenVariables [
	^ #(#leftParenToken #rightParenToken)
]
