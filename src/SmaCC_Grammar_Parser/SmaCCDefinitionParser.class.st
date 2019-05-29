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
	^'2019-05-29T13:41:17.983535+02:00'
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
directives <unicode>
	: unicode
	;
directives <byte>
	: byte
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
parser <immediateCode>
	: \[
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
%id <code> <immediateCode> <keyword> <symbolname> <tokenname> <variablename> <semicolon>
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
	| Unicode
	| Byte
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
Unicode
	: <unicode> 'typeToken' {{FlagDirective}}
	;
Byte
	: <byte> 'typeToken' {{FlagDirective}}
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
	| Terms <immediateCode> 'code' {{CodeProductionExpression}}
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
	#(84 0 #reduceActionForStartRegex1:) 
	#(54 0 #reduceActionForStartDirective1:) 
	#(86 1 #liftFirstValue:) 
	#(94 0 #reduceActionForStartProduction1:) 
	#(48 1 #reduceActionForFile1:) 
	#(49 1 #reduceActionForRules1:) 
	#(50 1 #liftFirstValue:) 
	#(51 1 #reduceActionForError2:) 
	#(49 2 #reduceActionForRules2:) 
	#(55 0 #reduceActionForEndDirective1:) 
	#(83 2 #reduceActionForRegexRule2:) 
	#(51 2 #reduceActionForError1:) 
	#(98 0 #reduceActionForTerms1:) 
	#(57 0 #reduceActionForTerms1:) 
	#(74 1 #reduceActionForGLR1:) 
	#(78 1 #reduceActionForGLR1:) 
	#(79 1 #reduceActionForGLR1:) 
	#(80 1 #reduceActionForGLR1:) 
	#(81 1 #reduceActionForGLR1:) 
	#(82 1 #reduceActionForGLR1:) 
	#(53 1 #liftFirstValue:) 
	#(95 0 #reduceActionForEndDirective1:) 
	#(96 1 #reduceActionForParserRules2:) 
	#(97 1 #reduceActionForParserRule1:) 
	#(56 2 #reduceActionForScopesLine1:) 
	#(58 2 #reduceActionForScopesLine1:) 
	#(59 2 #reduceActionForRootClassLine1:) 
	#(64 2 #reduceActionForRootClassLine1:) 
	#(65 2 #reduceActionForRootClassLine1:) 
	#(101 1 #reduceActionForTerm2:) 
	#(101 1 #reduceActionForTerm3:) 
	#(101 1 #reduceActionForTerm1:) 
	#(101 1 #reduceActionForTerm4:) 
	#(66 2 #reduceActionForLeftLine1:) 
	#(69 1 #reduceActionForRules1:) 
	#(67 2 #reduceActionForLeftLine1:) 
	#(68 2 #reduceActionForLeftLine1:) 
	#(71 1 #reduceActionForRules1:) 
	#(70 2 #reduceActionForIdMethodLine1:) 
	#(73 1 #reduceActionForRules1:) 
	#(72 2 #reduceActionForStartLine1:) 
	#(75 2 #reduceActionForParserTypeLine1:) 
	#(92 1 #reduceActionForRegexTerm7:) 
	#(92 1 #reduceActionForRegexTerm2:) 
	#(92 1 #reduceActionForRegexTerm6:) 
	#(85 0 #reduceActionForEndDirective1:) 
	#(87 1 #liftFirstValue:) 
	#(90 1 #liftFirstValue:) 
	#(97 2 #reduceActionForParserRule2:) 
	#(98 2 #reduceActionForRules2:) 
	#(99 1 #liftFirstValue:) 
	#(100 1 #liftFirstValue:) 
	#(57 2 #reduceActionForRules2:) 
	#(63 0 #reduceActionForTerms1:) 
	#(62 0 #reduceActionForTerms1:) 
	#(69 2 #reduceActionForRules2:) 
	#(71 2 #reduceActionForRules2:) 
	#(73 2 #reduceActionForRules2:) 
	#(52 5 #reduceActionForDirectiveLine1:) 
	#(77 1 #reduceActionForRules1:) 
	#(76 3 #reduceActionForIgnoredVariables1:) 
	#(89 1 #reduceActionFor______barToken__ConcatenationRegex__item___1:) 
	#(87 2 #reduceActionForRegex2:) 
	#(92 2 #reduceActionForRegexTerm8:) 
	#(90 2 #reduceActionForConcatenationRegex2:) 
	#(91 1 #reduceActionForRules1:) 
	#(96 3 #reduceActionForParserRules1:) 
	#(93 6 #reduceActionForProductionRule1:) 
	#(97 3 #reduceActionForParserRule5:) 
	#(99 2 #reduceActionForSpecialTerm4:) 
	#(100 2 #reduceActionForNamedTerm2:) 
	#(77 2 #reduceActionForRules2:) 
	#(92 3 #reduceActionForRegexTerm5:) 
	#(83 6 #reduceActionForRegexRule1:) 
	#(88 2 #reduceActionFor______barToken__ConcatenationRegex__item__1:) 
	#(89 2 #reduceActionFor______barToken__ConcatenationRegex__item___2:) 
	#(91 2 #reduceActionForRules2:) 
	#(99 3 #reduceActionForSpecialTerm5:) 
	#(97 4 #reduceActionForParserRule4:) 
	#(60 5 #reduceActionForSuperclassLine1:) 
	#(63 2 #reduceActionForRules2:) 
	#(61 5 #reduceActionForAttributesLine1:) 
	#(62 2 #reduceActionForRules2:)
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
	^ #('"("' '")"' '"*"' '"+"' '"?"' '"|"' '<scopes>' '<excludes>' '<root>' '<hierarchy>' '<attributes>' '<prefix>' '<suffix>' '<left>' '<right>' '<nonassoc>' '<id>' '<start>' '<glr>' '<parserType>' '<ignorecase>' '<ignorevariables>' '<annotate_tokens>' '<lr1>' '<unicode>' '<byte>' '<whitespace>' '<tokenname>' '<symbolname>' '<keyword>' '<comment>' '<code>' '<immediateCode>' '<variablename>' '<production>' '<directive>' '<semicolon>' '<backslashcharacter>' '<characterblock>' '<repeat>' '<character>' '<anycharacter>' '<error>' '<classLeft>' '<classRight>' '<patternToken>' 'B e g i n' 'File' 'Rules' 'Rule' 'Error' 'DirectiveLine' 'Directive' 'StartDirective' 'EndDirective' 'ScopesLine' 'Scopes' 'ExcludeScopesLine' 'RootClassLine' 'SuperclassLine' 'AttributesLine' 'IvarList' 'ClassList' 'PrefixLine' 'SuffixLine' 'LeftLine' 'RightLine' 'NonAssociativeLine' 'TokenList' 'IdMethodLine' 'IdTokens' 'StartLine' 'StartingTokens' 'GLR' 'ParserTypeLine' 'IgnoredVariables' 'IgnoredVariableList' 'IgnoreCase' 'AnnotateTokens' 'LR1' 'Unicode' 'Byte' 'RegexRule' 'StartRegex' 'EndRegex' 'Symbol' 'Regex' '("|" ''barToken'' ConcatenationRegex ''item'')' '("|" ''barToken'' ConcatenationRegex ''item'')+' 'ConcatenationRegex' 'RegexTerm ''item'' +' 'RegexTerm' 'ProductionRule' 'StartProduction' 'EndProduction' 'ParserRules' 'ParserRule' 'Terms' 'SpecialTerm' 'NamedTerm' 'Term' 'E O F' 'error')
]

