Class {
	#name : #ExampleFGLRParser,
	#superclass : #SmaCCFGLRParser,
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #'generated-accessing' }
ExampleFGLRParser class >> cacheId [
	^'2019-04-24T10:47:21.865342+02:00'
]

{ #category : #generated }
ExampleFGLRParser class >> definitionComment [
"<number> : [0-9]+ (\. [0-9]*) ? ;
<whitespace> : \s+;

<patternToken> : \` [^\`]* \` ;
%parserType fglr;

%annotate_tokens;
%ignore_variables leftParenToken rightParenToken;
%root Program;
%prefix Example;
%suffix Node;

%left ""+"" ""-"";
%left ""*"" ""/"";
%right ""^"";

Expression
	: Expression 'left' ""+"" 'operator' Expression 'right' {{Binary}}
	| Expression 'left' ""-"" 'operator' Expression 'right' {{Binary}}
	| Expression 'left' ""*"" 'operator' Expression 'right' {{Binary}}
	| Expression 'left' ""/"" 'operator' Expression 'right' {{Binary}}
	| Expression 'left' ""^"" 'operator' Expression 'right' {{Binary}}
	| ""("" Expression "")""
	| Number
	;

Number
	: <number> {{Number}}
	;"
]

{ #category : #generated }
ExampleFGLRParser class >> reduceTable [
^#(
	#(13 1 #reduceActionForNumber1:) 
	#(12 1 #liftFirstValue:) 
	#(12 3 #liftSecondValue:) 
	#(12 3 #reduceActionForExpression3:)
	).
]

{ #category : #'generated-accessing' }
ExampleFGLRParser class >> scannerClass [
	^ExampleFGLRScanner
]

{ #category : #generated }
ExampleFGLRParser class >> startingStateForExpression [
	^ 1
]

{ #category : #generated }
ExampleFGLRParser class >> symbolNames [
	^ #('"("' '")"' '"*"' '"+"' '"-"' '"/"' '"^"' '<number>' '<whitespace>' '<patternToken>' 'B e g i n' 'Expression' 'Number' 'E O F' 'error')
]

{ #category : #generated }
ExampleFGLRParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #ExampleProgramNode #ExampleProgramNode #ExampleNumberNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
ExampleFGLRParser class >> transitionTable [
^#(
#[1 0 9 0 1 0 13 0 8 0 17 0 12 0 17 0 13] 
#[1 0 9 0 1 0 13 0 8 0 25 0 12 0 25 0 13] 
#[0 0 6 0 2 0 3 0 4 0 5 0 6 0 7 0 14] 
#[1 0 29 0 3 0 33 0 4 0 37 0 5 0 41 0 6 0 45 0 7 0 0 0 14] 
#[0 0 10 0 2 0 3 0 4 0 5 0 6 0 7 0 14] 
#[1 0 49 0 2 0 29 0 3 0 33 0 4 0 37 0 5 0 41 0 6 0 45 0 7] 
#[1 0 9 0 1 0 13 0 8 0 53 0 12 0 53 0 13] 
#[1 0 9 0 1 0 13 0 8 0 57 0 12 0 57 0 13] 
#[1 0 9 0 1 0 13 0 8 0 61 0 12 0 61 0 13] 
#[1 0 9 0 1 0 13 0 8 0 65 0 12 0 65 0 13] 
#[1 0 9 0 1 0 13 0 8 0 69 0 12 0 69 0 13] 
#[0 0 14 0 2 0 3 0 4 0 5 0 6 0 7 0 14] 
#[1 0 18 0 2 0 18 0 3 0 18 0 4 0 18 0 5 0 18 0 6 0 45 0 7 0 18 0 14] 
#[1 0 18 0 2 0 29 0 3 0 18 0 4 0 18 0 5 0 41 0 6 0 45 0 7 0 18 0 14] 
#[1 0 18 0 2 0 29 0 3 0 18 0 4 0 18 0 5 0 41 0 6 0 45 0 7 0 18 0 14] 
#[1 0 18 0 2 0 18 0 3 0 18 0 4 0 18 0 5 0 18 0 6 0 45 0 7 0 18 0 14] 
#[1 0 18 0 2 0 18 0 3 0 18 0 4 0 18 0 5 0 18 0 6 0 45 0 7 0 18 0 14]
	).
]

{ #category : #'generated-reduction actions' }
ExampleFGLRParser >> reduceActionForExpression3: nodes [
	| result |
	result := ExampleBinaryNode new.
	result left: (nodes at: 1).
	result operator: (nodes at: 2).
	result right: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
ExampleFGLRParser >> reduceActionForNumber1: nodes [
	| result |
	result := ExampleNumberNode new.
	result numberToken: (nodes at: 1).
	^ result
]
