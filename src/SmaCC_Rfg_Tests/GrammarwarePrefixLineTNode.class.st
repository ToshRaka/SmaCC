Class {
	#name : #GrammarwarePrefixLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'prefixToken',
		'prefix'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwarePrefixLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitPrefixLine: self
]

{ #category : #generated }
GrammarwarePrefixLineTNode >> nodeVariables [
	^ #(#prefix)
]

{ #category : #generated }
GrammarwarePrefixLineTNode >> prefix [
	^ prefix
]

{ #category : #generated }
GrammarwarePrefixLineTNode >> prefix: aGrammarwareSymbolTNode [
	self prefix notNil
		ifTrue: [ self prefix parent: nil ].
	prefix := aGrammarwareSymbolTNode.
	self prefix notNil
		ifTrue: [ self prefix parent: self ]
]

{ #category : #generated }
GrammarwarePrefixLineTNode >> prefixToken [
	^ prefixToken
]

{ #category : #generated }
GrammarwarePrefixLineTNode >> prefixToken: aSmaCCToken [
	prefixToken := aSmaCCToken
]

{ #category : #generated }
GrammarwarePrefixLineTNode >> tokenVariables [
	^ #(#prefixToken)
]
