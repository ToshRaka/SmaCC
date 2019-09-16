Class {
	#name : #GrammarwareKleenePlusTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'term',
		'plusToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareKleenePlusTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitKleenePlusTerm: self
]

{ #category : #generated }
GrammarwareKleenePlusTermTNode >> nodeVariables [
	^ #(#term)
]

{ #category : #generated }
GrammarwareKleenePlusTermTNode >> plusToken [
	^ plusToken
]

{ #category : #generated }
GrammarwareKleenePlusTermTNode >> plusToken: aSmaCCToken [
	plusToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareKleenePlusTermTNode >> term [
	^ term
]

{ #category : #generated }
GrammarwareKleenePlusTermTNode >> term: aGrammarwareFileTNode [
	self term notNil
		ifTrue: [ self term parent: nil ].
	term := aGrammarwareFileTNode.
	self term notNil
		ifTrue: [ self term parent: self ]
]

{ #category : #generated }
GrammarwareKleenePlusTermTNode >> tokenVariables [
	^ #(#plusToken)
]
