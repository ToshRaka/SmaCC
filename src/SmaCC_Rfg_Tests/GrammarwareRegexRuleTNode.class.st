Class {
	#name : #GrammarwareRegexRuleTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'token',
		'productionToken',
		'regex',
		'semicolonToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareRegexRuleTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitRegexRule: self
]

{ #category : #generated }
GrammarwareRegexRuleTNode >> nodeVariables [
	^ #(#regex)
]

{ #category : #generated }
GrammarwareRegexRuleTNode >> productionToken [
	^ productionToken
]

{ #category : #generated }
GrammarwareRegexRuleTNode >> productionToken: aSmaCCToken [
	productionToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareRegexRuleTNode >> regex [
	^ regex
]

{ #category : #generated }
GrammarwareRegexRuleTNode >> regex: aGrammarwareFileTNode [
	self regex notNil
		ifTrue: [ self regex parent: nil ].
	regex := aGrammarwareFileTNode.
	self regex notNil
		ifTrue: [ self regex parent: self ]
]

{ #category : #generated }
GrammarwareRegexRuleTNode >> semicolonToken [
	^ semicolonToken
]

{ #category : #generated }
GrammarwareRegexRuleTNode >> semicolonToken: aSmaCCToken [
	semicolonToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareRegexRuleTNode >> token [
	^ token
]

{ #category : #generated }
GrammarwareRegexRuleTNode >> token: aSmaCCToken [
	token := aSmaCCToken
]

{ #category : #generated }
GrammarwareRegexRuleTNode >> tokenVariables [
	^ #(#token #productionToken #semicolonToken)
]
