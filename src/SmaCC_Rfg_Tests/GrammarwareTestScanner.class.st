Class {
	#name : #GrammarwareTestScanner,
	#superclass : #SmaCCFGLRScanner,
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #'generated-initialization' }
GrammarwareTestScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(30 'annotate_tokens' #(26 #(#directives))) #(30 'attributes' #(15 #(#directives))) #(30 'error' #(8 #(#default #directives #parser #scanner))) #(30 'excludes' #(12 #(#directives))) #(30 'glr' #(23 #(#directives))) #(30 'hierarchy' #(14 #(#directives))) #(30 'id' #(21 #(#directives))) #(30 'ignore_variables' #(25 #(#directives))) #(30 'ignorecase' #(24 #(#directives))) #(30 'left' #(18 #(#directives))) #(30 'nonassoc' #(20 #(#directives))) #(30 'prefix' #(16 #(#directives))) #(30 'right' #(19 #(#directives))) #(30 'root' #(13 #(#directives))) #(30 'start' #(22 #(#directives))) #(30 'states' #(11 #(#directives))) #(30 'suffix' #(17 #(#directives))) #(30 'unicode' #(27 #(#directives))))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
GrammarwareTestScanner class >> patternBegin [
	^ '`'
]

{ #category : #generated }
GrammarwareTestScanner class >> patternEnd [
	^ '`'
]

{ #category : #generated }
GrammarwareTestScanner class >> states [
	^ #(#default #scanner #directives #parser)
]

{ #category : #generated }
GrammarwareTestScanner >> classLeftId [
	^ 43
]

{ #category : #generated }
GrammarwareTestScanner >> classRightId [
	^ 44
]

{ #category : #generated }
GrammarwareTestScanner >> codeId [
	^ 33
]

{ #category : #generated }
GrammarwareTestScanner >> directiveId [
	^ 36
]

{ #category : #generated }
GrammarwareTestScanner >> emptySymbolTokenId [
	^ 101
]

{ #category : #generated }
GrammarwareTestScanner >> errorTokenId [
	^ 102
]

{ #category : #generated }
GrammarwareTestScanner >> keywordId [
	^ 31
]

{ #category : #generated }
GrammarwareTestScanner >> productionId [
	^ 35
]

{ #category : #generated }
GrammarwareTestScanner >> scan1 [
	self step.
	currentCharacter ~~ $"
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan10 [
	[ self step.
	currentCharacter == $`
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	true ] whileTrue
]

{ #category : #generated }
GrammarwareTestScanner >> scan11 [
	self step.
	currentCharacter == Character newPage
		ifTrue: [ ^ self scan11X5 ].
	currentCharacter == $"
		ifTrue: [ ^ self scan11X11 ].
	currentCharacter == $#
		ifTrue: [ ^ self scan11X2 ].
	currentCharacter == $%
		ifTrue: [ ^ self recordAndReportMatch: #(36) ].
	currentCharacter == $'
		ifTrue: [ ^ self scan11X7 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(2 41) ].
	currentCharacter == $*
		ifTrue: [ ^ self recordAndReportMatch: #(3 41) ].
	currentCharacter == $+
		ifTrue: [ ^ self recordAndReportMatch: #(4 41) ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(42) ].
	currentCharacter == $/
		ifTrue: [ ^ self scan11X10 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan7 ].
	^ self scan11X12
]

{ #category : #generated }
GrammarwareTestScanner >> scan11X1 [
	self step.
	currentCharacter == $c
		ifTrue: [ self step.
			(currentCharacter between: $A and: $Z)
				ifTrue: [ ^ self recordAndReportMatch: #(38) ].
			^ self reportLastMatch ].
	currentCharacter == $x
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ self recordMatch: #(38).
					self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self recordMatch: #(38).
							self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ self recordMatch: #(38).
									self step.
									(currentCharacter isDigit
										or: [ (currentCharacter between: $A and: $F)
												or: [ currentCharacter between: $a and: $f ] ])
										ifTrue: [ ^ self recordAndReportMatch: #(38) ] ] ] ].
			^ self reportLastMatch ].
	^ self recordAndReportMatch: #(38)
]

{ #category : #generated }
GrammarwareTestScanner >> scan11X10 [
	self recordMatch: #(41).
	self step.
	currentCharacter == $*
		ifTrue: [ ^ self scan6 ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan11X11 [
	self recordMatch: #(41).
	self step.
	currentCharacter ~~ $"
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan11X12 [
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(37 41) ].
	currentCharacter == $<
		ifTrue: [ ^ self scan8 ].
	currentCharacter == $?
		ifTrue: [ ^ self recordAndReportMatch: #(5 41) ].
	currentCharacter == $[
		ifTrue: [ ^ self scan11X3 ].
	currentCharacter == $\
		ifTrue: [ ^ self scan11X1 ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(7 41) ].
	currentCharacter == $`
		ifTrue: [ ^ self scan11X9 ].
	currentCharacter == ${
		ifTrue: [ ^ self scan11X6 ].
	currentCharacter == $|
		ifTrue: [ ^ self recordAndReportMatch: #(9 41) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue: [ ^ self scan11X8 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan11X4 ].
	^ self recordAndReportMatch: #(41)
]

{ #category : #generated }
GrammarwareTestScanner >> scan11X2 [
	self recordMatch: #(32 41).
	self step.
	(currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ currentCharacter >= (Character value: 14) ] ])
		ifTrue: [ [ self recordMatch: #(32).
			self step.
			currentCharacter <= Character tab
				or: [ (currentCharacter between: Character pageUp and: Character newPage)
						or: [ currentCharacter >= (Character value: 14) ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan11X3 [
	self recordMatch: #(6).
	self step.
	currentCharacter == $\
		ifTrue: [ ^ self scan13 ].
	(currentCharacter <= $[ or: [ currentCharacter >= $^ ])
		ifTrue: [ ^ self scan12 ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan11X4 [
	self recordMatch: #(30 41).
	self step.
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(30).
			self step.
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan11X5 [
	self recordMatch: #(28 41).
	self step.
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue: [ [ self recordMatch: #(28).
			self step.
			currentCharacter isSeparator
				or: [ currentCharacter == Character pageUp ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan11X6 [
	self recordMatch: #(33).
	self step.
	currentCharacter == $,
		ifTrue: [ ^ self scan14 ].
	currentCharacter isDigit
		ifTrue: [ [ self step.
			currentCharacter == $,
				ifTrue: [ ^ self scan14 ].
			currentCharacter isDigit ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan11X7 [
	self recordMatch: #(41).
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan4 ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan11X8 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan11X9 [
	self recordMatch: #(41).
	self step.
	currentCharacter ~~ $`
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan12 [
	[ self step.
	currentCharacter == $\
		ifTrue: [ ^ self scan13 ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(39) ].
	true ] whileTrue
]

{ #category : #generated }
GrammarwareTestScanner >> scan13 [
	self step.
	currentCharacter == $c
		ifTrue: [ self step.
			(currentCharacter between: $A and: $Z)
				ifTrue: [ ^ self scan12 ].
			^ self reportLastMatch ].
	currentCharacter == $x
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ ^ self scan12 ].
			^ self reportLastMatch ].
	^ self scan12
]

{ #category : #generated }
GrammarwareTestScanner >> scan14 [
	[ self step.
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(40) ].
	currentCharacter isDigit ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan2 [
	[ self step.
	currentCharacter == $"
		ifTrue: [ self recordMatch: #(31).
			self step.
			currentCharacter == $"
				ifTrue: [ ^ self scan1 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GrammarwareTestScanner >> scan3 [
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan4 ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan4 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ ^ self recordAndReportMatch: #(34) ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan5 [
	self step.
	currentCharacter == $*
		ifTrue: [ ^ self scan6 ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan6 [
	[ self step.
	currentCharacter == $*
		ifTrue: [ [ self step.
			currentCharacter == $* ] whileTrue.
			currentCharacter == $/
				ifTrue: [ ^ self recordAndReportMatch: #(32) ].
			^ self scan6 ].
	true ] whileTrue
]

{ #category : #generated }
GrammarwareTestScanner >> scan7 [
	self recordMatch: #(35).
	self step.
	currentCharacter == $:
		ifTrue: [ self step.
			currentCharacter == $=
				ifTrue: [ ^ self recordAndReportMatch: #(35) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan8 [
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self step.
			currentCharacter == $>
				ifTrue: [ ^ self recordAndReportMatch: #(29) ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scan9 [
	self step.
	currentCharacter ~~ $`
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scanForToken [
	scope == #parser
		ifTrue:
			[ ^ self scanForTokenX1 ].
	scope == #scanner
		ifTrue: [ ^ self scan11 ].
	(#(#default #directives) includes: scope)
		ifTrue: [ self step.
			currentCharacter == $"
				ifTrue: [ ^ self scan1 ].
			currentCharacter == $#
				ifTrue:
					[ ^ self scanForTokenX2 ].
			currentCharacter == $%
				ifTrue: [ ^ self recordAndReportMatch: #(36) ].
			currentCharacter == $'
				ifTrue: [ ^ self scan3 ].
			currentCharacter == $(
				ifTrue: [ ^ self recordAndReportMatch: #(1) ].
			currentCharacter == $)
				ifTrue: [ ^ self recordAndReportMatch: #(2) ].
			currentCharacter == $*
				ifTrue: [ ^ self recordAndReportMatch: #(3) ].
			currentCharacter == $+
				ifTrue: [ ^ self recordAndReportMatch: #(4) ].
			currentCharacter == $/
				ifTrue: [ ^ self scan5 ].
			currentCharacter == $:
				ifTrue: [ ^ self scan7 ].
			currentCharacter == $;
				ifTrue: [ ^ self recordAndReportMatch: #(37) ].
			currentCharacter == $<
				ifTrue: [ ^ self scan8 ].
			currentCharacter == $?
				ifTrue: [ ^ self recordAndReportMatch: #(5) ].
			currentCharacter == $[
				ifTrue: [ ^ self recordAndReportMatch: #(6) ].
			currentCharacter == $]
				ifTrue: [ ^ self recordAndReportMatch: #(7) ].
			currentCharacter == $`
				ifTrue: [ ^ self scan9 ].
			currentCharacter == ${
				ifTrue: [ ^ self recordAndReportMatch: #(33) ].
			currentCharacter == $|
				ifTrue: [ ^ self recordAndReportMatch: #(9) ].
			(currentCharacter isSeparator
				or: [ currentCharacter == Character pageUp ])
				ifTrue:
					[ ^ self scanForTokenX3 ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue:
					[ self scanForTokenX4 ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self scan1 ].
	currentCharacter == $#
		ifTrue:
			[ ^ self scanForTokenX1X1 ].
	currentCharacter == $%
		ifTrue: [ ^ self recordAndReportMatch: #(36) ].
	currentCharacter == $'
		ifTrue: [ ^ self scan3 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $*
		ifTrue: [ ^ self recordAndReportMatch: #(3) ].
	currentCharacter == $+
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter == $/
		ifTrue: [ ^ self scan5 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan7 ].
	^ self scanForTokenX1X6
]

{ #category : #generated }
GrammarwareTestScanner >> scanForTokenX1X1 [
	[ self recordMatch: #(32).
	self step.
	currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ currentCharacter >= (Character value: 14) ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scanForTokenX1X2 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scanForTokenX1X3 [
	self recordMatch: #(33).
	self step.
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(43) ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scanForTokenX1X4 [
	[ self recordMatch: #(30).
	self step.
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue
]

{ #category : #generated }
GrammarwareTestScanner >> scanForTokenX1X5 [
	self step.
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(44) ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scanForTokenX1X6 [
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(37) ].
	currentCharacter == $<
		ifTrue: [ ^ self scan8 ].
	currentCharacter == $?
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter == $`
		ifTrue: [ ^ self scan9 ].
	currentCharacter == ${
		ifTrue:
			[ ^ self scanForTokenX1X3 ].
	currentCharacter == $|
		ifTrue: [ ^ self recordAndReportMatch: #(9) ].
	currentCharacter == $}
		ifTrue:
			[ ^ self scanForTokenX1X5 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue:
			[ ^ self scanForTokenX1X2 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue:
			[ self scanForTokenX1X4 ].
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scanForTokenX2 [
	[ self recordMatch: #(32).
	self step.
	currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ currentCharacter >= (Character value: 14) ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scanForTokenX3 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GrammarwareTestScanner >> scanForTokenX4 [
	[ self recordMatch: #(30).
	self step.
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue
]

{ #category : #generated }
GrammarwareTestScanner >> semicolonId [
	^ 37
]

{ #category : #generated }
GrammarwareTestScanner >> symbolnameId [
	^ 30
]

{ #category : #generated }
GrammarwareTestScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil #patternToken nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #whitespace nil nil nil #comment)
]

{ #category : #generated }
GrammarwareTestScanner >> tokennameId [
	^ 29
]

{ #category : #generated }
GrammarwareTestScanner >> variablenameId [
	^ 34
]
