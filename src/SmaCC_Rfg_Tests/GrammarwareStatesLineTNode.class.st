Class {
	#name : #GrammarwareStatesLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'statesToken',
		'scannerStateses'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareStatesLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitStatesLine: self
]

{ #category : #generated }
GrammarwareStatesLineTNode >> compositeNodeVariables [
	^ #(#scannerStateses #rules)
]

{ #category : #'generated-initialize-release' }
GrammarwareStatesLineTNode >> initialize [
	super initialize.
	scannerStateses := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareStatesLineTNode >> scannerStateses [
	^ scannerStateses
]

{ #category : #generated }
GrammarwareStatesLineTNode >> scannerStateses: anOrderedCollection [
	self setParents: self scannerStateses to: nil.
	scannerStateses := anOrderedCollection.
	self setParents: self scannerStateses to: self
]

{ #category : #generated }
GrammarwareStatesLineTNode >> statesToken [
	^ statesToken
]

{ #category : #generated }
GrammarwareStatesLineTNode >> statesToken: aSmaCCToken [
	statesToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareStatesLineTNode >> tokenVariables [
	^ #(#statesToken)
]
