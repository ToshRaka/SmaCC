Class {
	#name : #GrammarwareNamedOptionalTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'term',
		'variableName',
		'questionMarkToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareNamedOptionalTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitNamedOptionalTerm: self
]

{ #category : #generated }
GrammarwareNamedOptionalTermTNode >> nodeVariables [
	^ #(#term)
]

{ #category : #generated }
GrammarwareNamedOptionalTermTNode >> questionMarkToken [
	^ questionMarkToken
]

{ #category : #generated }
GrammarwareNamedOptionalTermTNode >> questionMarkToken: aSmaCCToken [
	questionMarkToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareNamedOptionalTermTNode >> term [
	^ term
]

{ #category : #generated }
GrammarwareNamedOptionalTermTNode >> term: aGrammarwareFileTNode [
	self term notNil
		ifTrue: [ self term parent: nil ].
	term := aGrammarwareFileTNode.
	self term notNil
		ifTrue: [ self term parent: self ]
]

{ #category : #generated }
GrammarwareNamedOptionalTermTNode >> tokenVariables [
	^ #(#variableName #questionMarkToken)
]

{ #category : #generated }
GrammarwareNamedOptionalTermTNode >> variableName [
	^ variableName
]

{ #category : #generated }
GrammarwareNamedOptionalTermTNode >> variableName: aSmaCCToken [
	variableName := aSmaCCToken
]
