Class {
	#name : #RfgPattern,
	#superclass : #Object,
	#instVars : [
		'parserClass',
		'patternString',
		'compiled'
	],
	#category : #'SmaCC_Rfg-Matching'
}

{ #category : #'instance-creation' }
RfgPattern class >> parserClass: aClass patternString: aString [
	^ self new 
		parserClass: aClass;
		patternString: aString;
		yourself
	
]

{ #category : #compiling }
RfgPattern >> compilePattern [
	| keyStart keyStop delimBegin delimEnd |
	compiled := OrderedCollection new.
	delimBegin := parserClass scannerClass patternBegin.
	delimEnd := parserClass scannerClass patternEnd.
	keyStop := 1.
	[ keyStop <= patternString size ] 
		whileTrue: [
			keyStart := patternString findAnySubstring: delimBegin startingAt: keyStop.
			(keyStart > patternString size)
				ifTrue: [ 
					(patternString copyFrom: keyStop to: patternString size) 
						ifNotEmpty: [ :str | 
							compiled addLast: str ]. 
							^ compiled ].
			(patternString copyFrom: keyStop to: keyStart-1)
				ifNotEmpty: [ :str | compiled addLast: str ].
			keyStart := keyStart + delimBegin size.
			keyStop := patternString findAnySubstring: delimEnd startingAt: keyStart.
			(patternString copyFrom: keyStart to: keyStop-1)
				ifNotEmpty: [ :str | compiled addLast: (RfgMetavariableNode origin: str) ].
			keyStop := keyStop + delimEnd size
		].
	^ compiled 
]

{ #category : #io }
RfgPattern >> contextAsInput: aRfgContext [
	| newCompiled |
	compiled ifNil: [ self compilePattern ].
	newCompiled := OrderedCollection new.
	compiled
		do: [ :each | 
			| current |
			current := (each isKindOf: RfgMetavariableNode)
				ifTrue: [ aRfgContext sourceAtNamed: each identifier ifAbsent: [ each ] ]
				ifFalse: [ each ].
			(newCompiled isNotEmpty and: [ (newCompiled last isKindOf: String) and: [ current isKindOf: String ] ])
				ifTrue: [ newCompiled addLast: newCompiled removeLast , current ]
				ifFalse: [ newCompiled addLast: current ] ].
	compiled := newCompiled.
	self updatePatternString
]

{ #category : #accessing }
RfgPattern >> parserClass [
	^ parserClass
]

{ #category : #accessing }
RfgPattern >> parserClass: anObject [
	parserClass := anObject
]

{ #category : #accessing }
RfgPattern >> patternString [
	^ patternString
]

{ #category : #accessing }
RfgPattern >> patternString: anObject [
	patternString := anObject
]

{ #category : #compiling }
RfgPattern >> updatePatternString [
	| stream |
	compiled ifNil: [ ^ patternString ].
	stream := ReadWriteStream on: ''.
	compiled
		do: [ :each | 
			stream
				nextPutAll:
					((each isKindOf: RfgMetavariableNode)
						ifTrue: [ parserClass scannerClass patternBegin, each origin, parserClass scannerClass patternEnd ]
						ifFalse: [ each ]) ].
	patternString := stream contents
]
