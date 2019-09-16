Class {
	#name : #GrammarwareTestParser,
	#superclass : #SmaCCFGLRParser,
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #'generated-accessing' }
GrammarwareTestParser class >> cacheId [
	^'2019-04-23T10:05:32.346029+02:00'
]

{ #category : #generated }
GrammarwareTestParser class >> definitionComment [
"%states default scanner directives parser;
%root File;
%prefix Grammarware;
%suffix TNode;
%annotate_tokens;
%parserType fglr;

<patternToken> : `[^`]+` ;

directives <states>
	: states 
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
directives <ignorecase>
	: ignorecase
	;
directives <ignorevariables>
	: ignore_variables
	;
directives <annotate_tokens>
	: annotate_tokens
	;
directives <unicode>
	: unicode
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
<symbolname>
	: <name>
	 ;
<keyword>
	: (\"" [^\""]+ \"") + 
	;
<comment>
	: (\# [^\r\n]*) 
	| (\/\* [^\*]* \*+ ([^\/\*] [^\*]* \*+)* \/)
	;
<code>
	: \{ 
	;
<variablename>
	: \' <name> \' 
	;
<production>
	: \: (\: \=)? 
	;
<directive>
	: \% 
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
	: [^\ \t\v\\\r\n\{\(\[\.\%\:\<]
	; 
scanner <anycharacter>
	: \.
	;
	
parser <optionalLeft>
	: \[
	;
parser <optionalRight>
	: \] 
	;
parser <classLeft> 
	: \{\{ 
	;
parser <classRight> 
	: \}\} 
	;

%id <code> <keyword> <symbolname> <tokenname> <variablename> <semicolon>
	<directive> <production> <classLeft> <classRight>;
%left ""|"";
%left ""("" <character> <backslashcharacter> <characterblock> <anycharacter> <tokenname> <symbolname> <directive>;
%left ""*"" ""+"" ""?"" <repeat> ;

File
	: Rule 'rule' + {{}}
	;
	
Rule 
	: ProductionRule
	| DirectiveLine
	| PrefixedRegexRule
	;
	
# Directives
DirectiveLine 
	: StartDirective <directive> Directive 'directive' EndDirective <semicolon> {{}}
	;
	
Directive 
	: ExcludeStatesLine 
	| StatesLine
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
	| Unicode
	| IgnoreCase
	| IgnoredVariables
	| AnnotateTokens
	;
	
StartDirective 
	: 		{self scope: #directives. ^ nil}
	;
	
EndDirective 
	: 		{self scope: #default. ^ nil}
	;
	
StatesLine 
	: <states> Symbol 'scannerStates' * {{}}
	;

ExcludeStatesLine 
	: <excludes> Symbol 'scannerStates' * {{}} 
	;

RootClassLine
	: <root> Symbol 'root' {{}}
	;
	
SuperclassLine
	: <hierarchy> Symbol 'superclass' ""("" Symbol 'classes' *  "")"" {{}}
	;
	
AttributesLine
	: <attributes> Symbol 'aClass' ""(""  Symbol 'ivars' * "")"" {{}}
	;

PrefixLine
	: <prefix> Symbol 'prefix' {{}}
	;
	
SuffixLine
	: <suffix> Symbol 'suffix' {{}}
	;
	
LeftLine
	: <left> Term 'leftTokens' + {{}}
	;
	
RightLine
	: <right> Term 'rightTokens' + {{}}
	;
	
NonAssociativeLine
	: <nonassoc> Term 'noassocTokens' + {{}}
	;
		
IdMethodLine
	: <id> <tokenname> 'idTokens' + {{}}
	;
	
StartLine
	: <start> Symbol 'startingSymbols' + {{}}
	;

GLR
	: <glr> {{}}
	;
	
Unicode
	: <unicode> {{}}
	;
	
IgnoredVariables
	: EndDirective <ignorevariables> (Symbol 'variables')+ {{}}
	;

IgnoreCase
	: <ignorecase> {{}}
	;
	
AnnotateTokens
	: <annotate_tokens> {{}}
	;
	
# Scanner
PrefixedRegexRule
	: RegexRule 'scannerRule' {{}}
	| Symbol 'state' PrefixedRegexRule 'prefixedRule' {{}}
	;

RegexRule 
	: StartRegex <tokenname> 'token' <production> Regex 'regex' EndRegex <semicolon> {{}}
	;
	
StartRegex
	: 		{self scope: #scanner. ^ nil}
	;
	
EndRegex
	: 		{self scope: #default. ^ nil}
	;
	
Symbol 
	: <symbolname> 'symbolName' {{}}
	;
	
Regex
	: RegexTerm
	| Regex 'leftRegex' ""|"" Regex 'rightRegex' {{OrRegex}}
	| Regex 'leftRegex' RegexTerm 'rightRegex' {{SequenceRegex}}
	;
	
RegexTerm
	: <character> {{Character}}
	| <anycharacter> {{AnyCharacter}}
	| <backslashcharacter> {{BackslashCharacter}}
	| ""("" Regex 'group' "")"" {{GroupRegexTerm}}
	| <characterblock> {{CharacterBlock}}
	| <tokenname> {{Token}}
	| <symbolname> {{Symbol}}
	| RegexTerm 'term' ""*"" {{KleeneStarRegexTerm}}
	| RegexTerm 'term' ""+"" {{KleenePlusRegexTerm}}
	| RegexTerm 'term' ""?"" {{OptionalRegexTerm}}
	| RegexTerm 'term' <repeat>  {{RepeatRegexTerm}}
	;

# Parser 
ProductionRule
	: Symbol 'lhs' StartProduction <production> RightHandSide 'rhs' EndProduction <semicolon> {{}}
	;
	
StartProduction
	: 		{self scope: #parser. ^ nil}
	;
	
EndProduction
	: 		{self scope: #default. ^ nil}
	;
	
RightHandSide
	: Alternate 'alternate' (""|"" Alternate 'alternate') * {{}}
	;
	
Alternate
	: Terms 'rhsTerms' {{}}
	| Terms 'rhsTerms' <code> 'code' {{CodeAlternate}}
	| Terms 'rhsTerms' <classLeft> <symbolname> 'className' <classRight> {{ClassAlternate}}
	| Terms 'rhsTerms' <classLeft> <classRight> {{DefaultClassAlternate}}
	;

Terms
	: AnnotatedTerm 'term' * {{}}
	;

AnnotatedTerm
	: Term 'term' {{}}	
	| Term 'term' <variablename> 'variableName' {{NamedTerm}}
	| Term 'term' ""?"" {{OptionalTerm}}
	| Term 'term' <variablename> 'variableName' ""?"" {{NamedOptionalTerm}}
	| Term 'term' ""*"" {{KleeneStarTerm}}
	| Term 'term' <variablename> 'variableName' ""*"" {{NamedKleeneStarTerm}}
	| Term 'term' ""+"" {{KleenePlusTerm}}
	| Term 'term' <variablename> 'variableName' ""+"" {{NamedKleenePlusTerm}}
	;

Term
	: <keyword> {{Keyword}}
	| <tokenname>  {{Token}}
	| <symbolname>  {{NonTerminal}}
	| ""error"" {{Error}}
	| ""("" AnnotatedTerm 'term' + (""|"" AnnotatedTerm 'term' + )* "")"" {{GroupTerm}}
	| ""["" AnnotatedTerm 'term' + (""|"" AnnotatedTerm 'term' + )* ""]"" {{OptionalGroupTerm}}
	;"
]

{ #category : #generated }
GrammarwareTestParser class >> reduceTable [
^#(
	#(82 0 #reduceActionForStartRegex1:) 
	#(51 0 #reduceActionForStartDirective1:) 
	#(84 1 #reduceActionForSymbol1:) 
	#(46 1 #reduceActionForFile1:) 
	#(47 1 #reduceActionForRule__rule___1:) 
	#(48 1 #liftFirstValue:) 
	#(80 1 #reduceActionForPrefixedRegexRule1:) 
	#(88 0 #reduceActionForStartProduction1:) 
	#(47 2 #reduceActionForRule__rule___2:) 
	#(52 0 #reduceActionForEndDirective1:) 
	#(80 2 #reduceActionForPrefixedRegexRule2:) 
	#(54 0 #reduceActionForSymbol__scannerStates___1:) 
	#(73 1 #reduceActionForGLR1:) 
	#(78 1 #reduceActionForIgnoreCase1:) 
	#(79 1 #reduceActionForAnnotateTokens1:) 
	#(74 1 #reduceActionForUnicode1:) 
	#(50 1 #liftFirstValue:) 
	#(95 0 #reduceActionForSymbol__scannerStates___1:) 
	#(53 2 #reduceActionForStatesLine1:) 
	#(55 2 #reduceActionForExcludeStatesLine1:) 
	#(56 2 #reduceActionForRootClassLine1:) 
	#(61 2 #reduceActionForPrefixLine1:) 
	#(62 2 #reduceActionForSuffixLine1:) 
	#(97 1 #reduceActionForTerm4:) 
	#(97 1 #reduceActionForTerm2:) 
	#(97 1 #reduceActionForTerm3:) 
	#(97 1 #reduceActionForTerm1:) 
	#(63 2 #reduceActionForLeftLine1:) 
	#(64 1 #reduceActionForRule__rule___1:) 
	#(65 2 #reduceActionForRightLine1:) 
	#(66 1 #reduceActionForRule__rule___1:) 
	#(67 2 #reduceActionForNonAssociativeLine1:) 
	#(68 1 #reduceActionForRule__rule___1:) 
	#(70 1 #reduceActionForRule__rule___1:) 
	#(69 2 #reduceActionForIdMethodLine1:) 
	#(71 2 #reduceActionForStartLine1:) 
	#(72 1 #reduceActionForRule__rule___1:) 
	#(86 1 #reduceActionForTerm2:) 
	#(86 1 #reduceActionForRegexTerm7:) 
	#(86 1 #reduceActionForRegexTerm3:) 
	#(86 1 #reduceActionForRegexTerm5:) 
	#(86 1 #reduceActionForRegexTerm1:) 
	#(86 1 #reduceActionForRegexTerm2:) 
	#(83 0 #reduceActionForEndDirective1:) 
	#(85 1 #liftFirstValue:) 
	#(89 0 #reduceActionForEndDirective1:) 
	#(92 0 #reduceActionFor_____Alternate__alternate____1:) 
	#(93 1 #reduceActionForAlternate1:) 
	#(94 1 #reduceActionForTerms1:) 
	#(54 2 #reduceActionForRule__rule___2:) 
	#(58 0 #reduceActionForSymbol__scannerStates___1:) 
	#(60 0 #reduceActionForSymbol__scannerStates___1:) 
	#(98 1 #reduceActionForRule__rule___1:) 
	#(96 1 #reduceActionForAnnotatedTerm1:) 
	#(100 0 #reduceActionFor_____Alternate__alternate____1:) 
	#(64 2 #reduceActionForRule__rule___2:) 
	#(66 2 #reduceActionForRule__rule___2:) 
	#(68 2 #reduceActionForRule__rule___2:) 
	#(70 2 #reduceActionForRule__rule___2:) 
	#(72 2 #reduceActionForRule__rule___2:) 
	#(49 5 #reduceActionForDirectiveLine1:) 
	#(77 1 #reduceActionForRule__rule___1:) 
	#(75 3 #reduceActionForIgnoredVariables1:) 
	#(76 1 #liftFirstValue:) 
	#(85 2 #reduceActionForRegex3:) 
	#(86 2 #reduceActionForRegexTerm8:) 
	#(86 2 #reduceActionForRegexTerm9:) 
	#(86 2 #reduceActionForRegexTerm10:) 
	#(86 2 #reduceActionForRegexTerm11:) 
	#(90 2 #reduceActionForRightHandSide1:) 
	#(93 2 #reduceActionForAlternate2:) 
	#(95 2 #reduceActionForRule__rule___2:) 
	#(96 2 #reduceActionForAnnotatedTerm5:) 
	#(96 2 #reduceActionForAnnotatedTerm7:) 
	#(96 2 #reduceActionForAnnotatedTerm3:) 
	#(96 2 #reduceActionForAnnotatedTerm2:) 
	#(98 2 #reduceActionForRule__rule___2:) 
	#(77 2 #reduceActionForRule__rule___2:) 
	#(86 3 #reduceActionForRegexTerm4:) 
	#(85 3 #reduceActionForRegex2:) 
	#(81 6 #reduceActionForRegexRule1:) 
	#(87 6 #reduceActionForProductionRule1:) 
	#(92 2 #reduceActionFor_____Alternate__alternate____2:) 
	#(93 3 #reduceActionForAlternate4:) 
	#(57 5 #reduceActionForSuperclassLine1:) 
	#(58 2 #reduceActionForRule__rule___2:) 
	#(59 5 #reduceActionForAttributesLine1:) 
	#(60 2 #reduceActionForRule__rule___2:) 
	#(96 3 #reduceActionForAnnotatedTerm6:) 
	#(96 3 #reduceActionForAnnotatedTerm8:) 
	#(96 3 #reduceActionForAnnotatedTerm4:) 
	#(97 4 #reduceActionForTerm5:) 
	#(100 2 #reduceActionFor_____AnnotatedTerm__term______2:) 
	#(97 4 #reduceActionForTerm6:) 
	#(91 2 #reduceActionFor_____Alternate__alternate__1:) 
	#(93 4 #reduceActionForAlternate3:) 
	#(99 2 #reduceActionFor_____AnnotatedTerm__term_____1:)
	).
]

{ #category : #'generated-accessing' }
GrammarwareTestParser class >> scannerClass [
	^GrammarwareTestScanner
]

{ #category : #generated }
GrammarwareTestParser class >> startingStateForFile [
	^ 1
]

{ #category : #generated }
GrammarwareTestParser class >> symbolNames [
	^ #('"("' '")"' '"*"' '"+"' '"?"' '"["' '"]"' '"error"' '"|"' '<patternToken>' '<states>' '<excludes>' '<root>' '<hierarchy>' '<attributes>' '<prefix>' '<suffix>' '<left>' '<right>' '<nonassoc>' '<id>' '<start>' '<glr>' '<ignorecase>' '<ignorevariables>' '<annotate_tokens>' '<unicode>' '<whitespace>' '<tokenname>' '<symbolname>' '<keyword>' '<comment>' '<code>' '<variablename>' '<production>' '<directive>' '<semicolon>' '<backslashcharacter>' '<characterblock>' '<repeat>' '<character>' '<anycharacter>' '<classLeft>' '<classRight>' 'B e g i n' 'File' 'Rule ''rule'' +' 'Rule' 'DirectiveLine' 'Directive' 'StartDirective' 'EndDirective' 'StatesLine' 'Symbol ''scannerStates'' *' 'ExcludeStatesLine' 'RootClassLine' 'SuperclassLine' 'Symbol ''classes'' *' 'AttributesLine' 'Symbol ''ivars'' *' 'PrefixLine' 'SuffixLine' 'LeftLine' 'Term ''leftTokens'' +' 'RightLine' 'Term ''rightTokens'' +' 'NonAssociativeLine' 'Term ''noassocTokens'' +' 'IdMethodLine' '<tokenname> ''idTokens'' +' 'StartLine' 'Symbol ''startingSymbols'' +' 'GLR' 'Unicode' 'IgnoredVariables' '(Symbol ''variables'')' '(Symbol ''variables'')+' 'IgnoreCase' 'AnnotateTokens' 'PrefixedRegexRule' 'RegexRule' 'StartRegex' 'EndRegex' 'Symbol' 'Regex' 'RegexTerm' 'ProductionRule' 'StartProduction' 'EndProduction' 'RightHandSide' '("|" Alternate ''alternate'')' '("|" Alternate ''alternate'') *' 'Alternate' 'Terms' 'AnnotatedTerm ''term'' *' 'AnnotatedTerm' 'Term' 'AnnotatedTerm ''term'' +' '("|" AnnotatedTerm ''term'' + )' '("|" AnnotatedTerm ''term'' + )*' 'E O F' 'error')
]

{ #category : #generated }
GrammarwareTestParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GrammarwareFileTNode #GrammarwareFileTNode #OrderedCollection #GrammarwareFileTNode #GrammarwareDirectiveLineTNode #GrammarwareFileTNode nil nil #GrammarwareStatesLineTNode #OrderedCollection #GrammarwareExcludeStatesLineTNode #GrammarwareRootClassLineTNode #GrammarwareSuperclassLineTNode #OrderedCollection #GrammarwareAttributesLineTNode #OrderedCollection #GrammarwarePrefixLineTNode #GrammarwareSuffixLineTNode #GrammarwareLeftLineTNode #OrderedCollection #GrammarwareRightLineTNode #OrderedCollection #GrammarwareNonAssociativeLineTNode #OrderedCollection #GrammarwareIdMethodLineTNode #OrderedCollection #GrammarwareStartLineTNode #OrderedCollection #GrammarwareGLRTNode #GrammarwareUnicodeTNode #GrammarwareIgnoredVariablesTNode #GrammarwareSymbolTNode #OrderedCollection #GrammarwareIgnoreCaseTNode #GrammarwareAnnotateTokensTNode #GrammarwarePrefixedRegexRuleTNode #GrammarwareRegexRuleTNode nil nil #GrammarwareSymbolTNode #GrammarwareFileTNode #GrammarwareFileTNode #GrammarwareProductionRuleTNode nil nil #GrammarwareRightHandSideTNode #OrderedCollection #OrderedCollection #GrammarwareFileTNode #GrammarwareTermsTNode #OrderedCollection #GrammarwareFileTNode #GrammarwareFileTNode #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GrammarwareTestParser class >> transitionTable [
^#(
#[1 0 6 0 29 0 9 0 30 0 10 0 36 0 13 0 46 0 17 0 47 0 21 0 48 0 21 0 49 0 29 0 51 0 21 0 80 0 37 0 81 0 41 0 82 0 45 0 84 0 21 0 87] 
#[0 0 14 0 1 0 2 0 29 0 30 0 35 0 37] 
#[0 0 0 0 101] 
#[1 0 6 0 29 0 9 0 30 0 10 0 36 0 53 0 48 0 53 0 49 0 29 0 51 0 53 0 80 0 37 0 81 0 41 0 82 0 45 0 84 0 53 0 87 0 18 0 101] 
#[0 0 22 0 29 0 30 0 36 0 101] 
#[0 0 26 0 29 0 30 0 36 0 101] 
#[0 0 57 0 36] 
#[0 0 26 0 29 0 30 0 36 0 101] 
#[0 0 30 0 29 0 30 0 36 0 101] 
#[0 0 61 0 29] 
#[1 0 6 0 29 0 9 0 30 0 34 0 35 0 65 0 80 0 37 0 81 0 41 0 82 0 69 0 84 0 73 0 88] 
#[0 0 26 0 29 0 30 0 36 0 101] 
#[0 0 38 0 29 0 30 0 36 0 101] 
#[1 0 77 0 11 0 81 0 12 0 85 0 13 0 89 0 14 0 93 0 15 0 97 0 16 0 101 0 17 0 105 0 18 0 109 0 19 0 113 0 20 0 117 0 21 0 121 0 22 0 125 0 23 0 129 0 24 0 42 0 25 0 133 0 26 0 137 0 27 0 141 0 50 0 145 0 52 0 141 0 53 0 141 0 55 0 141 0 56 0 141 0 57 0 141 0 59 0 141 0 61 0 141 0 62 0 141 0 63 0 141 0 65 0 141 0 67 0 141 0 69 0 141 0 71 0 141 0 73 0 141 0 74 0 141 0 75 0 141 0 78 0 141 0 79] 
#[0 0 217 0 35] 
#[0 0 46 0 29 0 30 0 36 0 101] 
#[1 0 6 0 29 0 9 0 30 0 65 0 80 0 37 0 81 0 41 0 82 0 69 0 84] 
#[0 0 221 0 35] 
#[1 0 50 0 30 0 50 0 37 0 225 0 54] 
#[1 0 50 0 30 0 50 0 37 0 229 0 54] 
#[1 0 9 0 30 0 233 0 84] 
#[1 0 9 0 30 0 237 0 84] 
#[1 0 9 0 30 0 241 0 84] 
#[1 0 9 0 30 0 245 0 84] 
#[1 0 9 0 30 0 249 0 84] 
#[1 0 253 0 1 1 1 0 6 1 5 0 8 1 9 0 29 1 13 0 30 1 17 0 31 1 21 0 64 1 25 0 97] 
#[1 0 253 0 1 1 1 0 6 1 5 0 8 1 9 0 29 1 13 0 30 1 17 0 31 1 29 0 66 1 33 0 97] 
#[1 0 253 0 1 1 1 0 6 1 5 0 8 1 9 0 29 1 13 0 30 1 17 0 31 1 37 0 68 1 41 0 97] 
#[1 1 45 0 29 1 49 0 70] 
#[1 0 9 0 30 1 53 0 72 1 57 0 84] 
#[0 0 54 0 37] 
#[0 0 58 0 37] 
#[0 0 62 0 37] 
#[0 0 66 0 37] 
#[1 0 42 0 37 1 61 0 52] 
#[0 1 65 0 25] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[0 0 70 0 37] 
#[1 1 69 0 1 1 73 0 29 1 77 0 30 1 81 0 38 1 85 0 39 1 89 0 41 1 93 0 42 1 97 0 85 1 101 0 86] 
#[1 0 74 0 1 0 74 0 6 0 74 0 8 0 74 0 9 0 74 0 29 0 74 0 30 0 74 0 31 0 74 0 33 0 74 0 37 0 74 0 43 1 105 0 90 1 109 0 93 1 113 0 94 1 117 0 95] 
#[1 0 9 0 30 0 78 0 37 1 121 0 84] 
#[1 0 9 0 30 0 82 0 37 1 121 0 84] 
#[0 0 86 0 37] 
#[0 1 125 0 1] 
#[0 1 129 0 1] 
#[0 0 90 0 37] 
#[0 0 94 0 37] 
#[1 0 253 0 1 1 1 0 6 1 5 0 8 1 9 0 29 1 13 0 30 1 17 0 31 1 133 0 96 1 137 0 97 1 141 0 98] 
#[1 0 253 0 1 1 1 0 6 1 5 0 8 1 9 0 29 1 13 0 30 1 17 0 31 1 133 0 96 1 137 0 97 1 145 0 98] 
#[0 0 98 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 29 0 30 0 31 0 33 0 34 0 37 0 43] 
#[0 0 102 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 29 0 30 0 31 0 33 0 34 0 37 0 43] 
#[0 0 106 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 29 0 30 0 31 0 33 0 34 0 37 0 43] 
#[0 0 110 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 29 0 30 0 31 0 33 0 34 0 37 0 43] 
#[1 0 253 0 1 1 1 0 6 1 5 0 8 1 9 0 29 1 13 0 30 1 17 0 31 0 114 0 37 1 149 0 97] 
#[0 0 118 0 1 0 6 0 8 0 29 0 30 0 31 0 37] 
#[1 0 253 0 1 1 1 0 6 1 5 0 8 1 9 0 29 1 13 0 30 1 17 0 31 0 122 0 37 1 153 0 97] 
#[0 0 126 0 1 0 6 0 8 0 29 0 30 0 31 0 37] 
#[1 0 253 0 1 1 1 0 6 1 5 0 8 1 9 0 29 1 13 0 30 1 17 0 31 0 130 0 37 1 157 0 97] 
#[0 0 134 0 1 0 6 0 8 0 29 0 30 0 31 0 37] 
#[0 0 138 0 29 0 37] 
#[1 1 161 0 29 0 142 0 37] 
#[1 0 9 0 30 0 146 0 37 1 165 0 84] 
#[0 0 150 0 30 0 37] 
#[0 1 169 0 37] 
#[1 0 9 0 30 1 173 0 76 1 177 0 77 1 173 0 84] 
#[1 1 69 0 1 1 73 0 29 1 77 0 30 1 81 0 38 1 85 0 39 1 89 0 41 1 93 0 42 1 185 0 85 1 101 0 86] 
#[0 0 154 0 1 0 2 0 3 0 4 0 5 0 9 0 29 0 30 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 0 158 0 1 0 2 0 3 0 4 0 5 0 9 0 29 0 30 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 0 162 0 1 0 2 0 3 0 4 0 5 0 9 0 29 0 30 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 0 166 0 1 0 2 0 3 0 4 0 5 0 9 0 29 0 30 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 0 170 0 1 0 2 0 3 0 4 0 5 0 9 0 29 0 30 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 0 174 0 1 0 2 0 3 0 4 0 5 0 9 0 29 0 30 0 37 0 38 0 39 0 40 0 41 0 42] 
#[1 1 69 0 1 1 189 0 9 1 73 0 29 1 77 0 30 0 178 0 37 1 81 0 38 1 85 0 39 1 89 0 41 1 93 0 42 1 193 0 83 1 197 0 86] 
#[1 0 182 0 1 0 182 0 2 1 201 0 3 1 205 0 4 1 209 0 5 0 182 0 9 0 182 0 29 0 182 0 30 0 182 0 37 0 182 0 38 0 182 0 39 1 213 0 40 0 182 0 41 0 182 0 42] 
#[1 0 186 0 37 1 217 0 89] 
#[1 0 190 0 9 0 190 0 37 1 221 0 92] 
#[1 0 194 0 9 1 225 0 33 0 194 0 37 1 229 0 43] 
#[1 0 253 0 1 1 1 0 6 1 5 0 8 0 198 0 9 1 9 0 29 1 13 0 30 1 17 0 31 0 198 0 33 0 198 0 37 0 198 0 43 1 233 0 96 1 137 0 97] 
#[0 0 202 0 30 0 37] 
#[1 0 206 0 2 0 206 0 30 1 237 0 58] 
#[1 0 210 0 2 0 210 0 30 1 241 0 60] 
#[0 0 214 0 1 0 2 0 6 0 7 0 8 0 9 0 29 0 30 0 31] 
#[1 0 218 0 1 0 218 0 2 1 245 0 3 1 249 0 4 1 253 0 5 0 218 0 6 0 218 0 7 0 218 0 8 0 218 0 9 0 218 0 29 0 218 0 30 0 218 0 31 0 218 0 33 2 1 0 34 0 218 0 37 0 218 0 43] 
#[1 0 253 0 1 0 222 0 2 1 1 0 6 1 5 0 8 0 222 0 9 1 9 0 29 1 13 0 30 1 17 0 31 2 5 0 96 1 137 0 97 2 9 0 100] 
#[1 0 253 0 1 1 1 0 6 0 222 0 7 1 5 0 8 0 222 0 9 1 9 0 29 1 13 0 30 1 17 0 31 2 5 0 96 1 137 0 97 2 13 0 100] 
#[0 0 226 0 1 0 6 0 8 0 29 0 30 0 31 0 37] 
#[0 0 230 0 1 0 6 0 8 0 29 0 30 0 31 0 37] 
#[0 0 234 0 1 0 6 0 8 0 29 0 30 0 31 0 37] 
#[0 0 238 0 29 0 37] 
#[0 0 242 0 30 0 37] 
#[0 0 246 0 29 0 30 0 36 0 101] 
#[0 0 250 0 30 0 37] 
#[1 0 9 0 30 0 254 0 37 2 17 0 76 2 17 0 84] 
#[0 1 2 0 30 0 37] 
#[1 1 69 0 1 2 21 0 2 1 189 0 9 1 73 0 29 1 77 0 30 1 81 0 38 1 85 0 39 1 89 0 41 1 93 0 42 1 197 0 86] 
#[1 1 69 0 1 1 73 0 29 1 77 0 30 1 81 0 38 1 85 0 39 1 89 0 41 1 93 0 42 2 25 0 85 1 101 0 86] 
#[0 2 29 0 37] 
#[1 1 6 0 1 1 6 0 2 1 201 0 3 1 205 0 4 1 209 0 5 1 6 0 9 1 6 0 29 1 6 0 30 1 6 0 37 1 6 0 38 1 6 0 39 1 213 0 40 1 6 0 41 1 6 0 42] 
#[0 1 10 0 1 0 2 0 3 0 4 0 5 0 9 0 29 0 30 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 1 14 0 1 0 2 0 3 0 4 0 5 0 9 0 29 0 30 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 1 18 0 1 0 2 0 3 0 4 0 5 0 9 0 29 0 30 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 1 22 0 1 0 2 0 3 0 4 0 5 0 9 0 29 0 30 0 37 0 38 0 39 0 40 0 41 0 42] 
#[0 2 33 0 37] 
#[1 2 37 0 9 1 26 0 37 2 41 0 91] 
#[0 1 30 0 9 0 37] 
#[1 2 45 0 30 2 49 0 44] 
#[0 1 34 0 1 0 6 0 8 0 9 0 29 0 30 0 31 0 33 0 37 0 43] 
#[1 2 53 0 2 0 9 0 30 2 57 0 84] 
#[1 2 61 0 2 0 9 0 30 2 65 0 84] 
#[0 1 38 0 1 0 2 0 6 0 7 0 8 0 9 0 29 0 30 0 31 0 33 0 37 0 43] 
#[0 1 42 0 1 0 2 0 6 0 7 0 8 0 9 0 29 0 30 0 31 0 33 0 37 0 43] 
#[0 1 46 0 1 0 2 0 6 0 7 0 8 0 9 0 29 0 30 0 31 0 33 0 37 0 43] 
#[1 1 50 0 1 1 50 0 2 2 69 0 3 2 73 0 4 2 77 0 5 1 50 0 6 1 50 0 7 1 50 0 8 1 50 0 9 1 50 0 29 1 50 0 30 1 50 0 31 1 50 0 33 1 50 0 37 1 50 0 43] 
#[0 1 54 0 1 0 2 0 6 0 7 0 8 0 9 0 29 0 30 0 31] 
#[1 2 81 0 2 2 85 0 9 2 89 0 99] 
#[1 2 93 0 7 2 85 0 9 2 89 0 99] 
#[0 1 58 0 30 0 37] 
#[0 1 62 0 1 0 2 0 3 0 4 0 5 0 9 0 29 0 30 0 37 0 38 0 39 0 40 0 41 0 42] 
#[1 1 69 0 1 1 66 0 2 1 66 0 9 1 73 0 29 1 77 0 30 1 66 0 37 1 81 0 38 1 85 0 39 1 89 0 41 1 93 0 42 1 197 0 86] 
#[0 1 70 0 29 0 30 0 36 0 101] 
#[0 1 74 0 29 0 30 0 36 0 101] 
#[1 0 74 0 1 0 74 0 6 0 74 0 8 0 74 0 9 0 74 0 29 0 74 0 30 0 74 0 31 0 74 0 33 0 74 0 37 0 74 0 43 2 97 0 93 1 113 0 94 1 117 0 95] 
#[0 1 78 0 9 0 37] 
#[0 2 101 0 44] 
#[0 1 82 0 9 0 37] 
#[0 1 86 0 37] 
#[0 1 90 0 2 0 30] 
#[0 1 94 0 37] 
#[0 1 98 0 2 0 30] 
#[0 1 102 0 1 0 2 0 6 0 7 0 8 0 9 0 29 0 30 0 31 0 33 0 37 0 43] 
#[0 1 106 0 1 0 2 0 6 0 7 0 8 0 9 0 29 0 30 0 31 0 33 0 37 0 43] 
#[0 1 110 0 1 0 2 0 6 0 7 0 8 0 9 0 29 0 30 0 31 0 33 0 37 0 43] 
#[0 1 114 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 29 0 30 0 31 0 33 0 34 0 37 0 43] 
#[1 0 253 0 1 1 1 0 6 1 5 0 8 1 9 0 29 1 13 0 30 1 17 0 31 1 133 0 96 1 137 0 97 2 105 0 98] 
#[0 1 118 0 2 0 7 0 9] 
#[0 1 122 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 29 0 30 0 31 0 33 0 34 0 37 0 43] 
#[0 1 126 0 9 0 37] 
#[0 1 130 0 9 0 37] 
#[1 0 253 0 1 1 134 0 2 1 1 0 6 1 134 0 7 1 5 0 8 1 134 0 9 1 9 0 29 1 13 0 30 1 17 0 31 2 5 0 96 1 137 0 97]
	).
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAlternate1: nodes [
	| result |
	result := GrammarwareAlternateTNode new.
	result rhsTerms: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAlternate2: nodes [
	| result |
	result := GrammarwareCodeAlternateTNode new.
	result rhsTerms: (nodes at: 1).
	result code: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAlternate3: nodes [
	| result |
	result := GrammarwareClassAlternateTNode new.
	result rhsTerms: (nodes at: 1).
	result classLeftToken: (nodes at: 2).
	result _className: (nodes at: 3).
	result classRightToken: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAlternate4: nodes [
	| result |
	result := GrammarwareDefaultClassAlternateTNode new.
	result rhsTerms: (nodes at: 1).
	result classLeftToken: (nodes at: 2).
	result classRightToken: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAnnotateTokens1: nodes [
	| result |
	result := GrammarwareAnnotateTokensTNode new.
	result annotate_tokensToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAnnotatedTerm1: nodes [
	| result |
	result := GrammarwareAnnotatedTermTNode new.
	result term: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAnnotatedTerm2: nodes [
	| result |
	result := GrammarwareNamedTermTNode new.
	result term: (nodes at: 1).
	result variableName: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAnnotatedTerm3: nodes [
	| result |
	result := GrammarwareOptionalTermTNode new.
	result term: (nodes at: 1).
	result questionMarkToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAnnotatedTerm4: nodes [
	| result |
	result := GrammarwareNamedOptionalTermTNode new.
	result term: (nodes at: 1).
	result variableName: (nodes at: 2).
	result questionMarkToken: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAnnotatedTerm5: nodes [
	| result |
	result := GrammarwareKleeneStarTermTNode new.
	result term: (nodes at: 1).
	result timesToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAnnotatedTerm6: nodes [
	| result |
	result := GrammarwareNamedKleeneStarTermTNode new.
	result term: (nodes at: 1).
	result variableName: (nodes at: 2).
	result timesToken: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAnnotatedTerm7: nodes [
	| result |
	result := GrammarwareKleenePlusTermTNode new.
	result term: (nodes at: 1).
	result plusToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAnnotatedTerm8: nodes [
	| result |
	result := GrammarwareNamedKleenePlusTermTNode new.
	result term: (nodes at: 1).
	result variableName: (nodes at: 2).
	result plusToken: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForAttributesLine1: nodes [
	| result |
	result := GrammarwareAttributesLineTNode new.
	result attributesToken: (nodes at: 1).
	result aClass: (nodes at: 2).
	result leftParenToken: (nodes at: 3).
	result addNodes: (nodes at: 4) to: result ivarses.
	result rightParenToken: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForDirectiveLine1: nodes [
	| result |
	result := GrammarwareDirectiveLineTNode new.
	result directiveToken: (nodes at: 2).
	result directive: (nodes at: 3).
	result semicolonToken: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForEndDirective1: nodes [
	self scope: #default.
	^ nil
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForExcludeStatesLine1: nodes [
	| result |
	result := GrammarwareExcludeStatesLineTNode new.
	result excludesToken: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result scannerStateses.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForFile1: nodes [
	| result |
	result := GrammarwareFileTNode new.
	result addNodes: (nodes at: 1) to: result rules.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForGLR1: nodes [
	| result |
	result := GrammarwareGLRTNode new.
	result glrToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForIdMethodLine1: nodes [
	| result |
	result := GrammarwareIdMethodLineTNode new.
	result idToken: (nodes at: 1).
	result addTokens: (nodes at: 2) to: result idTokenses.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForIgnoreCase1: nodes [
	| result |
	result := GrammarwareIgnoreCaseTNode new.
	result ignorecaseToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForIgnoredVariables1: nodes [
	| result |
	result := GrammarwareIgnoredVariablesTNode new.
	result ignorevariablesToken: (nodes at: 2).
	result addNodes: (nodes at: 3) to: result variableses.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForLeftLine1: nodes [
	| result |
	result := GrammarwareLeftLineTNode new.
	result leftToken: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result leftTokenses.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForNonAssociativeLine1: nodes [
	| result |
	result := GrammarwareNonAssociativeLineTNode new.
	result nonassocToken: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result noassocTokenses.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForPrefixLine1: nodes [
	| result |
	result := GrammarwarePrefixLineTNode new.
	result prefixToken: (nodes at: 1).
	result prefix: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForPrefixedRegexRule1: nodes [
	| result |
	result := GrammarwarePrefixedRegexRuleTNode new.
	result scannerRule: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForPrefixedRegexRule2: nodes [
	| result |
	result := GrammarwarePrefixedRegexRuleTNode new.
	result state: (nodes at: 1).
	result prefixedRule: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForProductionRule1: nodes [
	| result |
	result := GrammarwareProductionRuleTNode new.
	result lhs: (nodes at: 1).
	result productionToken: (nodes at: 3).
	result rhs: (nodes at: 4).
	result semicolonToken: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegex2: nodes [
	| result |
	result := GrammarwareOrRegexTNode new.
	result leftRegex: (nodes at: 1).
	result orToken: (nodes at: 2).
	result rightRegex: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegex3: nodes [
	| result |
	result := GrammarwareSequenceRegexTNode new.
	result leftRegex: (nodes at: 1).
	result rightRegex: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegexRule1: nodes [
	| result |
	result := GrammarwareRegexRuleTNode new.
	result token: (nodes at: 2).
	result productionToken: (nodes at: 3).
	result regex: (nodes at: 4).
	result semicolonToken: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegexTerm10: nodes [
	| result |
	result := GrammarwareOptionalRegexTermTNode new.
	result term: (nodes at: 1).
	result questionMarkToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegexTerm11: nodes [
	| result |
	result := GrammarwareRepeatRegexTermTNode new.
	result term: (nodes at: 1).
	result repeatToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegexTerm1: nodes [
	| result |
	result := GrammarwareCharacterTNode new.
	result characterToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegexTerm2: nodes [
	| result |
	result := GrammarwareAnyCharacterTNode new.
	result anycharacterToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegexTerm3: nodes [
	| result |
	result := GrammarwareBackslashCharacterTNode new.
	result backslashcharacterToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegexTerm4: nodes [
	| result |
	result := GrammarwareGroupRegexTermTNode new.
	result leftParenToken: (nodes at: 1).
	result group: (nodes at: 2).
	result rightParenToken: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegexTerm5: nodes [
	| result |
	result := GrammarwareCharacterBlockTNode new.
	result characterblockToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegexTerm7: nodes [
	| result |
	result := GrammarwareSymbolTNode new.
	result symbolnameToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegexTerm8: nodes [
	| result |
	result := GrammarwareKleeneStarRegexTermTNode new.
	result term: (nodes at: 1).
	result timesToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRegexTerm9: nodes [
	| result |
	result := GrammarwareKleenePlusRegexTermTNode new.
	result term: (nodes at: 1).
	result plusToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRightHandSide1: nodes [
	| result |
	result := GrammarwareRightHandSideTNode new.
	result addNode: (nodes at: 1) to: result alternates.
	result addTokens: ((nodes at: 2) at: 1) to: result orTokens.
	result addNodes: ((nodes at: 2) at: 2) to: result alternates.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRightLine1: nodes [
	| result |
	result := GrammarwareRightLineTNode new.
	result rightToken: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result rightTokenses.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRootClassLine1: nodes [
	| result |
	result := GrammarwareRootClassLineTNode new.
	result rootToken: (nodes at: 1).
	result root: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRule__rule___1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForRule__rule___2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForStartDirective1: nodes [
	self scope: #directives.
	^ nil
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForStartLine1: nodes [
	| result |
	result := GrammarwareStartLineTNode new.
	result startToken: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result startingSymbolses.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForStartProduction1: nodes [
	self scope: #parser.
	^ nil
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForStartRegex1: nodes [
	self scope: #scanner.
	^ nil
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForStatesLine1: nodes [
	| result |
	result := GrammarwareStatesLineTNode new.
	result statesToken: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result scannerStateses.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForSuffixLine1: nodes [
	| result |
	result := GrammarwareSuffixLineTNode new.
	result suffixToken: (nodes at: 1).
	result suffix: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForSuperclassLine1: nodes [
	| result |
	result := GrammarwareSuperclassLineTNode new.
	result hierarchyToken: (nodes at: 1).
	result superclass: (nodes at: 2).
	result leftParenToken: (nodes at: 3).
	result addNodes: (nodes at: 4) to: result classeses.
	result rightParenToken: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForSymbol1: nodes [
	| result |
	result := GrammarwareSymbolTNode new.
	result symbolName: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForSymbol__scannerStates___1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForTerm1: nodes [
	| result |
	result := GrammarwareKeywordTNode new.
	result keywordToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForTerm2: nodes [
	| result |
	result := GrammarwareTokenTNode new.
	result tokennameToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForTerm3: nodes [
	| result |
	result := GrammarwareNonTerminalTNode new.
	result symbolnameToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForTerm4: nodes [
	| result |
	result := GrammarwareErrorTNode new.
	result errorToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForTerm5: nodes [
	| result |
	result := GrammarwareGroupTermTNode new.
	result leftParenToken: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result terms.
	result addTokens: ((nodes at: 3) at: 1) to: result orTokens.
	result addNodes: ((nodes at: 3) at: 2) to: result terms.
	result rightParenToken: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForTerm6: nodes [
	| result |
	result := GrammarwareOptionalGroupTermTNode new.
	result leftBracketToken: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result terms.
	result addTokens: ((nodes at: 3) at: 1) to: result orTokens.
	result addNodes: ((nodes at: 3) at: 2) to: result terms.
	result rightBracketToken: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForTerms1: nodes [
	| result |
	result := GrammarwareTermsTNode new.
	result addNodes: (nodes at: 1) to: result terms.
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionForUnicode1: nodes [
	| result |
	result := GrammarwareUnicodeTNode new.
	result unicodeToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionFor_____Alternate__alternate__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionFor_____Alternate__alternate____1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionFor_____Alternate__alternate____2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionFor_____AnnotatedTerm__term_____1: nodes [
	| result |
	result := Array new: 2.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self addAll: (nodes at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GrammarwareTestParser >> reduceActionFor_____AnnotatedTerm__term______2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self addAll: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]
