Class {
	#name : #GrammarwareKleeneStarTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'term',
		'timesToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareKleeneStarTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitKleeneStarTerm: self
]

{ #category : #generated }
GrammarwareKleeneStarTermTNode >> nodeVariables [
	^ #(#term)
]

{ #category : #generated }
GrammarwareKleeneStarTermTNode >> term [
	^ term
]

{ #category : #generated }
GrammarwareKleeneStarTermTNode >> term: aGrammarwareFileTNode [
	self term notNil
		ifTrue: [ self term parent: nil ].
	term := aGrammarwareFileTNode.
	self term notNil
		ifTrue: [ self term parent: self ]
]

{ #category : #generated }
GrammarwareKleeneStarTermTNode >> timesToken [
	^ timesToken
]

{ #category : #generated }
GrammarwareKleeneStarTermTNode >> timesToken: aSmaCCToken [
	timesToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareKleeneStarTermTNode >> tokenVariables [
	^ #(#timesToken)
]
