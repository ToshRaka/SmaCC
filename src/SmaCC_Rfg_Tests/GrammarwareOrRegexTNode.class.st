Class {
	#name : #GrammarwareOrRegexTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'leftRegex',
		'orToken',
		'rightRegex'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareOrRegexTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitOrRegex: self
]

{ #category : #generated }
GrammarwareOrRegexTNode >> leftRegex [
	^ leftRegex
]

{ #category : #generated }
GrammarwareOrRegexTNode >> leftRegex: aGrammarwareFileTNode [
	self leftRegex notNil
		ifTrue: [ self leftRegex parent: nil ].
	leftRegex := aGrammarwareFileTNode.
	self leftRegex notNil
		ifTrue: [ self leftRegex parent: self ]
]

{ #category : #generated }
GrammarwareOrRegexTNode >> nodeVariables [
	^ #(#leftRegex #rightRegex)
]

{ #category : #generated }
GrammarwareOrRegexTNode >> orToken [
	^ orToken
]

{ #category : #generated }
GrammarwareOrRegexTNode >> orToken: aSmaCCToken [
	orToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareOrRegexTNode >> rightRegex [
	^ rightRegex
]

{ #category : #generated }
GrammarwareOrRegexTNode >> rightRegex: aGrammarwareFileTNode [
	self rightRegex notNil
		ifTrue: [ self rightRegex parent: nil ].
	rightRegex := aGrammarwareFileTNode.
	self rightRegex notNil
		ifTrue: [ self rightRegex parent: self ]
]

{ #category : #generated }
GrammarwareOrRegexTNode >> tokenVariables [
	^ #(#orToken)
]
