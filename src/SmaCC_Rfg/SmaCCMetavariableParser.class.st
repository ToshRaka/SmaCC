Class {
	#name : #SmaCCMetavariableParser,
	#superclass : #SmaCCParser,
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #'generated-accessing' }
SmaCCMetavariableParser class >> cacheId [
	^'2019-05-06T11:32:47.942937+02:00'
]

{ #category : #generated }
SmaCCMetavariableParser class >> definitionComment [
"%root Metavariable;
%prefix Metav;
%suffix Node;

%annotate_tokens;

%left ""?"" ""+"" ""*"";
%left ""|"";

<identifier> : [A-Z][a-zA-Z0-9_]* ;
<metavariable> : [a-z][a-zA-Z0-9_]* ;
<token> : [<] [a-zA-Z][a-zA-Z0-9_]* [>] ;
<keyword> : [""] [^""]+ [""] ;
<whitespace> : \s+ ;

Metavariable
	: <metavariable> 'metavariableName' ("":"" Expression 'expression') ? {{Declaration}}
	| ""_"" 'metavariableName' ("":"" Expression 'expression') ? {{Declaration}} ;
	
Expression
	: EnhancedOperandList 'alternative' (""|"" EnhancedOperandList 'alternative')* {{OR}} ;

EnhancedOperand
	: Operand 'left' ""*"" {{KleeneStar}}
	| Operand 'left' ""*?"" {{NonGreedyKleeneStar}}
	| Operand 'left' ""+"" {{KleenePlus}}
	| Operand 'left' ""+?"" {{NonGreedyKleenePlus}}
	| Operand 'left' ""?"" {{Option}} 
	| Operand ;

EnhancedOperandList
	: EnhancedOperand 'operand' + {{}} ;

Operand
	: ""_"" {{Wildcard}}
	| <identifier> 'symbolName' {{Symbol}}
	| <metavariable> 'metavariableName' {{Embedded}}
	| <token> 'tokenName' {{Token}}
	| <keyword> 'keywordName' {{Keyword}} 
	| ""("" Expression 'expression' "")"" {{Group}} ;"
]

{ #category : #generated }
SmaCCMetavariableParser class >> reduceTable [
^#(
	#(17 1 #reduceActionForMetavariable3:) 
	#(24 1 #reduceActionForOperand1:) 
	#(24 1 #reduceActionForOperand2:) 
	#(24 1 #reduceActionForOperand3:) 
	#(24 1 #reduceActionForOperand4:) 
	#(24 1 #reduceActionForOperand5:) 
	#(17 3 #reduceActionForMetavariable4:) 
	#(23 1 #reduceActionForEnhancedOperand__operand___1:) 
	#(20 0 #reduceActionFor_____EnhancedOperandList__alternative___1:) 
	#(22 1 #reduceActionForEnhancedOperandList1:) 
	#(21 1 #liftFirstValue:) 
	#(18 2 #reduceActionForExpression1:) 
	#(23 2 #reduceActionForEnhancedOperand__operand___2:) 
	#(21 2 #reduceActionForEnhancedOperand1:) 
	#(21 2 #reduceActionForEnhancedOperand2:) 
	#(21 2 #reduceActionForEnhancedOperand3:) 
	#(21 2 #reduceActionForEnhancedOperand4:) 
	#(21 2 #reduceActionForEnhancedOperand5:) 
	#(24 3 #reduceActionForOperand6:) 
	#(20 2 #reduceActionFor_____EnhancedOperandList__alternative___2:) 
	#(19 2 #reduceActionFor_____EnhancedOperandList__alternative__1:)
	).
]

{ #category : #'generated-accessing' }
SmaCCMetavariableParser class >> scannerClass [
	^SmaCCMetavariableScanner
]

{ #category : #generated }
SmaCCMetavariableParser class >> startingStateForMetavariable [
	^ 1
]

{ #category : #generated }
SmaCCMetavariableParser class >> symbolNames [
	^ #('"("' '")"' '"*"' '"*?"' '"+"' '"+?"' '":"' '"?"' '"_"' '"|"' '<identifier>' '<metavariable>' '<token>' '<keyword>' '<whitespace>' 'B e g i n' 'Metavariable' 'Expression' '("|" EnhancedOperandList ''alternative'')' '("|" EnhancedOperandList ''alternative'')*' 'EnhancedOperand' 'EnhancedOperandList' 'EnhancedOperand ''operand'' +' 'Operand' 'E O F' 'error')
]

{ #category : #generated }
SmaCCMetavariableParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #MetavDeclarationNode #MetavDeclarationNode #MetavORNode #OrderedCollection #OrderedCollection #MetavMetavariableNode #MetavEnhancedOperandListNode #OrderedCollection #MetavMetavariableNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
SmaCCMetavariableParser class >> transitionTable [
^#(
#[1 0 9 0 9 0 13 0 12 0 17 0 17] 
#[1 0 21 0 7 0 6 0 25] 
#[1 0 25 0 7 0 6 0 25] 
#[0 0 0 0 25] 
#[1 0 29 0 1 0 33 0 9 0 37 0 11 0 41 0 12 0 45 0 13 0 49 0 14 0 53 0 18 0 57 0 21 0 61 0 22 0 65 0 23 0 69 0 24] 
#[1 0 29 0 1 0 33 0 9 0 37 0 11 0 41 0 12 0 45 0 13 0 49 0 14 0 73 0 18 0 57 0 21 0 61 0 22 0 65 0 23 0 69 0 24] 
#[1 0 29 0 1 0 33 0 9 0 37 0 11 0 41 0 12 0 45 0 13 0 49 0 14 0 77 0 18 0 57 0 21 0 61 0 22 0 65 0 23 0 69 0 24] 
#[0 0 10 0 1 0 2 0 3 0 4 0 5 0 6 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[0 0 14 0 1 0 2 0 3 0 4 0 5 0 6 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[0 0 18 0 1 0 2 0 3 0 4 0 5 0 6 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[0 0 22 0 1 0 2 0 3 0 4 0 5 0 6 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[0 0 26 0 1 0 2 0 3 0 4 0 5 0 6 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[0 0 30 0 25] 
#[0 0 34 0 1 0 2 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[1 0 38 0 2 0 38 0 10 0 81 0 20 0 38 0 25] 
#[1 0 29 0 1 0 42 0 2 0 33 0 9 0 42 0 10 0 37 0 11 0 41 0 12 0 45 0 13 0 49 0 14 0 85 0 21 0 69 0 24 0 42 0 25] 
#[1 0 46 0 1 0 46 0 2 0 89 0 3 0 93 0 4 0 97 0 5 0 101 0 6 0 105 0 8 0 46 0 9 0 46 0 10 0 46 0 11 0 46 0 12 0 46 0 13 0 46 0 14 0 46 0 25] 
#[0 0 30 0 25] 
#[0 0 109 0 2] 
#[1 0 50 0 2 0 113 0 10 0 117 0 19 0 50 0 25] 
#[0 0 54 0 1 0 2 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[0 0 58 0 1 0 2 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[0 0 62 0 1 0 2 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[0 0 66 0 1 0 2 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[0 0 70 0 1 0 2 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[0 0 74 0 1 0 2 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[0 0 78 0 1 0 2 0 3 0 4 0 5 0 6 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 25] 
#[1 0 29 0 1 0 33 0 9 0 37 0 11 0 41 0 12 0 45 0 13 0 49 0 14 0 57 0 21 0 121 0 22 0 65 0 23 0 69 0 24] 
#[0 0 82 0 2 0 10 0 25] 
#[0 0 86 0 2 0 10 0 25]
	).
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForEnhancedOperand1: nodes [
	| result |
	result := MetavKleeneStarNode new.
	result left: (nodes at: 1).
	result timesToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForEnhancedOperand2: nodes [
	| result |
	result := MetavNonGreedyKleeneStarNode new.
	result left: (nodes at: 1).
	result timesQuestionMarkToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForEnhancedOperand3: nodes [
	| result |
	result := MetavKleenePlusNode new.
	result left: (nodes at: 1).
	result plusToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForEnhancedOperand4: nodes [
	| result |
	result := MetavNonGreedyKleenePlusNode new.
	result left: (nodes at: 1).
	result plusQuestionMarkToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForEnhancedOperand5: nodes [
	| result |
	result := MetavOptionNode new.
	result left: (nodes at: 1).
	result questionMarkToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForEnhancedOperandList1: nodes [
	| result |
	result := MetavEnhancedOperandListNode new.
	result addNodes: (nodes at: 1) to: result operands.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForEnhancedOperand__operand___1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForEnhancedOperand__operand___2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForExpression1: nodes [
	| result |
	result := MetavORNode new.
	result addNode: (nodes at: 1) to: result alternatives.
	result addTokens: ((nodes at: 2) at: 1) to: result orTokens.
	result addNodes: ((nodes at: 2) at: 2) to: result alternatives.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForMetavariable3: nodes [
	| result |
	result := MetavDeclarationNode new.
	result metavariableName: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForMetavariable4: nodes [
	| result |
	result := MetavDeclarationNode new.
	result metavariableName: (nodes at: 1).
	result colonToken: (nodes at: 2).
	result expression: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForOperand1: nodes [
	| result |
	result := MetavWildcardNode new.
	result _Token: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForOperand2: nodes [
	| result |
	result := MetavSymbolNode new.
	result symbolName: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForOperand3: nodes [
	| result |
	result := MetavEmbeddedNode new.
	result metavariableName: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForOperand4: nodes [
	| result |
	result := MetavTokenNode new.
	result tokenName: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForOperand5: nodes [
	| result |
	result := MetavKeywordNode new.
	result keywordName: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionForOperand6: nodes [
	| result |
	result := MetavGroupNode new.
	result leftParenToken: (nodes at: 1).
	result expression: (nodes at: 2).
	result rightParenToken: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionFor_____EnhancedOperandList__alternative__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionFor_____EnhancedOperandList__alternative___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCMetavariableParser >> reduceActionFor_____EnhancedOperandList__alternative___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]
