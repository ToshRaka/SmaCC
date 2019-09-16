Class {
	#name : #SmaCCSyntacticRefactoring,
	#superclass : #SmaCCRefactoring,
	#instVars : [
		'startingState',
		'pattern',
		'filter',
		'transformation',
		'rewriter'
	],
	#category : #'SmaCC_Rfg-Core'
}

{ #category : #accessing }
SmaCCSyntacticRefactoring class >> rewriter: aSmaCCRewriteEngine [
	^ self new rewriter: aSmaCCRewriteEngine
]

{ #category : #compiling }
SmaCCSyntacticRefactoring >> compilePattern [
	| fullPattern |
	fullPattern := ReadWriteStream on: ''.
	fullPattern 
		nextPutAll: 'Parser: ';
		nextPutAll: parserClass asString.
	startingState ifNotNil: [ 
		fullPattern cr;
			nextPutAll: startingState ].
	fullPattern
		cr;
		nextPutAll: '>>>';
		nextPutAll: pattern;
		nextPutAll: '<<<'.
	fullPattern 
		cr; nextPutAll: '->'; cr;
		nextPutAll: '>>>';
		nextPutAll: transformation;
		nextPutAll: '<<<'.
	pattern := fullPattern contents
]

{ #category : #accessing }
SmaCCSyntacticRefactoring >> pattern: aString [
	pattern := aString
]

{ #category : #public }
SmaCCSyntacticRefactoring >> redo [
	self shouldBeImplemented
]

{ #category : #accessing }
SmaCCSyntacticRefactoring >> rewriter: aSmaCCRewriteEngine [
	rewriter := aSmaCCRewriteEngine
]

{ #category : #private }
SmaCCSyntacticRefactoring >> transform [
	self compilePattern.
	rewriter rewriteRule: (SmaCCRewriteRuleFileParser parse: pattern).
	ast ifNil: [ ast := parserClass parse: source ].
	result properties at: 'src' put: (rewriter rewriteTree: ast).
]

{ #category : #accessing }
SmaCCSyntacticRefactoring >> transformation: aString [
	transformation := aString
]

{ #category : #public }
SmaCCSyntacticRefactoring >> undo [
	self shouldBeImplemented
]
