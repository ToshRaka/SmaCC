Class {
	#name : #ListMatchParser,
	#superclass : #SmaCCFGLRParser,
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #'generated-accessing' }
ListMatchParser class >> cacheId [
	^'2019-07-10T10:13:06.359024+02:00'
]

{ #category : #generated }
ListMatchParser class >> definitionComment [
"<number> : [0-9]+ ;
<identifier> : [a-zA-Z] [a-zA-Z0-9]* ;
<whitespace> : \s+ ;

%parserType fglr;
<patternToken> : \` [^`]+ \` ;

%root Program ;
%prefix ListMatch ;
%suffix Node ;
%annotate_tokens;


Root
	: List 'list' ("";"" List 'list') * {{Root}}
	;

List
	: StandardList
	| CommaSeparatedList
	;

StandardList
	: Identifier 'elem' + {{}} 
	;

CommaSeparatedList
	: Number 'elem' ("","" Number 'elem') * {{}}
	;
	
Number
	: <number> 'token' {{}}
	;
	
Identifier
	: <identifier> 'token' {{}}
	;"
]

{ #category : #generated }
ListMatchParser class >> reduceTable [
^#(
	#(17 1 #reduceActionForNumber1:) 
	#(18 1 #reduceActionForIdentifier1:) 
	#(10 0 #reduceActionFor_____List__list____1:) 
	#(11 1 #liftFirstValue:) 
	#(12 1 #reduceActionForStandardList1:) 
	#(16 0 #reduceActionFor_____List__list____1:) 
	#(13 1 #reduceActionForIdentifier__elem___1:) 
	#(8 2 #reduceActionForRoot1:) 
	#(13 2 #reduceActionForIdentifier__elem___2:) 
	#(14 2 #reduceActionForCommaSeparatedList1:) 
	#(10 2 #reduceActionFor_____List__list____2:) 
	#(16 2 #reduceActionFor_____List__list____2:) 
	#(9 2 #reduceActionFor_____List__list__1:) 
	#(15 2 #reduceActionFor_____List__list__1:)
	).
]

{ #category : #'generated-accessing' }
ListMatchParser class >> scannerClass [
	^ListMatchScanner
]

{ #category : #generated }
ListMatchParser class >> startingStateForRoot [
	^ 1
]

{ #category : #generated }
ListMatchParser class >> symbolNames [
	^ #('","' '";"' '<number>' '<identifier>' '<whitespace>' '<patternToken>' 'B e g i n' 'Root' '(";" List ''list'')' '(";" List ''list'') *' 'List' 'StandardList' 'Identifier ''elem'' +' 'CommaSeparatedList' '("," Number ''elem'')' '("," Number ''elem'') *' 'Number' 'Identifier' 'E O F' 'error')
]

{ #category : #generated }
ListMatchParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #ListMatchRootNode #ListMatchRootNode #OrderedCollection #OrderedCollection #ListMatchProgramNode #ListMatchStandardListNode #OrderedCollection #ListMatchCommaSeparatedListNode #OrderedCollection #OrderedCollection #ListMatchNumberNode #ListMatchIdentifierNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
ListMatchParser class >> transitionTable [
^#(
#[1 0 9 0 3 0 13 0 4 0 17 0 8 0 21 0 11 0 21 0 12 0 29 0 13 0 21 0 14 0 37 0 17 0 41 0 18] 
#[0 0 6 0 1 0 2 0 19] 
#[0 0 10 0 2 0 4 0 19] 
#[0 0 0 0 19] 
#[1 0 14 0 2 0 45 0 10 0 14 0 19] 
#[0 0 18 0 2 0 19] 
#[1 0 22 0 2 0 13 0 4 0 49 0 18 0 22 0 19] 
#[0 0 18 0 2 0 19] 
#[1 0 26 0 1 0 26 0 2 0 53 0 16 0 26 0 19] 
#[0 0 30 0 2 0 4 0 19] 
#[1 0 57 0 2 0 61 0 9 0 34 0 19] 
#[0 0 38 0 2 0 4 0 19] 
#[1 0 65 0 1 0 42 0 2 0 69 0 15 0 42 0 19] 
#[1 0 9 0 3 0 13 0 4 0 73 0 11 0 73 0 12 0 29 0 13 0 73 0 14 0 37 0 17 0 41 0 18] 
#[0 0 46 0 2 0 19] 
#[1 0 9 0 3 0 77 0 17] 
#[0 0 50 0 1 0 2 0 19] 
#[0 0 54 0 2 0 19] 
#[0 0 58 0 1 0 2 0 19]
	).
]

{ #category : #'generated-reduction actions' }
ListMatchParser >> reduceActionForCommaSeparatedList1: nodes [
	| result |
	result := ListMatchCommaSeparatedListNode new.
	result addNode: (nodes at: 1) to: result elems.
	result addTokens: ((nodes at: 2) at: 1) to: result commaTokens.
	result addNodes: ((nodes at: 2) at: 2) to: result elems.
	^ result
]

{ #category : #'generated-reduction actions' }
ListMatchParser >> reduceActionForIdentifier1: nodes [
	| result |
	result := ListMatchIdentifierNode new.
	result token: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
ListMatchParser >> reduceActionForIdentifier__elem___1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
ListMatchParser >> reduceActionForIdentifier__elem___2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
ListMatchParser >> reduceActionForNumber1: nodes [
	| result |
	result := ListMatchNumberNode new.
	result token: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
ListMatchParser >> reduceActionForRoot1: nodes [
	| result |
	result := ListMatchRootNode new.
	result addNode: (nodes at: 1) to: result lists.
	result addTokens: ((nodes at: 2) at: 1) to: result semicolonTokens.
	result addNodes: ((nodes at: 2) at: 2) to: result lists.
	^ result
]

{ #category : #'generated-reduction actions' }
ListMatchParser >> reduceActionForStandardList1: nodes [
	| result |
	result := ListMatchStandardListNode new.
	result addNodes: (nodes at: 1) to: result elems.
	^ result
]

{ #category : #'generated-reduction actions' }
ListMatchParser >> reduceActionFor_____List__list__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
ListMatchParser >> reduceActionFor_____List__list____1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
ListMatchParser >> reduceActionFor_____List__list____2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]
