Class {
	#name : #GrammarwareNamedKleeneStarTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'term',
		'variableName',
		'timesToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareNamedKleeneStarTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitNamedKleeneStarTerm: self
]

{ #category : #generated }
GrammarwareNamedKleeneStarTermTNode >> nodeVariables [
	^ #(#term)
]

{ #category : #generated }
GrammarwareNamedKleeneStarTermTNode >> term [
	^ term
]

{ #category : #generated }
GrammarwareNamedKleeneStarTermTNode >> term: aGrammarwareFileTNode [
	self term notNil
		ifTrue: [ self term parent: nil ].
	term := aGrammarwareFileTNode.
	self term notNil
		ifTrue: [ self term parent: self ]
]

{ #category : #generated }
GrammarwareNamedKleeneStarTermTNode >> timesToken [
	^ timesToken
]

{ #category : #generated }
GrammarwareNamedKleeneStarTermTNode >> timesToken: aSmaCCToken [
	timesToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareNamedKleeneStarTermTNode >> tokenVariables [
	^ #(#variableName #timesToken)
]

{ #category : #generated }
GrammarwareNamedKleeneStarTermTNode >> variableName [
	^ variableName
]

{ #category : #generated }
GrammarwareNamedKleeneStarTermTNode >> variableName: aSmaCCToken [
	variableName := aSmaCCToken
]
