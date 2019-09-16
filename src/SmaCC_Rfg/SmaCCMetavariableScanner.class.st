Class {
	#name : #SmaCCMetavariableScanner,
	#superclass : #SmaCCScanner,
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
SmaCCMetavariableScanner class >> states [
	^ #(#default)
]

{ #category : #generated }
SmaCCMetavariableScanner >> emptySymbolTokenId [
	^ 25
]

{ #category : #generated }
SmaCCMetavariableScanner >> errorTokenId [
	^ 26
]

{ #category : #generated }
SmaCCMetavariableScanner >> scanForToken [
	self step.
	currentCharacter == $"
		ifTrue:
			[ ^ self scanForTokenX4 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	^ self scanForTokenX8
]

{ #category : #generated }
SmaCCMetavariableScanner >> scanForTokenX1 [
	self step.
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter between: $a and: $z ])
		ifTrue: [ [ self step.
			currentCharacter == $>
				ifTrue: [ ^ self recordAndReportMatch: #(13) ].
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SmaCCMetavariableScanner >> scanForTokenX2 [
	[ self recordMatch: #(12).
	self step.
	(currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
SmaCCMetavariableScanner >> scanForTokenX3 [
	[ self recordMatch: #(11).
	self step.
	(currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
SmaCCMetavariableScanner >> scanForTokenX4 [
	self step.
	currentCharacter ~~ $"
		ifTrue: [ [ self step.
			currentCharacter == $"
				ifTrue: [ ^ self recordAndReportMatch: #(14) ].
			true ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SmaCCMetavariableScanner >> scanForTokenX5 [
	self recordMatch: #(5).
	self step.
	currentCharacter == $?
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	^ self reportLastMatch
]

{ #category : #generated }
SmaCCMetavariableScanner >> scanForTokenX6 [
	self recordMatch: #(3).
	self step.
	currentCharacter == $?
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	^ self reportLastMatch
]

{ #category : #generated }
SmaCCMetavariableScanner >> scanForTokenX7 [
	[ self recordMatch: #(15).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ] ] whileTrue
]

{ #category : #generated }
SmaCCMetavariableScanner >> scanForTokenX8 [
	currentCharacter == $*
		ifTrue:
			[ ^ self scanForTokenX6 ].
	currentCharacter == $+
		ifTrue:
			[ ^ self scanForTokenX5 ].
	currentCharacter == $:
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter == $<
		ifTrue:
			[ ^ self scanForTokenX1 ].
	currentCharacter == $?
		ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	currentCharacter == $_
		ifTrue: [ ^ self recordAndReportMatch: #(9) ].
	currentCharacter == $|
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	(currentCharacter between: $A and: $Z)
		ifTrue:
			[ ^ self scanForTokenX3 ].
	(currentCharacter between: $a and: $z)
		ifTrue:
			[ ^ self scanForTokenX2 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue:
			[ self scanForTokenX7 ].
	^ self reportLastMatch
]

{ #category : #generated }
SmaCCMetavariableScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil nil nil #whitespace)
]
