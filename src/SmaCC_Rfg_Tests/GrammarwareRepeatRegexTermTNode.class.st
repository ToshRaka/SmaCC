Class {
	#name : #GrammarwareRepeatRegexTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'term',
		'repeatToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareRepeatRegexTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitRepeatRegexTerm: self
]

{ #category : #generated }
GrammarwareRepeatRegexTermTNode >> nodeVariables [
	^ #(#term)
]

{ #category : #generated }
GrammarwareRepeatRegexTermTNode >> repeatToken [
	^ repeatToken
]

{ #category : #generated }
GrammarwareRepeatRegexTermTNode >> repeatToken: aSmaCCToken [
	repeatToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareRepeatRegexTermTNode >> term [
	^ term
]

{ #category : #generated }
GrammarwareRepeatRegexTermTNode >> term: aGrammarwareFileTNode [
	self term notNil
		ifTrue: [ self term parent: nil ].
	term := aGrammarwareFileTNode.
	self term notNil
		ifTrue: [ self term parent: self ]
]

{ #category : #generated }
GrammarwareRepeatRegexTermTNode >> tokenVariables [
	^ #(#repeatToken)
]
