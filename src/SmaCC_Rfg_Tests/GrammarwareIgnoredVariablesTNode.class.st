Class {
	#name : #GrammarwareIgnoredVariablesTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'ignorevariablesToken',
		'variableses'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareIgnoredVariablesTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitIgnoredVariables: self
]

{ #category : #generated }
GrammarwareIgnoredVariablesTNode >> compositeNodeVariables [
	^ #(#variableses #rules)
]

{ #category : #generated }
GrammarwareIgnoredVariablesTNode >> ignorevariablesToken [
	^ ignorevariablesToken
]

{ #category : #generated }
GrammarwareIgnoredVariablesTNode >> ignorevariablesToken: aSmaCCToken [
	ignorevariablesToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
GrammarwareIgnoredVariablesTNode >> initialize [
	super initialize.
	variableses := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareIgnoredVariablesTNode >> tokenVariables [
	^ #(#ignorevariablesToken)
]

{ #category : #generated }
GrammarwareIgnoredVariablesTNode >> variableses [
	^ variableses
]

{ #category : #generated }
GrammarwareIgnoredVariablesTNode >> variableses: anOrderedCollection [
	self setParents: self variableses to: nil.
	variableses := anOrderedCollection.
	self setParents: self variableses to: self
]
