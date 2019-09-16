Class {
	#name : #RfgStringTransformPattern,
	#superclass : #RfgPattern,
	#instVars : [
		'matches',
		'cachedString',
		'processed'
	],
	#category : #'SmaCC_Rfg-Matching'
}

{ #category : #initialization }
RfgStringTransformPattern >> initialize [
	super initialize.
	processed := RfgConcreteMatchCollection new.
]

{ #category : #accessing }
RfgStringTransformPattern >> matches [
	^ matches
]

{ #category : #accessing }
RfgStringTransformPattern >> matches: anObject [
	matches := anObject
]

{ #category : #rewriting }
RfgStringTransformPattern >> rewrite: aSmaCCParseNode [
	| stream |
	cachedString ifNotNil: [ ^ cachedString ].
	stream := ReadWriteStream on: ''.
	self rewriteNode: aSmaCCParseNode on: stream. 
	cachedString := stream contents.
	^ cachedString
]

{ #category : #rewriting }
RfgStringTransformPattern >> rewriteMatch: aRfgConcreteMatch in: aSmaCCString with: aRfgTransformationEngine [
	| first last str |
	compiled ifNil: [ self compilePattern ].
"	self halt."
	first := 1.
	last := 0.
	str := nil.
	compiled do: [ :each |
		(each isKindOf: RfgMetavariableNode)
			ifTrue: [ | symbol |
				symbol := aRfgConcreteMatch context atNamed: each identifier.
				last := symbol startPosition.
				first < last
					ifTrue: [ str 
						ifNil: [ aSmaCCString deleteFrom: first to: last - 1 ]
						ifNotNil: [ aSmaCCString replaceFrom: first + 1 to: last - 1 with: str ] ]
					ifFalse: [ str ifNotNil: [ aSmaCCString insert: str at: first ]  ].
				str := nil.
				first := symbol stopPosition.
				aRfgTransformationEngine rewriteNode: symbol ]
			ifFalse: [ str := each ] ].
	last := aRfgConcreteMatch instanceTree stopPosition.
	first < last
		ifTrue: [ str 
			ifNil: [ aSmaCCString deleteFrom: first + 1 to: last ]
			ifNotNil: [ aSmaCCString replaceFrom: first + 1 to: last with: str ] ]
]

{ #category : #rewriting }
RfgStringTransformPattern >> rewriteMatch: aRfgConcreteMatch on: aStream [
	compiled ifNil: [ self compilePattern ].
	compiled do: [ :each |
		(each isKindOf: RfgMetavariableNode)
			ifTrue: [ | symbol |
				symbol := aRfgConcreteMatch context atNamed: each identifier.
				self rewriteNode: symbol on: aStream ]
			ifFalse: [ aStream nextPutAll: each ] ]
]

{ #category : #rewriting }
RfgStringTransformPattern >> rewriteNode: aSmaCCParseNode on: aStream [
	| currentMatches |
	currentMatches := matches
		select: [ :match | aSmaCCParseNode = match instanceTree ].
	currentMatches 
		ifNotEmpty: [ self rewriteMatch: currentMatches asOrderedCollection first on: aStream ]
		ifEmpty: [ (aSmaCCParseNode isKindOf: SmaCCToken)
				ifTrue: [ aStream nextPutAll: aSmaCCParseNode value ]
				ifFalse: [ aSmaCCParseNode sortedNodesAndTokens
						do: [ :child | self rewriteNode: child on: aStream ] ] ]
]
