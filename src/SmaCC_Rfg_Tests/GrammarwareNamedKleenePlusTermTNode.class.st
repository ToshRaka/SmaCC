Class {
	#name : #GrammarwareNamedKleenePlusTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'term',
		'variableName',
		'plusToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareNamedKleenePlusTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitNamedKleenePlusTerm: self
]

{ #category : #generated }
GrammarwareNamedKleenePlusTermTNode >> nodeVariables [
	^ #(#term)
]

{ #category : #generated }
GrammarwareNamedKleenePlusTermTNode >> plusToken [
	^ plusToken
]

{ #category : #generated }
GrammarwareNamedKleenePlusTermTNode >> plusToken: aSmaCCToken [
	plusToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareNamedKleenePlusTermTNode >> term [
	^ term
]

{ #category : #generated }
GrammarwareNamedKleenePlusTermTNode >> term: aGrammarwareFileTNode [
	self term notNil
		ifTrue: [ self term parent: nil ].
	term := aGrammarwareFileTNode.
	self term notNil
		ifTrue: [ self term parent: self ]
]

{ #category : #generated }
GrammarwareNamedKleenePlusTermTNode >> tokenVariables [
	^ #(#variableName #plusToken)
]

{ #category : #generated }
GrammarwareNamedKleenePlusTermTNode >> variableName [
	^ variableName
]

{ #category : #generated }
GrammarwareNamedKleenePlusTermTNode >> variableName: aSmaCCToken [
	variableName := aSmaCCToken
]
