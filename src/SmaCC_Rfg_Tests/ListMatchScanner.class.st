Class {
	#name : #ListMatchScanner,
	#superclass : #SmaCCFGLRScanner,
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
ListMatchScanner class >> patternBegin [
	^ '`'
]

{ #category : #generated }
ListMatchScanner class >> patternEnd [
	^ '`'
]

{ #category : #generated }
ListMatchScanner class >> states [
	^ #(#default)
]

{ #category : #generated }
ListMatchScanner >> emptySymbolTokenId [
	^ 19
]

{ #category : #generated }
ListMatchScanner >> errorTokenId [
	^ 20
]

{ #category : #generated }
ListMatchScanner >> scanForToken [
	self step.
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $`
		ifTrue: [ self step.
			currentCharacter ~~ $`
				ifTrue: [ [ self step.
					currentCharacter == $`
						ifTrue: [ ^ self recordAndReportMatch: #(6) ].
					true ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter isDigit
		ifTrue: [ [ self recordMatch: #(3).
			self step.
			currentCharacter isDigit ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue: [ [ self recordMatch: #(5).
			self step.
			currentCharacter isSeparator
				or: [ currentCharacter == Character pageUp ] ] whileTrue.
			^ self reportLastMatch ].
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter between: $a and: $z ])
		ifTrue: [ [ self recordMatch: #(4).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
ListMatchScanner >> tokenActions [
	^ #(nil nil nil nil #whitespace #patternToken)
]
