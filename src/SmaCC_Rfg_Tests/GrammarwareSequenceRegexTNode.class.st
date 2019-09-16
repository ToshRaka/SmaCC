Class {
	#name : #GrammarwareSequenceRegexTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'leftRegex',
		'rightRegex'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareSequenceRegexTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitSequenceRegex: self
]

{ #category : #generated }
GrammarwareSequenceRegexTNode >> leftRegex [
	^ leftRegex
]

{ #category : #generated }
GrammarwareSequenceRegexTNode >> leftRegex: aGrammarwareFileTNode [
	self leftRegex notNil
		ifTrue: [ self leftRegex parent: nil ].
	leftRegex := aGrammarwareFileTNode.
	self leftRegex notNil
		ifTrue: [ self leftRegex parent: self ]
]

{ #category : #generated }
GrammarwareSequenceRegexTNode >> nodeVariables [
	^ #(#leftRegex #rightRegex)
]

{ #category : #generated }
GrammarwareSequenceRegexTNode >> rightRegex [
	^ rightRegex
]

{ #category : #generated }
GrammarwareSequenceRegexTNode >> rightRegex: aGrammarwareFileTNode [
	self rightRegex notNil
		ifTrue: [ self rightRegex parent: nil ].
	rightRegex := aGrammarwareFileTNode.
	self rightRegex notNil
		ifTrue: [ self rightRegex parent: self ]
]
