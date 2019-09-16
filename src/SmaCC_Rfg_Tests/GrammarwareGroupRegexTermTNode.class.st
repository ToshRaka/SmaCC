Class {
	#name : #GrammarwareGroupRegexTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'leftParenToken',
		'group',
		'rightParenToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareGroupRegexTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitGroupRegexTerm: self
]

{ #category : #generated }
GrammarwareGroupRegexTermTNode >> group [
	^ group
]

{ #category : #generated }
GrammarwareGroupRegexTermTNode >> group: aGrammarwareFileTNode [
	self group notNil
		ifTrue: [ self group parent: nil ].
	group := aGrammarwareFileTNode.
	self group notNil
		ifTrue: [ self group parent: self ]
]

{ #category : #generated }
GrammarwareGroupRegexTermTNode >> leftParenToken [
	^ leftParenToken
]

{ #category : #generated }
GrammarwareGroupRegexTermTNode >> leftParenToken: aSmaCCToken [
	leftParenToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareGroupRegexTermTNode >> nodeVariables [
	^ #(#group)
]

{ #category : #generated }
GrammarwareGroupRegexTermTNode >> rightParenToken [
	^ rightParenToken
]

{ #category : #generated }
GrammarwareGroupRegexTermTNode >> rightParenToken: aSmaCCToken [
	rightParenToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareGroupRegexTermTNode >> tokenVariables [
	^ #(#leftParenToken #rightParenToken)
]
