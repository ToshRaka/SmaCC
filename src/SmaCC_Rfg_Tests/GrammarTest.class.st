Class {
	#name : #GrammarTest,
	#superclass : #ParserTest,
	#category : #'SmaCC_Rfg_Tests-Core'
}

{ #category : #accessing }
GrammarTest class >> grammarString [
	^ '%states default scanner directives parser;
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
	: (\" [^\"]+ \") + 
	;
<comment>
	: (\# [^\r\n]*) 
	| (\/\* [^\*]* \*+ ([^\/\*] [^\*]* \*+)* \/)
	;
<code>
	: \{ 
	;
<variablename>
	: \'' <name> \'' 
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
%left "|";
%left "(" <character> <backslashcharacter> <characterblock> <anycharacter> <tokenname> <symbolname> <directive>;
%left "*" "+" "?" <repeat> ;

File
	: Rule ''rule'' + {{}}
	;
	
Rule 
	: ProductionRule
	| DirectiveLine
	| PrefixedRegexRule
	;
	
# Directives
DirectiveLine 
	: StartDirective <directive> Directive ''directive'' EndDirective <semicolon> {{}}
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
	: <states> Symbol ''scannerStates'' * {{}}
	;

ExcludeStatesLine 
	: <excludes> Symbol ''scannerStates'' * {{}} 
	;

RootClassLine
	: <root> Symbol ''root'' {{}}
	;
	
SuperclassLine
	: <hierarchy> Symbol ''superclass'' "(" Symbol ''classes'' *  ")" {{}}
	;
	
AttributesLine
	: <attributes> Symbol ''aClass'' "("  Symbol ''ivars'' * ")" {{}}
	;

PrefixLine
	: <prefix> Symbol ''prefix'' {{}}
	;
	
SuffixLine
	: <suffix> Symbol ''suffix'' {{}}
	;
	
LeftLine
	: <left> Term ''leftTokens'' + {{}}
	;
	
RightLine
	: <right> Term ''rightTokens'' + {{}}
	;
	
NonAssociativeLine
	: <nonassoc> Term ''noassocTokens'' + {{}}
	;
		
IdMethodLine
	: <id> <tokenname> ''idTokens'' + {{}}
	;
	
StartLine
	: <start> Symbol ''startingSymbols'' + {{}}
	;

GLR
	: <glr> {{}}
	;
	
Unicode
	: <unicode> {{}}
	;
	
IgnoredVariables
	: EndDirective <ignorevariables> (Symbol ''variables'')+ {{}}
	;

IgnoreCase
	: <ignorecase> {{}}
	;
	
AnnotateTokens
	: <annotate_tokens> {{}}
	;
	
# Scanner
PrefixedRegexRule
	: RegexRule ''scannerRule'' {{}}
	| Symbol ''state'' PrefixedRegexRule ''prefixedRule'' {{}}
	;

RegexRule 
	: StartRegex <tokenname> ''token'' <production> Regex ''regex'' EndRegex <semicolon> {{}}
	;
	
StartRegex
	: 		{self scope: #scanner. ^ nil}
	;
	
EndRegex
	: 		{self scope: #default. ^ nil}
	;
	
Symbol 
	: <symbolname> ''symbolName'' {{}}
	;
	
Regex
	: RegexTerm
	| Regex ''leftRegex'' "|" Regex ''rightRegex'' {{OrRegex}}
	| Regex ''leftRegex'' RegexTerm ''rightRegex'' {{SequenceRegex}}
	;
	
RegexTerm
	: <character> {{Character}}
	| <anycharacter> {{AnyCharacter}}
	| <backslashcharacter> {{BackslashCharacter}}
	| "(" Regex ''group'' ")" {{GroupRegexTerm}}
	| <characterblock> {{CharacterBlock}}
	| <tokenname> {{Token}}
	| <symbolname> {{Symbol}}
	| RegexTerm ''term'' "*" {{KleeneStarRegexTerm}}
	| RegexTerm ''term'' "+" {{KleenePlusRegexTerm}}
	| RegexTerm ''term'' "?" {{OptionalRegexTerm}}
	| RegexTerm ''term'' <repeat>  {{RepeatRegexTerm}}
	;

# Parser 
ProductionRule
	: Symbol ''lhs'' StartProduction <production> RightHandSide ''rhs'' EndProduction <semicolon> {{}}
	;
	
StartProduction
	: 		{self scope: #parser. ^ nil}
	;
	
EndProduction
	: 		{self scope: #default. ^ nil}
	;
	
RightHandSide
	: Alternate ''alternate'' ("|" Alternate ''alternate'') * {{}}
	;
	
Alternate
	: Terms ''rhsTerms'' {{}}
	| Terms ''rhsTerms'' <code> ''code'' {{CodeAlternate}}
	| Terms ''rhsTerms'' <classLeft> <symbolname> ''className'' <classRight> {{ClassAlternate}}
	| Terms ''rhsTerms'' <classLeft> <classRight> {{DefaultClassAlternate}}
	;

Terms
	: AnnotatedTerm ''term'' * {{}}
	;

AnnotatedTerm
	: Term ''term'' {{}}	
	| Term ''term'' <variablename> ''variableName'' {{NamedTerm}}
	| Term ''term'' "?" {{OptionalTerm}}
	| Term ''term'' <variablename> ''variableName'' "?" {{NamedOptionalTerm}}
	| Term ''term'' "*" {{KleeneStarTerm}}
	| Term ''term'' <variablename> ''variableName'' "*" {{NamedKleeneStarTerm}}
	| Term ''term'' "+" {{KleenePlusTerm}}
	| Term ''term'' <variablename> ''variableName'' "+" {{NamedKleenePlusTerm}}
	;

Term
	: <keyword> {{Keyword}}
	| <tokenname>  {{Token}}
	| <symbolname>  {{NonTerminal}}
	| "error" {{Error}}
	| "(" AnnotatedTerm ''term'' + ("|" AnnotatedTerm ''term'' + )* ")" {{GroupTerm}}
	| "[" AnnotatedTerm ''term'' + ("|" AnnotatedTerm ''term'' + )* "]" {{OptionalGroupTerm}}
	;'
]

{ #category : #accessing }
GrammarTest class >> parserClassSymbol [
	^ #GrammarwareTestParser
]

{ #category : #accessing }
GrammarTest class >> scannerClassSymbol [
	^ #GrammarwareTestScanner
]

{ #category : #'tests-list matching' }
GrammarTest >> testCollectionAllGreedy [
	| source ast pattern matches |
	source := 'Grammar : "a" ; '.
	ast := parserClass parse: source.
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '`k: _*`'.
	matches := pattern matchAgainst: ast.
	self assert: matches size equals: 2
]

{ #category : #'tests-list matching-non greedy' }
GrammarTest >> testCollectionAllNonGreedy [
	"Non greedy matching is being rewritten"

	| source ast pattern matches |
	source := 'Grammar : "a" ; '.
	ast := parserClass parse: source.
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '`k:_*?`'.
	matches := pattern matchAgainst: ast.
	"Should be 3 or 4, atm it only matches from the top, because of the states"
	self assert: matches size equals: 3
]

{ #category : #'tests-list matching' }
GrammarTest >> testCollectionOneGreedy [
	| source ast pattern matches |
	source := 'Grammar : "a" ; '.
	ast := parserClass parse: source.
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '`k:GrammarwareProductionRuleTNode*`'.
	matches := pattern matchAgainst: ast.
	self assert: matches size equals: 1
]

{ #category : #'tests-list matching-non greedy' }
GrammarTest >> testCollectionOneNonGreedy [
	"Non greedy matching is being rewritten"

	| source ast pattern matches |
	source := 'Grammar : "a" ; '.
	ast := parserClass parse: source.
	pattern := RfgSyntacticPattern parserClass: parserClass patternString: '`k:GrammarwareProductionRuleTNode*?`'.
	matches := pattern matchAgainst: ast.
	self assert: matches size equals: 1
]

{ #category : #'tests-extract inline' }
GrammarTest >> testExtract [
	"TODO"
	self assert: false
]

{ #category : #'tests-extract inline' }
GrammarTest >> testInline [
	"TODO"

	| ast prod all allButToInline callers |
	"TODO: Modify to use inputs in patterns"
	ast := parserClass
		parse:
'Grammar
	: A ToInline "c"
	| A "c" ;
	
A
	: "a" ;

ToInline
	: "b" ;'.
	prod := (RfgSyntacticPattern
		parserClass: parserClass
		patternString: 'ToInline : `alts:_+` ;') matchAgainst: ast.
	all := (RfgSyntacticPattern
		parserClass: parserClass
		patternString: '`prodName` : `rhs` ;') matchAgainst: ast.
	"TODO: some filtering to get a match per source interval"
	allButToInline := all
		reject: [ :each | (each context atNamed: 'prodName') source = 'ToInline' ].
	allButToInline
		collect:
			[ :each | 
			(RfgSyntacticPattern
				parserClass: parserClass
				patternString: '`alts:_+`')
				matchAgainst: (each context atNamed: 'rhs') ].
	self assert: false
]

{ #category : #'tests-list matching' }
GrammarTest >> testMultiplePipeSeperatedLists [
	| pattern matches |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '`a: GrammarwareAlternateTNode ("|" GrammarwareAlternateTNode)*`'.
	pattern getAbstractMatches.
	matches := pattern matchAgainstSource: 
'A
	: B C "a"
	| B "a" ;
	
B
	: "b" ;

C
	: "c" ;'.
	self assert: matches size equals: 3
]

{ #category : #'tests-list matching' }
GrammarTest >> testPipeSeperatedList [
	| pattern matches |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '`a: GrammarwareAlternateTNode ("|" GrammarwareAlternateTNode)*`'.
	pattern getAbstractMatches.
	matches := pattern matchAgainstSource: 
'A
	: B C "a"
	| B "a" ;'.
	self assert: matches size equals: 1
]

{ #category : #'tests-list matching' }
GrammarTest >> testPipeSeperatedListEmptyTail [
	| pattern matches |
	pattern := RfgSyntacticPattern
		parserClass: parserClass
		patternString: '`a: GrammarwareAlternateTNode ("|" GrammarwareAlternateTNode)*`'.
	pattern getAbstractMatches.
	matches := pattern matchAgainstSource: 
'B
	: "b" ;

C
	: "c" ;'.
	self assert: matches size equals: 2
]

{ #category : #'tests-extract inline' }
GrammarTest >> testSimpleInline [
	"Unfinished test"

	| ast rules transform engine toinline others alts uses use k |
	ast := parserClass
		parse:
			'Grammar
	: A ToInline "c"
	| A "c" ;

A
	: "a" ;

ToInline
	: "b" ;'.
	rules := (RfgSyntacticPattern
		parserClass: parserClass
		patternString:
			'`prodname: GrammarwareSymbolTNode` : `alts: GrammarwareAlternateTNode ("|" GrammarwareAlternateTNode)*` ;')
		matchAgainst: ast.
	toinline := (rules
		select: [ :each | (each context atNamed: 'prodname') source = 'ToInline' ])
		asOrderedCollection first context atNamed: 'alts'.
	others := rules
		reject: [ :each | (each context atNamed: 'prodname') source = 'ToInline' ].
	alts := others collect: [ :each | each context atNamed: 'alts' ].
	uses := (RfgSyntacticPattern
		parserClass: parserClass
		patternString: 'ToInline') matchAgainst: ast.
	use := uses
		select: [ :each | each instanceTree isKindOf: GrammarwareAnnotatedTermTNode ].
	transform := RfgStringTransformPattern
		parserClass: parserClass
		patternString: '`alts`'.
	transform matches: uses.
	k := toinline keyAtIndex: 2.
	transform
		contextAsInput: (RfgContext newFromKey: k andValue: (toinline at: k)).
	engine := RfgTransformEngine
		transforms: (OrderedCollection with: transform)
		ast: ast.
	engine rewrite.
	self assert: false
]
