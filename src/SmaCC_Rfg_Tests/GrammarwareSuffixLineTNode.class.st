Class {
	#name : #GrammarwareSuffixLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'suffixToken',
		'suffix'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareSuffixLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitSuffixLine: self
]

{ #category : #generated }
GrammarwareSuffixLineTNode >> nodeVariables [
	^ #(#suffix)
]

{ #category : #generated }
GrammarwareSuffixLineTNode >> suffix [
	^ suffix
]

{ #category : #generated }
GrammarwareSuffixLineTNode >> suffix: aGrammarwareSymbolTNode [
	self suffix notNil
		ifTrue: [ self suffix parent: nil ].
	suffix := aGrammarwareSymbolTNode.
	self suffix notNil
		ifTrue: [ self suffix parent: self ]
]

{ #category : #generated }
GrammarwareSuffixLineTNode >> suffixToken [
	^ suffixToken
]

{ #category : #generated }
GrammarwareSuffixLineTNode >> suffixToken: aSmaCCToken [
	suffixToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareSuffixLineTNode >> tokenVariables [
	^ #(#suffixToken)
]
