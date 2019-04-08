Class {
	#name : #SmaCCDefinitionParser,
	#superclass : #SmaCCGLRParser,
	#instVars : [
		'acceptSyntaxErrors'
	],
	#category : #'SmaCC_Grammar_Parser'
}

{ #category : #'generated-accessing' }
SmaCCDefinitionParser class >> cacheId [
	^'2019-04-08T17:26:10.063789+02:00'
]

{ #category : #generated }
SmaCCDefinitionParser class >> definitionComment [
"%scopes default scanner directives parser;

directives <scopes>
	: scopes
	| states 
	;
directives <excludes> 
	: excludes 
	;
directives <root> 
	: root 
	;
directives <hierarchy> 
	: hierarchy 
	;
directives <attributes>
	: attributes
	;
directives <prefix> 
	: prefix 
	;
directives <suffix> 
	: suffix 
	;
directives <left> 
	: left 
	;
directives <right> 
	: right 
	;
directives <nonassoc> 
	: nonassoc 
	;
directives <id> 
	: id 
	;
directives <start> 
	: start 
	;
directives <glr>
	: glr
	;
directives <parserType>
	: parserType
	;
directives <ignorecase>
	: ignorecase
	;
directives <ignorevariables>
	: ignore_variables
	;
directives <annotate_tokens>
	: annotate_tokens
	;
directives <lr1>
	: lr1
	;
<name> 
	: (<isLetter> | _) (<isLetter> | _ | <isDigit>)*
	;
<directive> 
	: \%
	;
<whitespace>
	: \s+ 
	;
<tokenname>
	: \< <name> \>
	;
default directives parser <symbolname>
	: <name>
	;
directives parser <keyword>
	: (\"" [^\""]* \"") + 
	;
<comment>
	: (\# [^\r\n]*) 
	| (\/\* [^\*]* \*+ ([^\/\*] [^\*]* \*+)* \/)
	;
parser <code>
	: \{ 
	;
parser <variablename>
	: \' <name> \' 
	;
<production>
	: \: (\: \=)? 
	;
<directive>
	: % 
	;
<semicolon>
	: \; 
	;
scanner <backslashcharacter>
	: \\ [^cx] 
	| \\ c [A-Z] 
	| \\ x [0-9A-Fa-f]{1,4}
	;
scanner <characterblock>
	: \[ ([^\]\\] | <backslashcharacter> )+ \] 
	;
scanner <repeat>
	: \{ [0-9]* \, [0-9]* \}
	;
scanner <character>
	: [^\ \t\v\\\r\n\{\(\[\.]
	; 
scanner <anycharacter>
	: \.
	;
parser <error>
	: error
	;
parser <classLeft> 
	: \{\{ 
	;
parser <classRight> 
	: \}\} 
	;
default parser <patternToken>
	: ` [^`]* `
	;

%glr;
%id <code> <keyword> <symbolname> <tokenname> <variablename> <semicolon>
	<directive> <production> <classLeft> <classRight>;
%left	""|"";
%left ""("" <character> <backslashcharacter> <characterblock> <anycharacter> <tokenname> <symbolname> <directive>;
%left ""*"" ""+"" ""?"" <repeat> ;

%start ProductionRule RegexRule DirectiveLine File;

%hierarchy Directive (
		ScopeDirective
		NodeNameDirective 
		SuperclassDirective
		AttributeDirective
		AssociativeDirective
		IdDirective
		StartDirective
		FlagDirective
		IgnoreVariableDirective
		ParserTypeDirective
	);
%hierarchy Symbol (
		KeywordSymbol
		TokenSymbol
		ProductionSymbol
		ErrorSymbol
	);
%hierarchy ProductionExpression (
		CodeProductionExpression
		ClassProductionExpression
	);
%hierarchy Regex (
		CharacterRegex
		CharacterBlockRegex
		AlternationRegex
		ConcatenationRegex
		TokenRegex
		RepeatRegex
	);
%prefix SmaCC;
%suffix Node;
%root Definition;

File
	: Rules {{GrammarDefinition}}
	;
Rules
	: Rule 'rule'
	| Rules Rule 'rule'
	;
Rule 
	: ProductionRule 
	| DirectiveLine
	| RegexRule 
	| Error
	;
Error
	: error 'smaccError' <semicolon> 'semicolon' {{DefinitionError}}
	| error 'smaccError' {{DefinitionError}}
	;
# Directives
DirectiveLine 
	: StartDirective <directive> 'directiveStartToken' Directive EndDirective <semicolon> 'semicolon' {{Directive}}
	;
Directive 
	: ExcludeScopesLine 
	| ScopesLine
	| RootClassLine
	| SuperclassLine
	| AttributesLine
	| PrefixLine
	| SuffixLine
	| LeftLine 
	| RightLine 
	| NonAssociativeLine
	| IdMethodLine
	| StartLine 
	| GLR
	| ParserTypeLine
	| IgnoreCase
	| IgnoredVariables
	| AnnotateTokens
	| LR1
	;
StartDirective 
	: {self scope: #directives. nil}
	;
EndDirective 
	: {self scope: #default. nil}
	;
ScopesLine 
	: <scopes> 'typeToken' Scopes {{ScopeDirective}}
	;
Scopes 
	: 
	| Scopes Symbol 'name'
	;
ExcludeScopesLine 
	: <excludes> 'typeToken' Scopes {{ScopeDirective}}
	;
RootClassLine 
	: <root> 'typeToken' <symbolname> 'name' {{NodeNameDirective}}
	;
SuperclassLine
	: <hierarchy> 'hierarchyToken' <symbolname> 'superclass' ""("" 'leftParen' ClassList "")"" 'rightParen' {{SuperclassDirective}}
	;
AttributesLine
	: <attributes> 'attributesToken' <symbolname> 'classname' ""("" 'leftParen' IvarList "")"" 'rightParen' {{AttributeDirective}}
	;
IvarList	
	:
	| IvarList <symbolname> 'name'
	;
ClassList 
	:
	| ClassList <symbolname> 'name'
	;
PrefixLine
	: <prefix> 'typeToken' <symbolname> 'name' {{NodeNameDirective}}
	;
SuffixLine
	: <suffix> 'typeToken' <symbolname> 'name' {{NodeNameDirective}}
	;
LeftLine
	: <left> 'typeToken' TokenList {{AssociativeDirective}}
	;
RightLine
	: <right> 'typeToken' TokenList {{AssociativeDirective}}
	;
NonAssociativeLine
	: <nonassoc> 'typeToken' TokenList {{AssociativeDirective}}
	;
TokenList
	: Term 'symbol'
	| TokenList Term 'symbol'
	;
IdMethodLine
	: <id> 'idToken' IdTokens {{IdDirective}}
	;
IdTokens
	: <tokenname> 'name'
	| IdTokens <tokenname> 'name'
	;
StartLine
	: <start> 'startToken' StartingTokens {{StartDirective}}
	;
StartingTokens
	: <symbolname> 'symbol'
	| StartingTokens <symbolname> 'symbol' 
	;
GLR
	: <glr> 'typeToken' {{FlagDirective}}
	;
ParserTypeLine 
	: <parserType> 'typeToken' <symbolname> 'name' {{ParserTypeDirective}}
	;
IgnoredVariables
	: EndDirective <ignorevariables> 'ignoreVariablesToken' IgnoredVariableList {{IgnoreVariableDirective}}
	;
IgnoredVariableList
	: <symbolname> 'name'
	| IgnoredVariableList <symbolname> 'name'
	;
IgnoreCase
	: <ignorecase> 'typeToken' {{FlagDirective}}
	;
AnnotateTokens
	: <annotate_tokens> 'typeToken' {{FlagDirective}}
	;
LR1
	: <lr1> 'typeToken' {{FlagDirective}}
	;
# Scanner
RegexRule 
	: StartRegex <tokenname> 'name' <production> 'colon' Regex 'regex' EndRegex <semicolon> 'semicolon' {{TokenRule}}
	| Symbol 'state' RegexRule {{TokenRule}}
	;
StartRegex
	: {self scope: #scanner. nil}
	;
EndRegex
	: {self scope: #default. nil}
	;
Symbol 
	: <symbolname> 
	;
Regex
	: ConcatenationRegex
	| ConcatenationRegex 'item'  (""|"" 'barToken' ConcatenationRegex 'item')+ {{AlternationRegex}}
	;
ConcatenationRegex
	: RegexTerm
	| RegexTerm 'item' RegexTerm 'item' + {{ConcatenationRegex}}
	;
RegexTerm
	: <character> 'char' {{CharacterRegex}}
	| <directive> 'char' {{CharacterRegex}}
	| <anycharacter> 'char' {{CharacterRegex}}
	| <backslashcharacter> 'char' {{CharacterRegex}}
	| ""("" 'leftParen' Regex "")"" 'rightParen' {{Regex}}
	| <characterblock> 'block' {{CharacterBlockRegex}}
	| <tokenname> 'name' {{TokenRegex}}
	| RegexTerm 'regex' ""*"" 'count' {{RepeatRegex}}	
	| RegexTerm 'regex' ""+"" 'count' {{RepeatRegex}}
	| RegexTerm 'regex' ""?"" 'count' {{RepeatRegex}}
	| RegexTerm 'regex' <repeat> 'count' {{RepeatRegex}}
	;
# Parser 
ProductionRule
	: <symbolname> 'name' StartProduction <production> 'colon' ParserRules EndProduction <semicolon> 'semicolon' {{ProductionRule}}
	;
StartProduction
	: {self scope: #parser. nil}
	;
EndProduction
	: {self scope: #default. nil}
	;
ParserRules
	: ParserRules ""|"" 'barToken' ParserRule 'expression'
	| ParserRule 'expression'
	;
ParserRule 
	: Terms {{ProductionExpression}}
	| Terms <code> 'code' {{CodeProductionExpression}}
	| Terms <classLeft> 'left' <symbolname> 'classname' <classRight> 'right' {{ClassProductionExpression}}
	| Terms <classLeft> 'left' <classRight> 'right' {{ClassProductionExpression}}
	;
Terms 
	:
	| Terms SpecialTerm 'term'
	;
SpecialTerm
	: NamedTerm
	| SpecialTerm 'term' ""?"" 'operator' {{PostfixTerm}}
	| SpecialTerm 'term' ""+"" 'operator' {{PostfixTerm}}
	| SpecialTerm 'term' ""*"" 'operator' {{PostfixTerm}}
	| ""("" 'leftParen' ParserRules "")"" 'rightParen' {{GroupTerm}}
	;
NamedTerm
	: Term
	| Term <variablename> 'variableNameToken' {{Symbol}}
	;
Term
	: <keyword> 'name' {{KeywordSymbol}}
	| <tokenname> 'name' {{TokenSymbol}}
	| <symbolname> 'name' {{ProductionSymbol}}
	| <error> 'name' {{ErrorSymbol}}
	;"
]

{ #category : #generated }
SmaCCDefinitionParser class >> reduceTable [
^#(
	#(79 0 #reduceActionForStartRegex1:) 
	#(51 0 #reduceActionForStartDirective1:) 
	#(81 1 #liftFirstValue:) 
	#(89 0 #reduceActionForStartProduction1:) 
	#(45 1 #reduceActionForFile1:) 
	#(46 1 #reduceActionForRules1:) 
	#(47 1 #liftFirstValue:) 
	#(48 1 #reduceActionForError2:) 
	#(46 2 #reduceActionForRules2:) 
	#(52 0 #reduceActionForEndDirective1:) 
	#(78 2 #reduceActionForRegexRule2:) 
	#(48 2 #reduceActionForError1:) 
	#(93 0 #reduceActionForTerms1:) 
	#(54 0 #reduceActionForTerms1:) 
	#(71 1 #reduceActionForGLR1:) 
	#(75 1 #reduceActionForGLR1:) 
	#(76 1 #reduceActionForGLR1:) 
	#(77 1 #reduceActionForGLR1:) 
	#(50 1 #liftFirstValue:) 
	#(90 0 #reduceActionForEndDirective1:) 
	#(91 1 #reduceActionForParserRules2:) 
	#(92 1 #reduceActionForParserRule1:) 
	#(53 2 #reduceActionForScopesLine1:) 
	#(55 2 #reduceActionForScopesLine1:) 
	#(56 2 #reduceActionForRootClassLine1:) 
	#(61 2 #reduceActionForRootClassLine1:) 
	#(62 2 #reduceActionForRootClassLine1:) 
	#(96 1 #reduceActionForTerm2:) 
	#(96 1 #reduceActionForTerm3:) 
	#(96 1 #reduceActionForTerm1:) 
	#(96 1 #reduceActionForTerm4:) 
	#(63 2 #reduceActionForLeftLine1:) 
	#(66 1 #reduceActionForRules1:) 
	#(64 2 #reduceActionForLeftLine1:) 
	#(65 2 #reduceActionForLeftLine1:) 
	#(68 1 #reduceActionForRules1:) 
	#(67 2 #reduceActionForIdMethodLine1:) 
	#(70 1 #reduceActionForRules1:) 
	#(69 2 #reduceActionForStartLine1:) 
	#(72 2 #reduceActionForParserTypeLine1:) 
	#(87 1 #reduceActionForRegexTerm7:) 
	#(87 1 #reduceActionForRegexTerm2:) 
	#(87 1 #reduceActionForRegexTerm6:) 
	#(80 0 #reduceActionForEndDirective1:) 
	#(82 1 #liftFirstValue:) 
	#(85 1 #liftFirstValue:) 
	#(92 2 #reduceActionForParserRule2:) 
	#(93 2 #reduceActionForRules2:) 
	#(94 1 #liftFirstValue:) 
	#(95 1 #liftFirstValue:) 
	#(54 2 #reduceActionForRules2:) 
	#(60 0 #reduceActionForTerms1:) 
	#(59 0 #reduceActionForTerms1:) 
	#(66 2 #reduceActionForRules2:) 
	#(68 2 #reduceActionForRules2:) 
	#(70 2 #reduceActionForRules2:) 
	#(49 5 #reduceActionForDirectiveLine1:) 
	#(74 1 #reduceActionForRules1:) 
	#(73 3 #reduceActionForIgnoredVariables1:) 
	#(84 1 #reduceActionFor______barToken__ConcatenationRegex__item___1:) 
	#(82 2 #reduceActionForRegex2:) 
	#(87 2 #reduceActionForRegexTerm8:) 
	#(85 2 #reduceActionForConcatenationRegex2:) 
	#(86 1 #reduceActionForRules1:) 
	#(91 3 #reduceActionForParserRules1:) 
	#(88 6 #reduceActionForProductionRule1:) 
	#(92 3 #reduceActionForParserRule4:) 
	#(94 2 #reduceActionForSpecialTerm4:) 
	#(95 2 #reduceActionForNamedTerm2:) 
	#(74 2 #reduceActionForRules2:) 
	#(87 3 #reduceActionForRegexTerm5:) 
	#(78 6 #reduceActionForRegexRule1:) 
	#(83 2 #reduceActionFor______barToken__ConcatenationRegex__item__1:) 
	#(84 2 #reduceActionFor______barToken__ConcatenationRegex__item___2:) 
	#(86 2 #reduceActionForRules2:) 
	#(94 3 #reduceActionForSpecialTerm5:) 
	#(92 4 #reduceActionForParserRule3:) 
	#(57 5 #reduceActionForSuperclassLine1:) 
	#(60 2 #reduceActionForRules2:) 
	#(58 5 #reduceActionForAttributesLine1:) 
	#(59 2 #reduceActionForRules2:)
	).
]

{ #category : #'generated-accessing' }
SmaCCDefinitionParser class >> scannerClass [
	^SmaCCDefinitionScanner
]

{ #category : #generated }
SmaCCDefinitionParser class >> startingStateForDirectiveLine [
	^ 4
]

{ #category : #generated }
SmaCCDefinitionParser class >> startingStateForFile [
	^ 1
]

{ #category : #generated }
SmaCCDefinitionParser class >> startingStateForProductionRule [
	^ 2
]

{ #category : #generated }
SmaCCDefinitionParser class >> startingStateForRegexRule [
	^ 3
]

{ #category : #generated }
SmaCCDefinitionParser class >> symbolNames [
	^ #('"("' '")"' '"*"' '"+"' '"?"' '"|"' '<scopes>' '<excludes>' '<root>' '<hierarchy>' '<attributes>' '<prefix>' '<suffix>' '<left>' '<right>' '<nonassoc>' '<id>' '<start>' '<glr>' '<parserType>' '<ignorecase>' '<ignorevariables>' '<annotate_tokens>' '<lr1>' '<whitespace>' '<tokenname>' '<symbolname>' '<keyword>' '<comment>' '<code>' '<variablename>' '<production>' '<directive>' '<semicolon>' '<backslashcharacter>' '<characterblock>' '<repeat>' '<character>' '<anycharacter>' '<error>' '<classLeft>' '<classRight>' '<patternToken>' 'B e g i n' 'File' 'Rules' 'Rule' 'Error' 'DirectiveLine' 'Directive' 'StartDirective' 'EndDirective' 'ScopesLine' 'Scopes' 'ExcludeScopesLine' 'RootClassLine' 'SuperclassLine' 'AttributesLine' 'IvarList' 'ClassList' 'PrefixLine' 'SuffixLine' 'LeftLine' 'RightLine' 'NonAssociativeLine' 'TokenList' 'IdMethodLine' 'IdTokens' 'StartLine' 'StartingTokens' 'GLR' 'ParserTypeLine' 'IgnoredVariables' 'IgnoredVariableList' 'IgnoreCase' 'AnnotateTokens' 'LR1' 'RegexRule' 'StartRegex' 'EndRegex' 'Symbol' 'Regex' '("|" ''barToken'' ConcatenationRegex ''item'')' '("|" ''barToken'' ConcatenationRegex ''item'')+' 'ConcatenationRegex' 'RegexTerm ''item'' +' 'RegexTerm' 'ProductionRule' 'StartProduction' 'EndProduction' 'ParserRules' 'ParserRule' 'Terms' 'SpecialTerm' 'NamedTerm' 'Term' 'E O F' 'error')
]

{ #category : #generated }
SmaCCDefinitionParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCGrammarDefinitionNode #SmaCCGrammarDefinitionNode #OrderedCollection #SmaCCDefinitionNode #SmaCCDefinitionErrorNode #SmaCCDirectiveNode #SmaCCDirectiveNode nil nil #SmaCCScopeDirectiveNode #OrderedCollection #SmaCCScopeDirectiveNode #SmaCCNodeNameDirectiveNode #SmaCCSuperclassDirectiveNode #SmaCCAttributeDirectiveNode #OrderedCollection #OrderedCollection #SmaCCNodeNameDirectiveNode #SmaCCNodeNameDirectiveNode #SmaCCAssociativeDirectiveNode #SmaCCAssociativeDirectiveNode #SmaCCAssociativeDirectiveNode #OrderedCollection #SmaCCIdDirectiveNode #OrderedCollection #SmaCCStartDirectiveNode #OrderedCollection #SmaCCFlagDirectiveNode #SmaCCParserTypeDirectiveNode #SmaCCIgnoreVariableDirectiveNode #OrderedCollection #SmaCCFlagDirectiveNode #SmaCCFlagDirectiveNode #SmaCCFlagDirectiveNode #SmaCCTokenRuleNode nil nil #SmaCCToken #SmaCCRegexNode #OrderedCollection #OrderedCollection #SmaCCRegexNode #OrderedCollection #SmaCCRegexNode #SmaCCProductionRuleNode nil nil #OrderedCollection #SmaCCProductionExpressionNode #OrderedCollection #SmaCCDefinitionNode #SmaCCSymbolNode #SmaCCSymbolNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
SmaCCDefinitionParser class >> transitionTable [
^#(
#[1 0 6 0 26 0 21 0 27 0 10 0 33 0 25 0 45 0 29 0 46 0 33 0 47 0 33 0 48 0 33 0 49 0 45 0 51 0 33 0 78 0 53 0 79 0 57 0 81 0 33 0 88 0 65 0 98] 
#[1 0 69 0 27 0 73 0 88] 
#[1 0 6 0 26 0 57 0 27 0 81 0 78 0 53 0 79 0 57 0 81] 
#[1 0 10 0 33 0 85 0 49 0 45 0 51] 
#[1 0 14 0 26 0 14 0 27 0 18 0 32 0 89 0 89] 
#[0 0 0 0 97] 
#[1 0 6 0 26 0 21 0 27 0 10 0 33 0 93 0 47 0 93 0 48 0 93 0 49 0 45 0 51 0 93 0 78 0 53 0 79 0 57 0 81 0 93 0 88 0 22 0 97 0 65 0 98] 
#[0 0 26 0 26 0 27 0 33 0 97 0 98] 
#[0 0 30 0 26 0 27 0 33 0 97 0 98] 
#[0 0 30 0 26 0 27 0 33 0 97 0 98] 
#[0 0 97 0 33] 
#[0 0 30 0 26 0 27 0 33 0 97 0 98] 
#[0 0 101 0 26] 
#[1 0 6 0 26 0 57 0 27 0 105 0 78 0 53 0 79 0 57 0 81] 
#[0 0 30 0 26 0 27 0 33 0 97 0 98] 
#[1 0 34 0 26 0 34 0 27 0 34 0 33 0 109 0 34 0 34 0 97 0 34 0 98] 
#[1 0 18 0 32 0 89 0 89] 
#[0 0 0 0 97] 
#[0 0 14 0 26 0 27 0 34] 
#[0 0 0 0 97] 
#[0 0 0 0 97] 
#[0 0 113 0 32] 
#[0 0 38 0 26 0 27 0 33 0 97 0 98] 
#[1 0 117 0 7 0 121 0 8 0 125 0 9 0 129 0 10 0 133 0 11 0 137 0 12 0 141 0 13 0 145 0 14 0 149 0 15 0 153 0 16 0 157 0 17 0 161 0 18 0 165 0 19 0 169 0 20 0 173 0 21 0 42 0 22 0 177 0 23 0 181 0 24 0 185 0 50 0 189 0 52 0 185 0 53 0 185 0 55 0 185 0 56 0 185 0 57 0 185 0 58 0 185 0 61 0 185 0 62 0 185 0 63 0 185 0 64 0 185 0 65 0 185 0 67 0 185 0 69 0 185 0 71 0 185 0 72 0 185 0 73 0 185 0 75 0 185 0 76 0 185 0 77] 
#[0 1 9 0 32] 
#[0 0 46 0 26 0 27 0 33 0 97 0 98] 
#[0 0 50 0 26 0 27 0 33 0 97 0 98] 
#[1 0 54 0 1 0 54 0 6 0 54 0 26 0 54 0 27 0 54 0 28 0 54 0 30 0 54 0 34 0 54 0 40 0 54 0 41 1 13 0 91 1 17 0 92 1 21 0 93] 
#[1 0 58 0 27 0 58 0 34 1 25 0 54] 
#[1 0 58 0 27 0 58 0 34 1 29 0 54] 
#[0 1 33 0 27] 
#[0 1 37 0 27] 
#[0 1 41 0 27] 
#[0 1 45 0 27] 
#[0 1 49 0 27] 
#[1 1 53 0 26 1 57 0 27 1 61 0 28 1 65 0 40 1 69 0 66 1 73 0 96] 
#[1 1 53 0 26 1 57 0 27 1 61 0 28 1 65 0 40 1 77 0 66 1 73 0 96] 
#[1 1 53 0 26 1 57 0 27 1 61 0 28 1 65 0 40 1 81 0 66 1 73 0 96] 
#[1 1 85 0 26 1 89 0 68] 
#[1 1 93 0 27 1 97 0 70] 
#[0 0 62 0 34] 
#[0 1 101 0 27] 
#[0 0 66 0 34] 
#[0 0 70 0 34] 
#[0 0 74 0 34] 
#[1 0 42 0 34 1 105 0 52] 
#[0 1 109 0 22] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[0 0 78 0 34] 
#[1 1 113 0 1 1 117 0 26 1 121 0 33 1 125 0 35 1 129 0 36 1 133 0 38 1 137 0 39 1 141 0 82 1 145 0 85 1 149 0 87] 
#[1 1 153 0 6 0 82 0 34 1 157 0 90] 
#[0 0 86 0 2 0 6 0 34] 
#[1 1 161 0 1 0 90 0 2 0 90 0 6 1 53 0 26 1 57 0 27 1 61 0 28 1 165 0 30 0 90 0 34 1 65 0 40 1 169 0 41 1 173 0 94 1 173 0 95 1 181 0 96] 
#[1 1 185 0 27 0 94 0 34 1 185 0 81] 
#[1 1 185 0 27 0 98 0 34 1 185 0 81] 
#[0 0 102 0 34] 
#[0 1 189 0 1] 
#[0 1 193 0 1] 
#[0 0 106 0 34] 
#[0 0 110 0 34] 
#[0 0 114 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 27 0 28 0 30 0 31 0 34 0 40 0 41] 
#[0 0 118 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 27 0 28 0 30 0 31 0 34 0 40 0 41] 
#[0 0 122 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 27 0 28 0 30 0 31 0 34 0 40 0 41] 
#[0 0 126 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 27 0 28 0 30 0 31 0 34 0 40 0 41] 
#[1 1 53 0 26 1 57 0 27 1 61 0 28 0 130 0 34 1 65 0 40 1 197 0 96] 
#[0 0 134 0 26 0 27 0 28 0 34 0 40] 
#[1 1 53 0 26 1 57 0 27 1 61 0 28 0 138 0 34 1 65 0 40 1 197 0 96] 
#[1 1 53 0 26 1 57 0 27 1 61 0 28 0 142 0 34 1 65 0 40 1 197 0 96] 
#[0 0 146 0 26 0 34] 
#[1 1 201 0 26 0 150 0 34] 
#[0 0 154 0 27 0 34] 
#[1 1 205 0 27 0 158 0 34] 
#[0 0 162 0 34] 
#[0 1 209 0 34] 
#[1 1 213 0 27 1 217 0 74] 
#[1 1 113 0 1 1 117 0 26 1 121 0 33 1 125 0 35 1 129 0 36 1 133 0 38 1 137 0 39 1 221 0 82 1 145 0 85 1 149 0 87] 
#[0 0 166 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 33 0 34 0 35 0 36 0 37 0 38 0 39] 
#[0 0 170 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 33 0 34 0 35 0 36 0 37 0 38 0 39] 
#[0 0 170 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 33 0 34 0 35 0 36 0 37 0 38 0 39] 
#[0 0 174 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 33 0 34 0 35 0 36 0 37 0 38 0 39] 
#[0 0 170 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 33 0 34 0 35 0 36 0 37 0 38 0 39] 
#[0 0 170 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 33 0 34 0 35 0 36 0 37 0 38 0 39] 
#[1 0 178 0 34 1 225 0 80] 
#[1 0 182 0 2 1 229 0 6 0 182 0 34 1 233 0 83 1 237 0 84] 
#[1 1 113 0 1 0 186 0 2 1 241 0 3 1 245 0 4 1 249 0 5 0 186 0 6 1 117 0 26 1 121 0 33 0 186 0 34 1 125 0 35 1 129 0 36 1 253 0 37 1 133 0 38 1 137 0 39 2 1 0 86 2 5 0 87] 
#[1 0 54 0 1 0 54 0 2 0 54 0 6 0 54 0 26 0 54 0 27 0 54 0 28 0 54 0 30 0 54 0 34 0 54 0 40 0 54 0 41 2 9 0 92 1 21 0 93] 
#[0 2 13 0 34] 
#[1 0 54 0 1 0 54 0 2 0 54 0 6 0 54 0 26 0 54 0 27 0 54 0 28 0 54 0 30 0 54 0 40 0 54 0 41 2 17 0 91 1 17 0 92 1 21 0 93] 
#[0 0 190 0 2 0 6 0 34] 
#[1 2 21 0 27 2 25 0 42] 
#[1 0 194 0 1 0 194 0 2 2 29 0 3 2 33 0 4 2 37 0 5 0 194 0 6 0 194 0 26 0 194 0 27 0 194 0 28 0 194 0 30 0 194 0 34 0 194 0 40 0 194 0 41] 
#[0 0 198 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 27 0 28 0 30 0 34 0 40 0 41] 
#[1 0 202 0 1 0 202 0 2 0 202 0 3 0 202 0 4 0 202 0 5 0 202 0 6 0 202 0 26 0 202 0 27 0 202 0 28 0 202 0 30 2 41 0 31 0 202 0 34 0 202 0 40 0 202 0 41] 
#[0 0 206 0 27 0 34] 
#[1 0 210 0 2 0 210 0 27 2 45 0 60] 
#[1 0 214 0 2 0 214 0 27 2 49 0 59] 
#[0 0 218 0 26 0 27 0 28 0 34 0 40] 
#[0 0 222 0 26 0 34] 
#[0 0 226 0 27 0 34] 
#[0 0 230 0 26 0 27 0 33 0 97 0 98] 
#[0 0 234 0 27 0 34] 
#[1 2 53 0 27 0 238 0 34] 
#[0 2 57 0 2] 
#[0 2 61 0 34] 
#[1 1 113 0 1 1 117 0 26 1 121 0 33 1 125 0 35 1 129 0 36 1 133 0 38 1 137 0 39 2 65 0 85 1 149 0 87] 
#[0 0 242 0 2 0 6 0 34] 
#[1 0 246 0 2 1 229 0 6 0 246 0 34 2 69 0 83] 
#[0 0 250 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 33 0 34 0 35 0 36 0 37 0 38 0 39] 
#[0 0 250 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 33 0 34 0 35 0 36 0 37 0 38 0 39] 
#[0 0 250 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 33 0 34 0 35 0 36 0 37 0 38 0 39] 
#[0 0 250 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 33 0 34 0 35 0 36 0 37 0 38 0 39] 
#[1 1 113 0 1 0 254 0 2 0 254 0 6 1 117 0 26 1 121 0 33 0 254 0 34 1 125 0 35 1 129 0 36 1 133 0 38 1 137 0 39 2 73 0 87] 
#[1 1 2 0 1 1 2 0 2 1 241 0 3 1 245 0 4 1 249 0 5 1 2 0 6 1 2 0 26 1 2 0 33 1 2 0 34 1 2 0 35 1 2 0 36 1 253 0 37 1 2 0 38 1 2 0 39] 
#[0 1 6 0 2 0 6 0 34] 
#[0 1 10 0 26 0 27 0 33 0 97 0 98] 
#[1 2 77 0 2 1 153 0 6] 
#[0 2 81 0 42] 
#[0 1 14 0 2 0 6 0 34] 
#[0 1 18 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 27 0 28 0 30 0 34 0 40 0 41] 
#[0 1 18 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 27 0 28 0 30 0 34 0 40 0 41] 
#[0 1 18 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 27 0 28 0 30 0 34 0 40 0 41] 
#[0 1 22 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 27 0 28 0 30 0 34 0 40 0 41] 
#[1 2 85 0 2 2 89 0 27] 
#[1 2 93 0 2 2 97 0 27] 
#[0 1 26 0 27 0 34] 
#[0 1 30 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 33 0 34 0 35 0 36 0 37 0 38 0 39] 
#[0 1 34 0 26 0 27 0 33 0 97 0 98] 
#[0 1 38 0 2 0 6 0 34] 
#[0 1 42 0 2 0 6 0 34] 
#[1 1 46 0 1 1 46 0 2 1 241 0 3 1 245 0 4 1 249 0 5 1 46 0 6 1 46 0 26 1 46 0 33 1 46 0 34 1 46 0 35 1 46 0 36 1 253 0 37 1 46 0 38 1 46 0 39] 
#[0 1 50 0 1 0 2 0 3 0 4 0 5 0 6 0 26 0 27 0 28 0 30 0 34 0 40 0 41] 
#[0 1 54 0 2 0 6 0 34] 
#[0 1 58 0 34] 
#[0 1 62 0 2 0 27] 
#[0 1 66 0 34] 
#[0 1 70 0 2 0 27]
	).
]

{ #category : #private }
SmaCCDefinitionParser >> dismissErrorToken [
	self scope: #default.
	^ super dismissErrorToken
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForAttributesLine1: nodes [
	| result |
	result := SmaCCAttributeDirectiveNode new.
	result attributesToken: (nodes at: 1).
	result classname: (nodes at: 2).
	result leftParen: (nodes at: 3).
	result addTokens: (nodes at: 4) to: result names.
	result rightParen: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForConcatenationRegex2: nodes [
	| result |
	result := SmaCCConcatenationRegexNode new.
	result addNode: (nodes at: 1) to: result items.
	result addNodes: (nodes at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForDirectiveLine1: nodes [
	| result |
	result := nodes at: 3.
	result directiveStartToken: (nodes at: 2).
	result semicolon: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForEndDirective1: nodes [
	self scope: #default.
	^ nil
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForError1: nodes [
	| result |
	result := SmaCCDefinitionErrorNode new.
	result smaccError: (nodes at: 1).
	result semicolon: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForError2: nodes [
	| result |
	result := SmaCCDefinitionErrorNode new.
	result smaccError: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForFile1: nodes [
	| result |
	result := SmaCCGrammarDefinitionNode new.
	result addNodes: (nodes at: 1) to: result rules.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForGLR1: nodes [
	| result |
	result := SmaCCFlagDirectiveNode new.
	result typeToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForIdMethodLine1: nodes [
	| result |
	result := SmaCCIdDirectiveNode new.
	result idToken: (nodes at: 1).
	result addTokens: (nodes at: 2) to: result names.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForIgnoredVariables1: nodes [
	| result |
	result := SmaCCIgnoreVariableDirectiveNode new.
	result ignoreVariablesToken: (nodes at: 2).
	result addTokens: (nodes at: 3) to: result names.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForLeftLine1: nodes [
	| result |
	result := SmaCCAssociativeDirectiveNode new.
	result typeToken: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result symbols.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForNamedTerm2: nodes [
	| result |
	result := nodes at: 1.
	result variableNameToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForParserRule1: nodes [
	| result |
	result := SmaCCProductionExpressionNode new.
	result addNodes: (nodes at: 1) to: result terms.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForParserRule2: nodes [
	| result |
	result := SmaCCCodeProductionExpressionNode new.
	result addNodes: (nodes at: 1) to: result terms.
	result code: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForParserRule3: nodes [
	| result |
	result := SmaCCClassProductionExpressionNode new.
	result addNodes: (nodes at: 1) to: result terms.
	result left: (nodes at: 2).
	result classname: (nodes at: 3).
	result right: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForParserRule4: nodes [
	| result |
	result := SmaCCClassProductionExpressionNode new.
	result addNodes: (nodes at: 1) to: result terms.
	result left: (nodes at: 2).
	result right: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForParserRules1: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: (result at: 1).
	self add: (nodes at: 3) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForParserRules2: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForParserTypeLine1: nodes [
	| result |
	result := SmaCCParserTypeDirectiveNode new.
	result typeToken: (nodes at: 1).
	result name: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForProductionRule1: nodes [
	| result |
	result := SmaCCProductionRuleNode new.
	result name: (nodes at: 1).
	result colon: (nodes at: 3).
	result addTokens: ((nodes at: 4) at: 1) to: result barTokens.
	result addNodes: ((nodes at: 4) at: 2) to: result expressions.
	result semicolon: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForRegex2: nodes [
	| result |
	result := SmaCCAlternationRegexNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result barTokens.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForRegexRule1: nodes [
	| result |
	result := SmaCCTokenRuleNode new.
	result name: (nodes at: 2).
	result colon: (nodes at: 3).
	result regex: (nodes at: 4).
	result semicolon: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForRegexRule2: nodes [
	| result |
	result := nodes at: 2.
	result addFirstToken: (nodes at: 1) to: result states.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForRegexTerm2: nodes [
	| result |
	result := SmaCCCharacterRegexNode new.
	result char: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForRegexTerm5: nodes [
	| result |
	result := nodes at: 2.
	result addFirstToken: (nodes at: 1) to: result leftParens.
	result addToken: (nodes at: 3) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForRegexTerm6: nodes [
	| result |
	result := SmaCCCharacterBlockRegexNode new.
	result block: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForRegexTerm7: nodes [
	| result |
	result := SmaCCTokenRegexNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForRegexTerm8: nodes [
	| result |
	result := SmaCCRepeatRegexNode new.
	result regex: (nodes at: 1).
	result count: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForRootClassLine1: nodes [
	| result |
	result := SmaCCNodeNameDirectiveNode new.
	result typeToken: (nodes at: 1).
	result name: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForRules1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForRules2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForScopesLine1: nodes [
	| result |
	result := SmaCCScopeDirectiveNode new.
	result typeToken: (nodes at: 1).
	result addTokens: (nodes at: 2) to: result names.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForSpecialTerm4: nodes [
	| result |
	result := SmaCCPostfixTermNode new.
	result term: (nodes at: 1).
	result operator: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForSpecialTerm5: nodes [
	| result |
	result := SmaCCGroupTermNode new.
	result leftParen: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result barTokens.
	result addNodes: ((nodes at: 2) at: 2) to: result expressions.
	result rightParen: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForStartDirective1: nodes [
	self scope: #directives.
	^ nil
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForStartLine1: nodes [
	| result |
	result := SmaCCStartDirectiveNode new.
	result startToken: (nodes at: 1).
	result addTokens: (nodes at: 2) to: result symbols.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForStartProduction1: nodes [
	self scope: #parser.
	^ nil
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForStartRegex1: nodes [
	self scope: #scanner.
	^ nil
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForSuperclassLine1: nodes [
	| result |
	result := SmaCCSuperclassDirectiveNode new.
	result hierarchyToken: (nodes at: 1).
	result superclass: (nodes at: 2).
	result leftParen: (nodes at: 3).
	result addTokens: (nodes at: 4) to: result names.
	result rightParen: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForTerm1: nodes [
	| result |
	result := SmaCCKeywordSymbolNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForTerm2: nodes [
	| result |
	result := SmaCCTokenSymbolNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForTerm3: nodes [
	| result |
	result := SmaCCProductionSymbolNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForTerm4: nodes [
	| result |
	result := SmaCCErrorSymbolNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForTerms1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionFor______barToken__ConcatenationRegex__item__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionFor______barToken__ConcatenationRegex__item___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionFor______barToken__ConcatenationRegex__item___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #testing }
SmaCCDefinitionParser >> tryAllTokens [
	^ true
]

{ #category : #testing }
SmaCCDefinitionParser >> useAllTokenIds [
	^ false
]
