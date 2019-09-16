Class {
	#name : #GrammarwareFileTNodeVisitor,
	#superclass : #SmaCCParseNodeVisitor,
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitAlternate: anAlternate [
	^ self visitFile: anAlternate
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitAnnotateTokens: anAnnotateTokens [
	^ self visitFile: anAnnotateTokens
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitAnnotatedTerm: anAnnotatedTerm [
	^ self visitFile: anAnnotatedTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitAnyCharacter: anAnyCharacter [
	^ self visitFile: anAnyCharacter
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitAttributesLine: anAttributesLine [
	^ self visitFile: anAttributesLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitBackslashCharacter: aBackslashCharacter [
	^ self visitFile: aBackslashCharacter
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitCharacter: aCharacter [
	^ self visitFile: aCharacter
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitCharacterBlock: aCharacterBlock [
	^ self visitFile: aCharacterBlock
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitClassAlternate: aClassAlternate [
	^ self visitFile: aClassAlternate
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitCodeAlternate: aCodeAlternate [
	^ self visitFile: aCodeAlternate
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitDefaultClassAlternate: aDefaultClassAlternate [
	^ self visitFile: aDefaultClassAlternate
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitDirectiveLine: aDirectiveLine [
	^ self visitFile: aDirectiveLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitError: anError [
	^ self visitFile: anError
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitExcludeStatesLine: anExcludeStatesLine [
	^ self visitFile: anExcludeStatesLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitFile: aFile [
	^ self visitSmaCCParseNode: aFile
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitGLR: aGLR [
	^ self visitFile: aGLR
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitGroupRegexTerm: aGroupRegexTerm [
	^ self visitFile: aGroupRegexTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitGroupTerm: aGroupTerm [
	^ self visitFile: aGroupTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitIdMethodLine: anIdMethodLine [
	^ self visitFile: anIdMethodLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitIgnoreCase: anIgnoreCase [
	^ self visitFile: anIgnoreCase
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitIgnoredVariables: anIgnoredVariables [
	^ self visitFile: anIgnoredVariables
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitKeyword: aKeyword [
	^ self visitFile: aKeyword
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitKleenePlusRegexTerm: aKleenePlusRegexTerm [
	^ self visitFile: aKleenePlusRegexTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitKleenePlusTerm: aKleenePlusTerm [
	^ self visitFile: aKleenePlusTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitKleeneStarRegexTerm: aKleeneStarRegexTerm [
	^ self visitFile: aKleeneStarRegexTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitKleeneStarTerm: aKleeneStarTerm [
	^ self visitFile: aKleeneStarTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitLeftLine: aLeftLine [
	^ self visitFile: aLeftLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitNamedKleenePlusTerm: aNamedKleenePlusTerm [
	^ self visitFile: aNamedKleenePlusTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitNamedKleeneStarTerm: aNamedKleeneStarTerm [
	^ self visitFile: aNamedKleeneStarTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitNamedOptionalTerm: aNamedOptionalTerm [
	^ self visitFile: aNamedOptionalTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitNamedTerm: aNamedTerm [
	^ self visitFile: aNamedTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitNonAssociativeLine: aNonAssociativeLine [
	^ self visitFile: aNonAssociativeLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitNonTerminal: aNonTerminal [
	^ self visitFile: aNonTerminal
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitOptionalGroupTerm: anOptionalGroupTerm [
	^ self visitFile: anOptionalGroupTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitOptionalRegexTerm: anOptionalRegexTerm [
	^ self visitFile: anOptionalRegexTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitOptionalTerm: anOptionalTerm [
	^ self visitFile: anOptionalTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitOrRegex: anOrRegex [
	^ self visitFile: anOrRegex
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitPrefixLine: aPrefixLine [
	^ self visitFile: aPrefixLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitPrefixedRegexRule: aPrefixedRegexRule [
	^ self visitFile: aPrefixedRegexRule
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitProductionRule: aProductionRule [
	^ self visitFile: aProductionRule
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitRegexRule: aRegexRule [
	^ self visitFile: aRegexRule
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitRepeatRegexTerm: aRepeatRegexTerm [
	^ self visitFile: aRepeatRegexTerm
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitRightHandSide: aRightHandSide [
	^ self visitFile: aRightHandSide
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitRightLine: aRightLine [
	^ self visitFile: aRightLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitRootClassLine: aRootClassLine [
	^ self visitFile: aRootClassLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitSequenceRegex: aSequenceRegex [
	^ self visitFile: aSequenceRegex
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitStartLine: aStartLine [
	^ self visitFile: aStartLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitStatesLine: aStatesLine [
	^ self visitFile: aStatesLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitSuffixLine: aSuffixLine [
	^ self visitFile: aSuffixLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitSuperclassLine: aSuperclassLine [
	^ self visitFile: aSuperclassLine
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitSymbol: aSymbol [
	^ self visitFile: aSymbol
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitTerms: aTerms [
	^ self visitFile: aTerms
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitToken: aToken [
	^ self visitFile: aToken
]

{ #category : #generated }
GrammarwareFileTNodeVisitor >> visitUnicode: anUnicode [
	^ self visitFile: anUnicode
]
