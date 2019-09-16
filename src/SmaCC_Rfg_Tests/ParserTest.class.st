Class {
	#name : #ParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parserClass'
	],
	#category : #'SmaCC_Rfg_Tests-Core'
}

{ #category : #accessing }
ParserTest class >> grammarString [
	self subclassResponsibility
]

{ #category : #accessing }
ParserTest class >> parserClass [
	^ self environment at: self parserClassSymbol
]

{ #category : #accessing }
ParserTest class >> parserClassSymbol [
	self subclassResponsibility
]

{ #category : #accessing }
ParserTest class >> scannerClass [
	^ self environment at: self scannerClassSymbol
]

{ #category : #accessing }
ParserTest class >> scannerClassSymbol [
	self subclassResponsibility
]

{ #category : #compiling }
ParserTest >> compileGrammar [
	| parserCompiler |
	(parserCompiler := SmaCCGrammarCompiler new) codeGenerator
		defaultCategory: self class category, '-Parser'.
	parserCompiler
		buildDefinition: self class grammarString.
	parserCompiler compileInto: self class scannerClassSymbol asString andParser: self class parserClassSymbol asString
]

{ #category : #initialization }
ParserTest >> setUp [
	self class environment at: self class parserClassSymbol ifAbsent: [ self compileGrammar ].
	parserClass := self class parserClass
]
