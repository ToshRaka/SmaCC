Class {
	#name : #FGLRExpressionTest,
	#superclass : #FGLRGrammarTest,
	#category : #'SmaCC_FGLR_Runtime-Tests'
}

{ #category : #compiling }
FGLRExpressionTest class >> grammarString [
	^ '
%parserType fglr;	
<number> : [0-9]+ (\. [0-9]+)? ;
<variable> : [_]* [a-zA-Z] [a-zA-Z0-9_]* ;
<whitespace> : \s+ ;

%left "+" "-" ;
%left "*" "/" ;
%right "^" ;

<patternToken> : \` [^`]+ \`;

%start Expression Operand;

%root Program;
%prefix FGLRTest;
%suffix Node;

%annotate_tokens;

Expression
    : Expression ''left'' "+" Expression ''right'' {{Binary}}
    | Expression ''left'' "-" Expression ''right'' {{Binary}}
    | Expression ''left'' "*" Expression ''right'' {{Binary}}
    | Expression ''left'' "/" Expression ''right'' {{Binary}}
    | Expression ''left'' "^" Expression ''right'' {{}}
    | "(" Expression ''left'' ")" {{}}
    | Operand
    ;

Operand
    : <number> {{Number}}
    | <variable> {{Variable}}
    ;'
]

{ #category : #compiling }
FGLRExpressionTest class >> packageName [
	^ 'SmaCC_FGLR_Runtime_TestExpression'
]

{ #category : #compiling }
FGLRExpressionTest class >> parserClassSymbol [
	^ #FGLRTestExpressionParser
]

{ #category : #compiling }
FGLRExpressionTest class >> scannerClassSymbol [
	^ #FGLRTestExpressionScanner
]

{ #category : #tests }
FGLRExpressionTest >> testAddition [
	| result |
	result := parserClass parse: '1+2'.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]

{ #category : #tests }
FGLRExpressionTest >> testComplexExp [
	| result |
	result := parserClass parse: '1+2*12/43^64-(45/3)'.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]

{ #category : #tests }
FGLRExpressionTest >> testDivisionExp [
	| result |
	result := parserClass parse: '1/2'.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]

{ #category : #tests }
FGLRExpressionTest >> testFloatingPointExp [
	| result |
	result := parserClass parse: '1.12+2.34'.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]

{ #category : #tests }
FGLRExpressionTest >> testMultiplicationExp [
	| result |
	result := parserClass parse: '1*2'.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]

{ #category : #tests }
FGLRExpressionTest >> testParenthesizedExp [
	| result |
	result := parserClass parse: '(1+2)'.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]

{ #category : #tests }
FGLRExpressionTest >> testPowerExp [
	| result |
	result := parserClass parse: '1^2'.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]

{ #category : #tests }
FGLRExpressionTest >> testSimpleExp [
	| result |
	result := parserClass parse: '1*2'.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]

{ #category : #tests }
FGLRExpressionTest >> testSubtractionExp [
	| result |
	result := parserClass parse: '1-2'.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]

{ #category : #tests }
FGLRExpressionTest >> testVariableExp [
	| result |
	result := parserClass parse: 'a+b'.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]

{ #category : #tests }
FGLRExpressionTest >> testVariableExp2 [
	| result |
	result := parserClass parse: 'anExpression + anotherExpression'.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]

{ #category : #tests }
FGLRExpressionTest >> testVariableExp3 [
	| result |
	result := parserClass parse: '_aVariable + ___another_variable_'.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]

{ #category : #tests }
FGLRExpressionTest >> testWhitespace [
	| result |
	result := parserClass parse: '   1    +  2  '.
	self assert: result isNotNil.
	(result isKindOf: Collection)
		ifTrue: [ self assert: result isNotEmpty ]
]
