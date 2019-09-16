Class {
	#name : #GrammarwareKleeneStarRegexTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'term',
		'timesToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareKleeneStarRegexTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitKleeneStarRegexTerm: self
]

{ #category : #generated }
GrammarwareKleeneStarRegexTermTNode >> nodeVariables [
	^ #(#term)
]

{ #category : #generated }
GrammarwareKleeneStarRegexTermTNode >> term [
	^ term
]

{ #category : #generated }
GrammarwareKleeneStarRegexTermTNode >> term: aGrammarwareFileTNode [
	self term notNil
		ifTrue: [ self term parent: nil ].
	term := aGrammarwareFileTNode.
	self term notNil
		ifTrue: [ self term parent: self ]
]

{ #category : #generated }
GrammarwareKleeneStarRegexTermTNode >> timesToken [
	^ timesToken
]

{ #category : #generated }
GrammarwareKleeneStarRegexTermTNode >> timesToken: aSmaCCToken [
	timesToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareKleeneStarRegexTermTNode >> tokenVariables [
	^ #(#timesToken)
]
