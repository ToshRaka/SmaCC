Class {
	#name : #GrammarwareNamedTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'term',
		'variableName'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareNamedTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitNamedTerm: self
]

{ #category : #generated }
GrammarwareNamedTermTNode >> nodeVariables [
	^ #(#term)
]

{ #category : #generated }
GrammarwareNamedTermTNode >> term [
	^ term
]

{ #category : #generated }
GrammarwareNamedTermTNode >> term: aGrammarwareFileTNode [
	self term notNil
		ifTrue: [ self term parent: nil ].
	term := aGrammarwareFileTNode.
	self term notNil
		ifTrue: [ self term parent: self ]
]

{ #category : #generated }
GrammarwareNamedTermTNode >> tokenVariables [
	^ #(#variableName)
]

{ #category : #generated }
GrammarwareNamedTermTNode >> variableName [
	^ variableName
]

{ #category : #generated }
GrammarwareNamedTermTNode >> variableName: aSmaCCToken [
	variableName := aSmaCCToken
]
