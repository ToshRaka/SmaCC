Class {
	#name : #GrammarwareOptionalGroupTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'leftBracketToken',
		'terms',
		'orTokens',
		'rightBracketToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareOptionalGroupTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitOptionalGroupTerm: self
]

{ #category : #generated }
GrammarwareOptionalGroupTermTNode >> compositeNodeVariables [
	^ #(#terms #rules)
]

{ #category : #generated }
GrammarwareOptionalGroupTermTNode >> compositeTokenVariables [
	^ #(#orTokens)
]

{ #category : #'generated-initialize-release' }
GrammarwareOptionalGroupTermTNode >> initialize [
	super initialize.
	terms := OrderedCollection new: 2.
	orTokens := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareOptionalGroupTermTNode >> leftBracketToken [
	^ leftBracketToken
]

{ #category : #generated }
GrammarwareOptionalGroupTermTNode >> leftBracketToken: aSmaCCToken [
	leftBracketToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareOptionalGroupTermTNode >> orTokens [
	^ orTokens
]

{ #category : #generated }
GrammarwareOptionalGroupTermTNode >> orTokens: anOrderedCollection [
	orTokens := anOrderedCollection
]

{ #category : #generated }
GrammarwareOptionalGroupTermTNode >> rightBracketToken [
	^ rightBracketToken
]

{ #category : #generated }
GrammarwareOptionalGroupTermTNode >> rightBracketToken: aSmaCCToken [
	rightBracketToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareOptionalGroupTermTNode >> terms [
	^ terms
]

{ #category : #generated }
GrammarwareOptionalGroupTermTNode >> terms: anOrderedCollection [
	self setParents: self terms to: nil.
	terms := anOrderedCollection.
	self setParents: self terms to: self
]

{ #category : #generated }
GrammarwareOptionalGroupTermTNode >> tokenVariables [
	^ #(#leftBracketToken #rightBracketToken)
]
