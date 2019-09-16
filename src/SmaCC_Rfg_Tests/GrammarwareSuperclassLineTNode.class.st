Class {
	#name : #GrammarwareSuperclassLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'hierarchyToken',
		'superclass',
		'leftParenToken',
		'classeses',
		'rightParenToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareSuperclassLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitSuperclassLine: self
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> classeses [
	^ classeses
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> classeses: anOrderedCollection [
	self setParents: self classeses to: nil.
	classeses := anOrderedCollection.
	self setParents: self classeses to: self
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> compositeNodeVariables [
	^ #(#classeses #rules)
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> hierarchyToken [
	^ hierarchyToken
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> hierarchyToken: aSmaCCToken [
	hierarchyToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
GrammarwareSuperclassLineTNode >> initialize [
	super initialize.
	classeses := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> leftParenToken [
	^ leftParenToken
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> leftParenToken: aSmaCCToken [
	leftParenToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> nodeVariables [
	^ #(#superclass)
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> rightParenToken [
	^ rightParenToken
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> rightParenToken: aSmaCCToken [
	rightParenToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> superclass [
	^ superclass
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> superclass: aGrammarwareSymbolTNode [
	self superclass notNil
		ifTrue: [ self superclass parent: nil ].
	superclass := aGrammarwareSymbolTNode.
	self superclass notNil
		ifTrue: [ self superclass parent: self ]
]

{ #category : #generated }
GrammarwareSuperclassLineTNode >> tokenVariables [
	^ #(#hierarchyToken #leftParenToken #rightParenToken)
]
