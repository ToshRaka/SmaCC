Class {
	#name : #GrammarwareOptionalRegexTermTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'term',
		'questionMarkToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareOptionalRegexTermTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitOptionalRegexTerm: self
]

{ #category : #generated }
GrammarwareOptionalRegexTermTNode >> nodeVariables [
	^ #(#term)
]

{ #category : #generated }
GrammarwareOptionalRegexTermTNode >> questionMarkToken [
	^ questionMarkToken
]

{ #category : #generated }
GrammarwareOptionalRegexTermTNode >> questionMarkToken: aSmaCCToken [
	questionMarkToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareOptionalRegexTermTNode >> term [
	^ term
]

{ #category : #generated }
GrammarwareOptionalRegexTermTNode >> term: aGrammarwareFileTNode [
	self term notNil
		ifTrue: [ self term parent: nil ].
	term := aGrammarwareFileTNode.
	self term notNil
		ifTrue: [ self term parent: self ]
]

{ #category : #generated }
GrammarwareOptionalRegexTermTNode >> tokenVariables [
	^ #(#questionMarkToken)
]
