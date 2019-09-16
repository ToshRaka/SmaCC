Class {
	#name : #GrammarwareExcludeStatesLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'excludesToken',
		'scannerStateses'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareExcludeStatesLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitExcludeStatesLine: self
]

{ #category : #generated }
GrammarwareExcludeStatesLineTNode >> compositeNodeVariables [
	^ #(#scannerStateses #rules)
]

{ #category : #generated }
GrammarwareExcludeStatesLineTNode >> excludesToken [
	^ excludesToken
]

{ #category : #generated }
GrammarwareExcludeStatesLineTNode >> excludesToken: aSmaCCToken [
	excludesToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
GrammarwareExcludeStatesLineTNode >> initialize [
	super initialize.
	scannerStateses := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareExcludeStatesLineTNode >> scannerStateses [
	^ scannerStateses
]

{ #category : #generated }
GrammarwareExcludeStatesLineTNode >> scannerStateses: anOrderedCollection [
	self setParents: self scannerStateses to: nil.
	scannerStateses := anOrderedCollection.
	self setParents: self scannerStateses to: self
]

{ #category : #generated }
GrammarwareExcludeStatesLineTNode >> tokenVariables [
	^ #(#excludesToken)
]
