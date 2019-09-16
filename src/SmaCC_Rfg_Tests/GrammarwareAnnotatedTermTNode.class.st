Class {
	#name : #GrammarwareAnnotatedTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'term'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareAnnotatedTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitAnnotatedTerm: self
]

{ #category : #generated }
GrammarwareAnnotatedTermTNode >> nodeVariables [
	^ #(#term)
]

{ #category : #generated }
GrammarwareAnnotatedTermTNode >> term [
	^ term
]

{ #category : #generated }
GrammarwareAnnotatedTermTNode >> term: aGrammarwareFileTNode [
	self term notNil
		ifTrue: [ self term parent: nil ].
	term := aGrammarwareFileTNode.
	self term notNil
		ifTrue: [ self term parent: self ]
]
