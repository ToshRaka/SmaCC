Class {
	#name : #FGLRGrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'parserClass',
		'scannerClass'
	],
	#category : #'SmaCC_FGLR_Runtime-Tests'
}

{ #category : #compiling }
FGLRGrammarTest class >> grammarString [
	self subclassResponsibility
]

{ #category : #compiling }
FGLRGrammarTest class >> packageName [
	self subclassResponsibility
]

{ #category : #compiling }
FGLRGrammarTest class >> parserClassSymbol [
	self subclassResponsibility
]

{ #category : #compiling }
FGLRGrammarTest class >> scannerClassSymbol [
	self subclassResponsibility
]

{ #category : #compiling }
FGLRGrammarTest >> compileGrammar: aString intoScanner: aSymbol andParser: bSymbol [
	| parserCompiler |
	(parserCompiler := SmaCCGrammarCompiler new) codeGenerator
		defaultCategory: self class packageName.
	parserCompiler buildDefinition: aString.
	parserCompiler
		compileInto: aSymbol asString
		andParser: bSymbol asString.
	scannerClass := self class environment at: aSymbol.
	parserClass := self class environment at: bSymbol
]

{ #category : #running }
FGLRGrammarTest >> setUp [
	super setUp.
	self compileGrammar: self class grammarString
		intoScanner: self class scannerClassSymbol 
		andParser: self class parserClassSymbol

]

{ #category : #running }
FGLRGrammarTest >> tearDown [
	(RPackageOrganizer default packageNamed: self class packageName) 
		classes do: [ :each | each removeFromSystem ].
	super tearDown
]
