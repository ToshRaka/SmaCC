Class {
	#name : #SmaCCMetavariableParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parserClass'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #initialization }
SmaCCMetavariableParserTest >> setUp [
	parserClass := SmaCCMetavariableParser 
]

{ #category : #tests }
SmaCCMetavariableParserTest >> testCommaList [
	parserClass parse: 'a : x ("," x)*'
]

{ #category : #tests }
SmaCCMetavariableParserTest >> testGroup [
	parserClass parse: 'a : (b c d) | e'
]

{ #category : #tests }
SmaCCMetavariableParserTest >> testGroupInSequence [
	parserClass parse: 'a : b c d | e'
]

{ #category : #tests }
SmaCCMetavariableParserTest >> testKeyword [
	parserClass parse: 'a : "|"'
]

{ #category : #tests }
SmaCCMetavariableParserTest >> testKleene [
	parserClass parse: 'a : (b c d)+ | e? | (f g)*'
]

{ #category : #tests }
SmaCCMetavariableParserTest >> testKleeneInSequence [
	parserClass parse: 'a : b+ c* d?'
]

{ #category : #tests }
SmaCCMetavariableParserTest >> testNode [
	parserClass parse: 'a : Node'
]

{ #category : #tests }
SmaCCMetavariableParserTest >> testToken [
	parserClass parse: 'a : <token>'
]

{ #category : #tests }
SmaCCMetavariableParserTest >> testWildcard [
	parserClass parse: '_ : _'
]

{ #category : #tests }
SmaCCMetavariableParserTest >> testWildcardKleene [
	parserClass parse: 'wildcard : _+'
]
