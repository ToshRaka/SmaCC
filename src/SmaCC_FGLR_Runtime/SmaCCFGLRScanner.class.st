"
I represent the abstract scanner class for the concrete scanning automaton.

I can tokenize an input string into a stream of tokens.
My subclasses are generated by the SmaCC parser generator tool.

Contrary to a standard LR scanner, my position information is stored in a SmaCCFGLRFiber.
The SmaCCFGLRParser ask me for its current fiber's next token.

Public API and Key Messages
 
Internal Representation and Key Implementation Points.

    Instance Variables
	fiber:		<SmaCCFGLRFiber>
"
Class {
	#name : #SmaCCFGLRScanner,
	#superclass : #SmaCCScanner,
	#instVars : [
		'fiber'
	],
	#category : #'SmaCC_FGLR_Runtime-Core'
}

{ #category : #'as yet unclassified' }
SmaCCFGLRScanner class >> patternBegin [
	^ '`'
]

{ #category : #'as yet unclassified' }
SmaCCFGLRScanner class >> patternEnd [
	^ '`'
]

{ #category : #'default token handling' }
SmaCCFGLRScanner >> comment [
	fiber comments add: (Array with: start + 1 with: matchEnd).
	fiber position: matchEnd.
	^ self whitespace
]

{ #category : #accessing }
SmaCCFGLRScanner >> comments [
	^ fiber comments 
]

{ #category : #accessing }
SmaCCFGLRScanner >> currentState [
	"Should not be used"
]

{ #category : #accessing }
SmaCCFGLRScanner >> fiber: aSmaCCFGLRFiber [
	fiber := aSmaCCFGLRFiber 
]

{ #category : #accessing }
SmaCCFGLRScanner >> patternToken [
	| metav |
	metav := SmaCCMetavariableParser
		parse:
			(outputStream contents
				copyFrom: self class patternBegin size + 1
				to: outputStream contents size - self class patternEnd size).
	outputStream reset.
	^ MetavariableTypeExtractor new extract: metav
]

{ #category : #accessing }
SmaCCFGLRScanner >> position [
	^ fiber position
]

{ #category : #accessing }
SmaCCFGLRScanner >> position: anInteger [
	fiber position: anInteger.
	^ stream position: anInteger

]

{ #category : #private }
SmaCCFGLRScanner >> reportLastMatch [
	"The scanner has found the end of a token and must report it"

	| string action |
	self checkForValidMatch.
	self resetOutputToLastMatch.
	stream position: matchEnd.
	fiber position: matchEnd.
	string := outputStream contents.
	self checkForKeyword: string.
	action := matchActions isSymbol
		ifTrue:
			[ matchActions ]
		ifFalse: [ self tokenActions
				at: matchActions first
				ifAbsent: [ nil ] ].	"This is only necessary to run version 1 parsers on version 2 SmaCC"
	^ action notNil
		ifTrue: [ self perform: action ]
		ifFalse: [ self createTokenFor: string ]
]

{ #category : #private }
SmaCCFGLRScanner >> resetScanner [
	matchActions := nil.
	scope := fiber scope.
	stream position: fiber position.
	start := stream position.
	outputStream reset.
	lastOutputStreamMatchPosition := 0
]

{ #category : #privileged }
SmaCCFGLRScanner >> restoreState: aSmaCCParserState [
	"Should not be used"
]

{ #category : #accessing }
SmaCCFGLRScanner >> scope [
	^ fiber scope
]

{ #category : #accessing }
SmaCCFGLRScanner >> scope: aSymbol [
	fiber scope: aSymbol 
]

{ #category : #accessing }
SmaCCFGLRScanner >> setPosition: anInteger [
	stream position: anInteger.
	fiber position: anInteger
]