{ #category : #generated }
SmaCCDefinitionParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCGrammarDefinitionNode #SmaCCGrammarDefinitionNode #OrderedCollection #SmaCCDefinitionNode #SmaCCDefinitionErrorNode #SmaCCDirectiveNode #SmaCCDirectiveNode nil nil #SmaCCScopeDirectiveNode #OrderedCollection #SmaCCScopeDirectiveNode #SmaCCNodeNameDirectiveNode #SmaCCSuperclassDirectiveNode #SmaCCAttributeDirectiveNode #OrderedCollection #OrderedCollection #SmaCCNodeNameDirectiveNode #SmaCCNodeNameDirectiveNode #SmaCCAssociativeDirectiveNode #SmaCCAssociativeDirectiveNode #SmaCCAssociativeDirectiveNode #OrderedCollection #SmaCCIdDirectiveNode #OrderedCollection #SmaCCStartDirectiveNode #OrderedCollection #SmaCCFlagDirectiveNode #SmaCCParserTypeDirectiveNode #SmaCCIgnoreVariableDirectiveNode #OrderedCollection #SmaCCFlagDirectiveNode #SmaCCFlagDirectiveNode #SmaCCFlagDirectiveNode #SmaCCFlagDirectiveNode #SmaCCFlagDirectiveNode #SmaCCTokenRuleNode nil nil #SmaCCToken #SmaCCRegexNode #OrderedCollection #OrderedCollection #SmaCCRegexNode #OrderedCollection #SmaCCRegexNode #SmaCCProductionRuleNode nil nil #OrderedCollection #SmaCCProductionExpressionNode #OrderedCollection #SmaCCDefinitionNode #SmaCCSymbolNode #SmaCCSymbolNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
SmaCCDefinitionParser class >> transitionTable [
^#(
#[1 0 6 0 28 0 21 0 29 0 10 0 36 0 25 0 48 0 29 0 49 0 33 0 50 0 33 0 51 0 33 0 52 0 45 0 54 0 33 0 83 0 53 0 84 0 57 0 86 0 33 0 93 0 65 0 103] 
#[1 0 69 0 29 0 73 0 93] 
#[1 0 6 0 28 0 57 0 29 0 81 0 83 0 53 0 84 0 57 0 86] 
#[1 0 10 0 36 0 85 0 52 0 45 0 54] 
#[1 0 14 0 28 0 14 0 29 0 18 0 35 0 89 0 94] 
#[0 0 0 0 102] 
#[1 0 6 0 28 0 21 0 29 0 10 0 36 0 93 0 50 0 93 0 51 0 93 0 52 0 45 0 54 0 93 0 83 0 53 0 84 0 57 0 86 0 93 0 93 0 22 0 102 0 65 0 103] 
#[0 0 26 0 28 0 29 0 36 0 102 0 103] 
#[0 0 30 0 28 0 29 0 36 0 102 0 103] 
#[0 0 30 0 28 0 29 0 36 0 102 0 103] 
#[0 0 97 0 36] 
#[0 0 30 0 28 0 29 0 36 0 102 0 103] 
#[0 0 101 0 28] 
#[1 0 6 0 28 0 57 0 29 0 105 0 83 0 53 0 84 0 57 0 86] 
#[0 0 30 0 28 0 29 0 36 0 102 0 103] 
#[1 0 34 0 28 0 34 0 29 0 34 0 36 0 109 0 37 0 34 0 102 0 34 0 103] 
#[1 0 18 0 35 0 89 0 94] 
#[0 0 0 0 102] 
#[0 0 14 0 28 0 29 0 37] 
#[0 0 0 0 102] 
#[0 0 0 0 102] 
#[0 0 113 0 35] 
#[0 0 38 0 28 0 29 0 36 0 102 0 103] 
#[1 0 117 0 7 0 121 0 8 0 125 0 9 0 129 0 10 0 133 0 11 0 137 0 12 0 141 0 13 0 145 0 14 0 149 0 15 0 153 0 16 0 157 0 17 0 161 0 18 0 165 0 19 0 169 0 20 0 173 0 21 0 42 0 22 0 177 0 23 0 181 0 24 0 185 0 25 0 189 0 26 0 193 0 53 0 197 0 55 0 193 0 56 0 193 0 58 0 193 0 59 0 193 0 60 0 193 0 61 0 193 0 64 0 193 0 65 0 193 0 66 0 193 0 67 0 193 0 68 0 193 0 70 0 193 0 72 0 193 0 74 0 193 0 75 0 193 0 76 0 193 0 78 0 193 0 79 0 193 0 80 0 193 0 81 0 193 0 82] 
#[0 1 25 0 35] 
#[0 0 46 0 28 0 29 0 36 0 102 0 103] 
#[0 0 50 0 28 0 29 0 36 0 102 0 103] 
#[1 0 54 0 1 0 54 0 6 0 54 0 28 0 54 0 29 0 54 0 30 0 54 0 32 0 54 0 33 0 54 0 37 0 54 0 43 0 54 0 44 1 29 0 96 1 33 0 97 1 37 0 98] 
#[1 0 58 0 29 0 58 0 37 1 41 0 57] 
#[1 0 58 0 29 0 58 0 37 1 45 0 57] 
#[0 1 49 0 29] 
#[0 1 53 0 29] 
#[0 1 57 0 29] 
#[0 1 61 0 29] 
#[0 1 65 0 29] 
#[1 1 69 0 28 1 73 0 29 1 77 0 30 1 81 0 43 1 85 0 69 1 89 0 101] 
#[1 1 69 0 28 1 73 0 29 1 77 0 30 1 81 0 43 1 93 0 69 1 89 0 101] 
#[1 1 69 0 28 1 73 0 29 1 77 0 30 1 81 0 43 1 97 0 69 1 89 0 101] 
#[1 1 101 0 28 1 105 0 71] 
#[1 1 109 0 29 1 113 0 73] 
#[0 0 62 0 37] 
#[0 1 117 0 29] 
#[0 0 66 0 37] 
#[0 0 70 0 37] 
#[0 0 74 0 37] 
#[0 0 78 0 37] 
#[0 0 82 0 37] 
#[1 0 42 0 37 1 121 0 55] 
#[0 1 125 0 22] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[0 0 86 0 37] 
#[1 1 129 0 1 1 133 0 28 1 137 0 36 1 141 0 38 1 145 0 39 1 149 0 41 1 153 0 42 1 157 0 87 1 161 0 90 1 165 0 92] 
#[1 1 169 0 6 0 90 0 37 1 173 0 95] 
#[0 0 94 0 2 0 6 0 37] 
#[1 1 177 0 1 0 98 0 2 0 98 0 6 1 69 0 28 1 73 0 29 1 77 0 30 1 181 0 32 1 185 0 33 0 98 0 37 1 81 0 43 1 189 0 44 1 193 0 99 1 193 0 100 1 201 0 101] 
#[1 1 205 0 29 0 102 0 37 1 205 0 86] 
#[1 1 205 0 29 0 106 0 37 1 205 0 86] 
#[0 0 110 0 37] 
#[0 1 209 0 1] 
#[0 1 213 0 1] 
#[0 0 114 0 37] 
#[0 0 118 0 37] 
#[0 0 122 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 29 0 30 0 32 0 33 0 34 0 37 0 43 0 44] 
#[0 0 126 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 29 0 30 0 32 0 33 0 34 0 37 0 43 0 44] 
#[0 0 130 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 29 0 30 0 32 0 33 0 34 0 37 0 43 0 44] 
#[0 0 134 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 29 0 30 0 32 0 33 0 34 0 37 0 43 0 44] 
#[1 1 69 0 28 1 73 0 29 1 77 0 30 0 138 0 37 1 81 0 43 1 217 0 101] 
#[0 0 142 0 28 0 29 0 30 0 37 0 43] 
#[1 1 69 0 28 1 73 0 29 1 77 0 30 0 146 0 37 1 81 0 43 1 217 0 101] 
#[1 1 69 0 28 1 73 0 29 1 77 0 30 0 150 0 37 1 81 0 43 1 217 0 101] 
#[0 0 154 0 28 0 37] 
#[1 1 221 0 28 0 158 0 37] 
#[0 0 162 0 29 0 37] 
#[1 1 225 0 29 0 166 0 37] 
#[0 0 170 0 37] 
#[0 1 229 0 37] 
#[1 1 233 0 29 1 237 0 77] 
#[1 1 129 0 1 1 133 0 28 1 137 0 36 1 141 0 38 1 145 0 39 1 149 0 41 1 153 0 42 1 241 0 87 1 161 0 90 1 165 0 92] 
#[0 0 174 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 36 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 0 178 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 36 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 0 178 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 36 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 0 182 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 36 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 0 178 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 36 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 0 178 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 36 0 37 0 38 0 39 0 40 0 41 0 42] 
#[1 0 186 0 37 1 245 0 85] 
#[1 0 190 0 2 1 249 0 6 0 190 0 37 1 253 0 88 2 1 0 89] 
#[1 1 129 0 1 0 194 0 2 2 5 0 3 2 9 0 4 2 13 0 5 0 194 0 6 1 133 0 28 1 137 0 36 0 194 0 37 1 141 0 38 1 145 0 39 2 17 0 40 1 149 0 41 1 153 0 42 2 21 0 91 2 25 0 92] 
#[1 0 54 0 1 0 54 0 2 0 54 0 6 0 54 0 28 0 54 0 29 0 54 0 30 0 54 0 32 0 54 0 33 0 54 0 37 0 54 0 43 0 54 0 44 2 29 0 97 1 37 0 98] 
#[0 2 33 0 37] 
#[1 0 54 0 1 0 54 0 2 0 54 0 6 0 54 0 28 0 54 0 29 0 54 0 30 0 54 0 32 0 54 0 33 0 54 0 43 0 54 0 44 2 37 0 96 1 33 0 97 1 37 0 98] 
#[0 0 198 0 2 0 6 0 37] 
#[0 0 198 0 2 0 6 0 37] 
#[1 2 41 0 29 2 45 0 45] 
#[1 0 202 0 1 0 202 0 2 2 49 0 3 2 53 0 4 2 57 0 5 0 202 0 6 0 202 0 28 0 202 0 29 0 202 0 30 0 202 0 32 0 202 0 33 0 202 0 37 0 202 0 43 0 202 0 44] 
#[0 0 206 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 29 0 30 0 32 0 33 0 37 0 43 0 44] 
#[1 0 210 0 1 0 210 0 2 0 210 0 3 0 210 0 4 0 210 0 5 0 210 0 6 0 210 0 28 0 210 0 29 0 210 0 30 0 210 0 32 0 210 0 33 2 61 0 34 0 210 0 37 0 210 0 43 0 210 0 44] 
#[0 0 214 0 29 0 37] 
#[1 0 218 0 2 0 218 0 29 2 65 0 63] 
#[1 0 222 0 2 0 222 0 29 2 69 0 62] 
#[0 0 226 0 28 0 29 0 30 0 37 0 43] 
#[0 0 230 0 28 0 37] 
#[0 0 234 0 29 0 37] 
#[0 0 238 0 28 0 29 0 36 0 102 0 103] 
#[0 0 242 0 29 0 37] 
#[1 2 73 0 29 0 246 0 37] 
#[0 2 77 0 2] 
#[0 2 81 0 37] 
#[1 1 129 0 1 1 133 0 28 1 137 0 36 1 141 0 38 1 145 0 39 1 149 0 41 1 153 0 42 2 85 0 90 1 165 0 92] 
#[0 0 250 0 2 0 6 0 37] 
#[1 0 254 0 2 1 249 0 6 0 254 0 37 2 89 0 88] 
#[0 1 2 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 36 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 1 2 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 36 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 1 2 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 36 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 1 2 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 36 0 37 0 38 0 39 0 40 0 41 0 42] 
#[1 1 129 0 1 1 6 0 2 1 6 0 6 1 133 0 28 1 137 0 36 1 6 0 37 1 141 0 38 1 145 0 39 1 149 0 41 1 153 0 42 2 93 0 92] 
#[1 1 10 0 1 1 10 0 2 2 5 0 3 2 9 0 4 2 13 0 5 1 10 0 6 1 10 0 28 1 10 0 36 1 10 0 37 1 10 0 38 1 10 0 39 2 17 0 40 1 10 0 41 1 10 0 42] 
#[0 1 14 0 2 0 6 0 37] 
#[0 1 18 0 28 0 29 0 36 0 102 0 103] 
#[1 2 97 0 2 1 169 0 6] 
#[0 2 101 0 45] 
#[0 1 22 0 2 0 6 0 37] 
#[0 1 26 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 29 0 30 0 32 0 33 0 37 0 43 0 44] 
#[0 1 26 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 29 0 30 0 32 0 33 0 37 0 43 0 44] 
#[0 1 26 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 29 0 30 0 32 0 33 0 37 0 43 0 44] 
#[0 1 30 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 29 0 30 0 32 0 33 0 37 0 43 0 44] 
#[1 2 105 0 2 2 109 0 29] 
#[1 2 113 0 2 2 117 0 29] 
#[0 1 34 0 29 0 37] 
#[0 1 38 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 36 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 1 42 0 28 0 29 0 36 0 102 0 103] 
#[0 1 46 0 2 0 6 0 37] 
#[0 1 50 0 2 0 6 0 37] 
#[1 1 54 0 1 1 54 0 2 2 5 0 3 2 9 0 4 2 13 0 5 1 54 0 6 1 54 0 28 1 54 0 36 1 54 0 37 1 54 0 38 1 54 0 39 2 17 0 40 1 54 0 41 1 54 0 42] 
#[0 1 58 0 1 0 2 0 3 0 4 0 5 0 6 0 28 0 29 0 30 0 32 0 33 0 37 0 43 0 44] 
#[0 1 62 0 2 0 6 0 37] 
#[0 1 66 0 37] 
#[0 1 70 0 2 0 29] 
#[0 1 74 0 37] 
#[0 1 78 0 2 0 29]
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
SmaCCDefinitionParser >> reduceActionForParserRule4: nodes [
	| result |
	result := SmaCCClassProductionExpressionNode new.
	result addNodes: (nodes at: 1) to: result terms.
	result left: (nodes at: 2).
	result classname: (nodes at: 3).
	result right: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
SmaCCDefinitionParser >> reduceActionForParserRule5: nodes [
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
