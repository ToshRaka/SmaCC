Class {
	#name : #ListMatchTest,
	#superclass : #ParserTest,
	#category : #'SmaCC_Rfg_Tests-Core'
}

{ #category : #accessing }
ListMatchTest class >> grammarString [
	^ '<number> : [0-9]+ ;
<identifier> : [a-zA-Z] [a-zA-Z0-9]* ;
<whitespace> : \s+ ;

%parserType fglr;
<patternToken> : \` [^`]+ \` ;

%root Program ;
%prefix ListMatch ;
%suffix Node ;


Root
	: List ''list'' (";" List ''list'') * {{Root}}
	;

List
	: StandardList
	| CommaSeparatedList
	;

StandardList
	: Identifier ''elem'' + {{}} 
	;

CommaSeparatedList
	: Number ''elem'' ("," Number ''elem'') * {{}}
	;
	
Number
	: <number> ''token'' {{}}
	;
	
Identifier
	: <identifier> ''token'' {{}}
	;'
]

{ #category : #accessing }
ListMatchTest class >> parserClassSymbol [
	^ #ListMatchParser
]

{ #category : #accessing }
ListMatchTest class >> scannerClassSymbol [
	^ #ListMatchScanner
]

{ #category : #'test-abstract' }
ListMatchTest >> testAbstractCommaSeperatedList [
	| pattern amatches |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '`a:ListMatchNumberNode ("," ListMatchNumberNode)*`'.
	amatches := pattern getAbstractMatches.
	self assert: amatches size equals: 2 
]

{ #category : #'test-abstract' }
ListMatchTest >> testAbstractStandardListPlus [
	| pattern amatches |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '`a:ListMatchIdentifierNode+`'.
	amatches := pattern getAbstractMatches.
	self assert: amatches size equals: 4
]

{ #category : #'test-abstract' }
ListMatchTest >> testAbstractStandardListStar [
	| pattern amatches |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '`a:ListMatchIdentifierNode*`'.
	amatches := pattern getAbstractMatches.
	self assert: amatches size equals: 4
]

{ #category : #'test-concrete' }
ListMatchTest >> testCommaSeperatedList [
	| pattern matches |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '`a:ListMatchNumberNode ("," ListMatchNumberNode)*`'.
	pattern getAbstractMatches.
	matches := pattern matchAgainstSource: '1, 2, 3'.
	self assert: matches size equals: 2 
]

{ #category : #'test-concrete' }
ListMatchTest >> testCommaSeperatedListEmptyTail [
	| pattern matches |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '`a:ListMatchNumberNode ("," ListMatchNumberNode)*`'.
	pattern getAbstractMatches.
	matches := pattern matchAgainstSource: '1'.
	self assert: matches size equals: 2
]

{ #category : #'test-concrete' }
ListMatchTest >> testStandardListPlus [
	| pattern matches |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '`a:ListMatchIdentifierNode+`'.
	pattern getAbstractMatches.
	matches := pattern matchAgainstSource: 'a b c'.
	self assert: matches size equals: 2 
]

{ #category : #'test-concrete' }
ListMatchTest >> testStandardListStar [
	| pattern matches |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '`a:ListMatchIdentifierNode*`'.
	pattern getAbstractMatches.
	matches := pattern matchAgainstSource: 'a b c'.
	self assert: matches size equals: 2 
]
