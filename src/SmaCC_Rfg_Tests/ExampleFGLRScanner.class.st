Class {
	#name : #ExampleFGLRScanner,
	#superclass : #SmaCCFGLRScanner,
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
ExampleFGLRScanner class >> patternBegin [
	^ '`'
]

{ #category : #generated }
ExampleFGLRScanner class >> patternEnd [
	^ '`'
]

{ #category : #generated }
ExampleFGLRScanner class >> states [
	^ #(#default)
]

{ #category : #generated }
ExampleFGLRScanner >> emptySymbolTokenId [
	^ 14
]

{ #category : #generated }
ExampleFGLRScanner >> errorTokenId [
	^ 15
]

{ #category : #generated }
ExampleFGLRScanner >> scanForToken [
	self step.
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $*
		ifTrue: [ ^ self recordAndReportMatch: #(3) ].
	currentCharacter == $+
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter == $-
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $/
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $^
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter == $`
		ifTrue: [ [ self step.
			currentCharacter == $`
				ifTrue: [ ^ self recordAndReportMatch: #(10) ].
			true ] whileTrue ].
	currentCharacter isDigit
		ifTrue:
			[ ^ self scanForTokenX1 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue: [ [ self recordMatch: #(9).
			self step.
			currentCharacter isSeparator
				or: [ currentCharacter == Character pageUp ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
ExampleFGLRScanner >> scanForTokenX1 [
	[ self recordMatch: #(8).
	self step.
	currentCharacter == $.
		ifTrue: [ [ self recordMatch: #(8).
			self step.
			currentCharacter isDigit ] whileTrue.
			^ self reportLastMatch ].
	currentCharacter isDigit ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
ExampleFGLRScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil #whitespace #patternToken)
]
