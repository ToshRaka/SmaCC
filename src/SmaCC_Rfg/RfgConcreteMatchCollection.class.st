Class {
	#name : #RfgConcreteMatchCollection,
	#superclass : #Set,
	#category : #'SmaCC_Rfg-Matching'
}

{ #category : #rewriting }
RfgConcreteMatchCollection >> annotateWith: aRfgStringTransform [
	self do: [ :match | match annotateWith: aRfgStringTransform copy ]
]

{ #category : #enumerating }
RfgConcreteMatchCollection >> collectPattern: aRfgSyntacticPattern [
	^ self flatCollect: [ :each | aRfgSyntacticPattern matchAgainst: each instanceTree ] as: self class
]

{ #category : #enumerating }
RfgConcreteMatchCollection >> intersection: aRfgConcreteMatchCollection [
	self shouldBeImplemented
]

{ #category : #removing }
RfgConcreteMatchCollection >> purgeDuplicates [
	| duplicates |
	duplicates := self class new.
	self asOrderedCollection
		combinations: 2
		atATimeDo: [ :pair | 
			((duplicates includes: pair first) or: [ duplicates includes: pair second])
				ifFalse: [ (pair first instanceTree = pair second instanceTree 
					and: [ pair first context isDuplicateWith: pair second context ])
						ifTrue: [ duplicates add: pair second ] ] ].
	^ self \ duplicates
]

{ #category : #enumerating }
RfgConcreteMatchCollection >> rejectPattern: aRfgSyntacticPattern [
	^ self select: [ :each | (aRfgSyntacticPattern matchAgainst: each instanceTree) isEmpty ]
]

{ #category : #enumerating }
RfgConcreteMatchCollection >> selectPattern: aRfgSyntacticPattern [
	^ self select: [ :each | (aRfgSyntacticPattern matchAgainst: each instanceTree) isNotEmpty ]
]

{ #category : #enumerating }
RfgConcreteMatchCollection >> union: aRfgConcreteMatchCollection [
	self shouldBeImplemented
]

{ #category : #enumerating }
RfgConcreteMatchCollection >> xor: aRfgConcreteMatchCollection [
	self shouldBeImplemented
]
