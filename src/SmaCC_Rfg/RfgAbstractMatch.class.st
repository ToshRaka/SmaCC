Class {
	#name : #RfgAbstractMatch,
	#superclass : #RfgMatch,
	#instVars : [
		'concreteMatches'
	],
	#category : #'SmaCC_Rfg-Matching'
}

{ #category : #comparing }
RfgAbstractMatch >> = aRfgAbstractMatch [
	^ self class = aRfgAbstractMatch class
		and: [ self instanceTree = aRfgAbstractMatch instanceTree 
			and: [ self concreteMatches = aRfgAbstractMatch concreteMatches ] ]
]

{ #category : #accessing }
RfgAbstractMatch >> concreteMatches [
	^ concreteMatches
]

{ #category : #initialization }
RfgAbstractMatch >> initialize [
	super initialize.
	concreteMatches := RfgConcreteMatchCollection new.
]

{ #category : #matching }
RfgAbstractMatch >> matchAgainst: aSmaCCParseNode [
	| newContext |
	newContext := RfgContext new.
	(instanceTree syntacticMatch: aSmaCCParseNode inContext: newContext)
		ifTrue: [ concreteMatches add: (RfgConcreteMatch with: aSmaCCParseNode andContext: newContext).
			^ true ].
	^ false
]

{ #category : #matching }
RfgAbstractMatch >> resetMatches [
	concreteMatches removeAll
]
