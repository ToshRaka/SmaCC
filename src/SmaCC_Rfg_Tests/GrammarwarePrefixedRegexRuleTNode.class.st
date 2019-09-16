Class {
	#name : #GrammarwarePrefixedRegexRuleTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'scannerRule',
		'state',
		'prefixedRule'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwarePrefixedRegexRuleTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitPrefixedRegexRule: self
]

{ #category : #generated }
GrammarwarePrefixedRegexRuleTNode >> nodeVariables [
	^ #(#scannerRule #state #prefixedRule)
]

{ #category : #generated }
GrammarwarePrefixedRegexRuleTNode >> prefixedRule [
	^ prefixedRule
]

{ #category : #generated }
GrammarwarePrefixedRegexRuleTNode >> prefixedRule: aGrammarwarePrefixedRegexRuleTNode [
	self prefixedRule notNil
		ifTrue: [ self prefixedRule parent: nil ].
	prefixedRule := aGrammarwarePrefixedRegexRuleTNode.
	self prefixedRule notNil
		ifTrue: [ self prefixedRule parent: self ]
]

{ #category : #generated }
GrammarwarePrefixedRegexRuleTNode >> scannerRule [
	^ scannerRule
]

{ #category : #generated }
GrammarwarePrefixedRegexRuleTNode >> scannerRule: aGrammarwareRegexRuleTNode [
	self scannerRule notNil
		ifTrue: [ self scannerRule parent: nil ].
	scannerRule := aGrammarwareRegexRuleTNode.
	self scannerRule notNil
		ifTrue: [ self scannerRule parent: self ]
]

{ #category : #generated }
GrammarwarePrefixedRegexRuleTNode >> state [
	^ state
]

{ #category : #generated }
GrammarwarePrefixedRegexRuleTNode >> state: aGrammarwareSymbolTNode [
	self state notNil
		ifTrue: [ self state parent: nil ].
	state := aGrammarwareSymbolTNode.
	self state notNil
		ifTrue: [ self state parent: self ]
]
