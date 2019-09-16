Class {
	#name : #GrammarwareLeftLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'leftToken',
		'leftTokenses'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareLeftLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitLeftLine: self
]

{ #category : #generated }
GrammarwareLeftLineTNode >> compositeNodeVariables [
	^ #(#leftTokenses #rules)
]

{ #category : #'generated-initialize-release' }
GrammarwareLeftLineTNode >> initialize [
	super initialize.
	leftTokenses := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareLeftLineTNode >> leftToken [
	^ leftToken
]

{ #category : #generated }
GrammarwareLeftLineTNode >> leftToken: aSmaCCToken [
	leftToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareLeftLineTNode >> leftTokenses [
	^ leftTokenses
]

{ #category : #generated }
GrammarwareLeftLineTNode >> leftTokenses: anOrderedCollection [
	self setParents: self leftTokenses to: nil.
	leftTokenses := anOrderedCollection.
	self setParents: self leftTokenses to: self
]

{ #category : #generated }
GrammarwareLeftLineTNode >> tokenVariables [
	^ #(#leftToken)
]
