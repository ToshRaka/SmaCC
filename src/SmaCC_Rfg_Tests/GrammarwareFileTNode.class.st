Class {
	#name : #GrammarwareFileTNode,
	#superclass : #SmaCCParseNode,
	#instVars : [
		'rules'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareFileTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitFile: self
]

{ #category : #generated }
GrammarwareFileTNode >> compositeNodeVariables [
	^ #(#rules)
]

{ #category : #'generated-initialize-release' }
GrammarwareFileTNode >> initialize [
	super initialize.
	rules := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareFileTNode >> rules [
	^ rules
]

{ #category : #generated }
GrammarwareFileTNode >> rules: anOrderedCollection [
	self setParents: self rules to: nil.
	rules := anOrderedCollection.
	self setParents: self rules to: self
]
