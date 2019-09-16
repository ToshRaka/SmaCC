Class {
	#name : #GrammarwareSymbolTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'symbolName',
		'symbolnameToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareSymbolTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitSymbol: self
]

{ #category : #generated }
GrammarwareSymbolTNode >> symbolName [
	^ symbolName
]

{ #category : #generated }
GrammarwareSymbolTNode >> symbolName: aSmaCCToken [
	symbolName := aSmaCCToken
]

{ #category : #generated }
GrammarwareSymbolTNode >> symbolnameToken [
	^ symbolnameToken
]

{ #category : #generated }
GrammarwareSymbolTNode >> symbolnameToken: aSmaCCToken [
	symbolnameToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareSymbolTNode >> tokenVariables [
	^ #(#symbolName #symbolnameToken)
]
