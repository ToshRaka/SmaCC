Class {
	#name : #GrammarwareIdMethodLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'idToken',
		'idTokenses'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareIdMethodLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitIdMethodLine: self
]

{ #category : #generated }
GrammarwareIdMethodLineTNode >> compositeTokenVariables [
	^ #(#idTokenses)
]

{ #category : #generated }
GrammarwareIdMethodLineTNode >> idToken [
	^ idToken
]

{ #category : #generated }
GrammarwareIdMethodLineTNode >> idToken: aSmaCCToken [
	idToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareIdMethodLineTNode >> idTokenses [
	^ idTokenses
]

{ #category : #generated }
GrammarwareIdMethodLineTNode >> idTokenses: anOrderedCollection [
	idTokenses := anOrderedCollection
]

{ #category : #'generated-initialize-release' }
GrammarwareIdMethodLineTNode >> initialize [
	super initialize.
	idTokenses := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareIdMethodLineTNode >> tokenVariables [
	^ #(#idToken)
]
