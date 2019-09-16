Class {
	#name : #GrammarwareAttributesLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'attributesToken',
		'aClass',
		'leftParenToken',
		'ivarses',
		'rightParenToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareAttributesLineTNode >> aClass [
	^ aClass
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> aClass: aGrammarwareSymbolTNode [
	self aClass notNil
		ifTrue: [ self aClass parent: nil ].
	aClass := aGrammarwareSymbolTNode.
	self aClass notNil
		ifTrue: [ self aClass parent: self ]
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitAttributesLine: self
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> attributesToken [
	^ attributesToken
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> attributesToken: aSmaCCToken [
	attributesToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> compositeNodeVariables [
	^ #(#ivarses #rules)
]

{ #category : #'generated-initialize-release' }
GrammarwareAttributesLineTNode >> initialize [
	super initialize.
	ivarses := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> ivarses [
	^ ivarses
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> ivarses: anOrderedCollection [
	self setParents: self ivarses to: nil.
	ivarses := anOrderedCollection.
	self setParents: self ivarses to: self
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> leftParenToken [
	^ leftParenToken
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> leftParenToken: aSmaCCToken [
	leftParenToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> nodeVariables [
	^ #(#aClass)
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> rightParenToken [
	^ rightParenToken
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> rightParenToken: aSmaCCToken [
	rightParenToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareAttributesLineTNode >> tokenVariables [
	^ #(#attributesToken #leftParenToken #rightParenToken)
]
