Class {
	#name : #GrammarwareOptionalTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'term',
		'questionMarkToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareOptionalTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitOptionalTerm: self
]

{ #category : #generated }
GrammarwareOptionalTermTNode >> nodeVariables [
	^ #(#term)
]

{ #category : #generated }
GrammarwareOptionalTermTNode >> questionMarkToken [
	^ questionMarkToken
]

{ #category : #generated }
GrammarwareOptionalTermTNode >> questionMarkToken: aSmaCCToken [
	questionMarkToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareOptionalTermTNode >> term [
	^ term
]

{ #category : #generated }
GrammarwareOptionalTermTNode >> term: aGrammarwareFileTNode [
	self term notNil
		ifTrue: [ self term parent: nil ].
	term := aGrammarwareFileTNode.
	self term notNil
		ifTrue: [ self term parent: self ]
]

{ #category : #generated }
GrammarwareOptionalTermTNode >> tokenVariables [
	^ #(#questionMarkToken)
]
