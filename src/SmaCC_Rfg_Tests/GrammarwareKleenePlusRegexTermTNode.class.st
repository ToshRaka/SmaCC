Class {
	#name : #GrammarwareKleenePlusRegexTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'term',
		'plusToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareKleenePlusRegexTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitKleenePlusRegexTerm: self
]

{ #category : #generated }
GrammarwareKleenePlusRegexTermTNode >> nodeVariables [
	^ #(#term)
]

{ #category : #generated }
GrammarwareKleenePlusRegexTermTNode >> plusToken [
	^ plusToken
]

{ #category : #generated }
GrammarwareKleenePlusRegexTermTNode >> plusToken: aSmaCCToken [
	plusToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareKleenePlusRegexTermTNode >> term [
	^ term
]

{ #category : #generated }
GrammarwareKleenePlusRegexTermTNode >> term: aGrammarwareFileTNode [
	self term notNil
		ifTrue: [ self term parent: nil ].
	term := aGrammarwareFileTNode.
	self term notNil
		ifTrue: [ self term parent: self ]
]

{ #category : #generated }
GrammarwareKleenePlusRegexTermTNode >> tokenVariables [
	^ #(#plusToken)
]
