Class {
	#name : #GrammarwareRootClassLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'rootToken',
		'root'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareRootClassLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitRootClassLine: self
]

{ #category : #generated }
GrammarwareRootClassLineTNode >> nodeVariables [
	^ #(#root)
]

{ #category : #generated }
GrammarwareRootClassLineTNode >> root [
	^ root
]

{ #category : #generated }
GrammarwareRootClassLineTNode >> root: aGrammarwareSymbolTNode [
	self root notNil
		ifTrue: [ self root parent: nil ].
	root := aGrammarwareSymbolTNode.
	self root notNil
		ifTrue: [ self root parent: self ]
]

{ #category : #generated }
GrammarwareRootClassLineTNode >> rootToken [
	^ rootToken
]

{ #category : #generated }
GrammarwareRootClassLineTNode >> rootToken: aSmaCCToken [
	rootToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareRootClassLineTNode >> tokenVariables [
	^ #(#rootToken)
]
