Class {
	#name : #ExpressionTest,
	#superclass : #ParserTest,
	#category : #'SmaCC_Rfg_Tests-Core'
}

{ #category : #accessing }
ExpressionTest class >> grammarString [
	^ '<number> : [0-9]+ (\. [0-9]*) ? ;
<whitespace> : \s+;

<patternToken> : \` [^\`]* \` ;
%parserType fglr;

%annotate_tokens;
%ignore_variables leftParenToken rightParenToken;
%root Program;
%prefix Example;
%suffix Node;

%left "+" "-";
%left "*" "/";
%right "^";

Expression
	: Expression ''left'' "+" ''operator'' Expression ''right'' {{Binary}}
	| Expression ''left'' "-" ''operator'' Expression ''right'' {{Binary}}
	| Expression ''left'' "*" ''operator'' Expression ''right'' {{Binary}}
	| Expression ''left'' "/" ''operator'' Expression ''right'' {{Binary}}
	| Expression ''left'' "^" ''operator'' Expression ''right'' {{Binary}}
	| "(" Expression ")"
	| Number
	;

Number
	: <number> {{Number}}
	;'
]

{ #category : #accessing }
ExpressionTest class >> parserClassSymbol [
	^ #ExampleFGLRParser
]

{ #category : #accessing }
ExpressionTest class >> scannerClassSymbol [
	^ #ExampleFGLRScanner
]

{ #category : #'tests-input' }
ExpressionTest >> testCompletingInput [
	| pat oldpat context matches |
	oldpat := RfgSyntacticPattern parserClass: parserClass patternString: '`a`+`b`+`c`'.
	context := (oldpat matchAgainstSource: '1+2+9') asOrderedCollection first context. 
	pat := RfgSyntacticPattern parserClass: parserClass patternString: '`a`+`b`+`c:ExampleNumberNode`'.
	pat contextAsInput: context.
	matches := pat matchAgainstSource: '1+2+9'.
	self assert: matches size equals: 1
]

{ #category : #'tests-concrete' }
ExpressionTest >> testConcreteNode [
	| pattern |
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '`a:ExampleNumberNode`'.
	self assert: (pattern matchAgainstSource: '1+2') size equals: 2
	

]

{ #category : #'tests-concrete' }
ExpressionTest >> testConcreteNode2 [
	| pattern |
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '`a:ExampleBinaryNode`'.
	self assert: (pattern matchAgainstSource: '1+2') size equals: 1
]

{ #category : #'tests-concrete' }
ExpressionTest >> testConcreteNodeAndToken [
	| pattern |
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '1+`a`'.
	self assert: (pattern matchAgainstSource: '1+2') size equals: 2
	

]

{ #category : #'tests-concrete' }
ExpressionTest >> testConcreteToken [
	| pattern |
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '`a:<number>`'.
	self assert: (pattern matchAgainstSource: '1+2') size equals: 4
	

]

{ #category : #'tests-concrete' }
ExpressionTest >> testConcreteWildcard [
	| pattern |
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '1+`_:_`'.
	self assert: (pattern matchAgainstSource: '1+2') size equals: 2
	

]

{ #category : #'tests-concrete' }
ExpressionTest >> testConcreteWildcardDepth2 [
	| pattern matches ast |
	ast := parserClass parse: '2+1+1'.
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '`_`+1'.
	matches := pattern matchAgainst: ast.
	self assert: matches size equals: 3
	

]

{ #category : #'tests-abstract' }
ExpressionTest >> testDoubleWildcard [
	| pattern |
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '1+`_:_`'.
	self assert: pattern getAbstractMatches size equals: 3
]

{ #category : #'tests-abstract' }
ExpressionTest >> testDoubleWildcardAndOption [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`_:_?`'.
	self assert: pattern getAbstractMatches size equals: 3
]

{ #category : #'tests-abstract' }
ExpressionTest >> testDoubleWildcardAndPlus [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`_:_+`'.
	self assert: pattern getAbstractMatches size equals: 3
]

{ #category : #'tests-abstract' }
ExpressionTest >> testDoubleWildcardAndStar [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`_:_*`'.
	self assert: pattern getAbstractMatches size equals: 3
]

{ #category : #'tests-input' }
ExpressionTest >> testInput [
	| pat oldpat context matches |
	oldpat := RfgSyntacticPattern parserClass: parserClass patternString: '`a`+`b`'.
	context := (oldpat matchAgainstSource: '1+2') asOrderedCollection first context. 
	pat := RfgSyntacticPattern parserClass: parserClass patternString: '`a`+`b`+`c:ExampleNumberNode`'.
	pat contextAsInput: context.
	matches := pat matchAgainstSource: '1+2+9'.
	self assert: matches size equals: 1
]

{ #category : #'tests-abstract' }
ExpressionTest >> testLoneMetavariable [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`a`'.
	self assert: pattern getAbstractMatches size equals: 3
]

{ #category : #'tests-abstract' }
ExpressionTest >> testNode [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`a:ExampleNumberNode`'.
	self assert: pattern getAbstractMatches size equals: 1
]

{ #category : #'tests-abstract' }
ExpressionTest >> testNode2 [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`a:ExampleBinaryNode`'.
	self assert: pattern getAbstractMatches size equals: 1
]

{ #category : #'tests-abstract' }
ExpressionTest >> testNodeAndOption [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`a:ExampleNumberNode?`'.
	self assert: pattern getAbstractMatches size equals: 1
]

{ #category : #'tests-abstract' }
ExpressionTest >> testNodeAndPlus [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`a:ExampleNumberNode+`'.
	self assert: pattern getAbstractMatches size equals: 1
]

{ #category : #'tests-abstract' }
ExpressionTest >> testNodeAndStar [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`a:ExampleNumberNode*`'.
	self assert: pattern getAbstractMatches size equals: 1
]

{ #category : #'tests-abstract' }
ExpressionTest >> testToken [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`a:<number>`'.
	self assert: pattern getAbstractMatches size equals: 1
]

{ #category : #'tests-abstract' }
ExpressionTest >> testTokenAndOption [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`a:<number>?`'.
	self assert: pattern getAbstractMatches size equals: 1
]

{ #category : #'tests-abstract' }
ExpressionTest >> testTokenAndPlus [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`a:<number>+`'.
	self assert: pattern getAbstractMatches size equals: 1
]

{ #category : #'tests-abstract' }
ExpressionTest >> testTokenAndStar [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`a:<number>*`'.
	self assert: pattern getAbstractMatches size equals: 1
]

{ #category : #'tests-transform' }
ExpressionTest >> testTransformLayout [
	| source pattern ast matches engine transform |
	source := '1 + 2+3'.
	ast := parserClass parse: source.
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '`a`+3'.
	matches := pattern matchAgainst: ast.
	transform := RfgStringTransformPattern parserClass: parserClass patternString: '3+`a`'.
	transform matches: matches.
	engine := RfgTransformEngine transforms: (OrderedCollection with: transform) ast: ast.
	self assert: engine rewrite equals: '3+1 + 2'
]

{ #category : #'tests-transform' }
ExpressionTest >> testTransformMultiTransforms [
	| ast transformA transformB engine |
	ast := parserClass parse: '1 + 2 + 3+  8'.
	transformA := RfgStringTransformPattern parserClass: parserClass patternString: '3+`a`'.
	transformA matches: ((RfgSyntacticPattern parserClass: parserClass patternString: '`a`+3') matchAgainst: ast).
	transformB := RfgStringTransformPattern parserClass: parserClass patternString: '5-`a`'.
	transformB matches: ((RfgSyntacticPattern parserClass: parserClass patternString: '`a`+2') matchAgainst: ast).
	engine := RfgTransformEngine transforms: (OrderedCollection with: transformA with: transformB) ast: ast.
	self assert: engine rewrite equals: '3+5-1+  8'
]

{ #category : #'tests-transform' }
ExpressionTest >> testTransformRecursive [
	| source pattern ast matches engine transform |
	source := '1+2+2'.
	ast := parserClass parse: source.
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '`a`+2'.
	matches := pattern matchAgainst: ast.
	transform := RfgStringTransformPattern parserClass: parserClass patternString: '2+`a`'.
	transform matches: matches.
	engine := RfgTransformEngine transforms: (OrderedCollection with: transform) ast: ast.
	self assert: engine rewrite equals: '2+2+1'
]

{ #category : #'tests-transform' }
ExpressionTest >> testTransformToken [
	| ast transformA engine |
	ast := parserClass parse: '1 + 2'.
	transformA := RfgStringTransformPattern parserClass: parserClass patternString: '`a` 1 2'.
	transformA matches: ((RfgSyntacticPattern parserClass: parserClass patternString: '1`a`2') matchAgainst: ast).
	engine := RfgTransformEngine transforms: (OrderedCollection with: transformA) ast: ast.
	self assert: engine rewrite equals: '+ 1 2'
]

{ #category : #'tests-transform' }
ExpressionTest >> testTransformTwoMetavariables [
	| source pattern ast matches engine transform |
	source := '1+2+2'.
	ast := parserClass parse: source.
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '`a`+`b`'.
	matches := pattern matchAgainst: ast.
	transform := RfgStringTransformPattern parserClass: parserClass patternString: '`b`+`a`'.
	transform matches: matches.
	engine := RfgTransformEngine transforms: (OrderedCollection with: transform) ast: ast.
	self assert: engine rewrite equals: '2+2+1'
]

{ #category : #'tests-abstract' }
ExpressionTest >> testWildcard [
	| pattern |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '1+`_`'.
	self assert: pattern getAbstractMatches size equals: 3
]
