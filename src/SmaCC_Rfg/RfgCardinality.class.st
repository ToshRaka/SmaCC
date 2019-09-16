Class {
	#name : #RfgCardinality,
	#superclass : #Object,
	#instVars : [
		'min',
		'max',
		'current',
		'greedy'
	],
	#category : #'SmaCC_Rfg-Types'
}

{ #category : #comparing }
RfgCardinality >> = aRfgCardinality [
	^ self class = aRfgCardinality class
		and: [ self min = aRfgCardinality min 
			and: [ self max = aRfgCardinality max
				and: [ self current = aRfgCardinality current ] ] ]
]

{ #category : #accessing }
RfgCardinality >> beGreedy [
	greedy := true
]

{ #category : #accessing }
RfgCardinality >> beNonGreedy [
	greedy := false
]

{ #category : #accessing }
RfgCardinality >> beOption [
	min := 0.
	max := 1
]

{ #category : #accessing }
RfgCardinality >> bePlus [
	min := 1.
	max := nil
]

{ #category : #accessing }
RfgCardinality >> beStar [
	min := 0.
	max := nil
]

{ #category : #accessing }
RfgCardinality >> current [
	^ current
]

{ #category : #accessing }
RfgCardinality >> current: anObject [
	current := anObject
]

{ #category : #initialization }
RfgCardinality >> initialize [
	super initialize.
	min := 1.
	max := 1.
	current := nil.
	greedy := true
]

{ #category : #accessing }
RfgCardinality >> isGreedy [ 
	^ greedy
]

{ #category : #accessing }
RfgCardinality >> isOption [
	^ min = 0 and: [ max = 1 ]
]

{ #category : #accessing }
RfgCardinality >> isPlus [
	^ min = 1 and: [ max isNil ]
]

{ #category : #accessing }
RfgCardinality >> isStar [
	^ min = 0 and: [ max isNil ]
]

{ #category : #comparing }
RfgCardinality >> matchSize: anInteger [
	"Current is not reset between node matches, preventing unrelated matches to work."
	current ifNil: [ current := anInteger. ^ true ].
	^ current = anInteger 
]

{ #category : #accessing }
RfgCardinality >> max [
	^ max
]

{ #category : #accessing }
RfgCardinality >> max: anObject [
	max := anObject
]

{ #category : #accessing }
RfgCardinality >> min [
	^ min
]

{ #category : #accessing }
RfgCardinality >> min: anObject [
	min := anObject
]

{ #category : #initialization }
RfgCardinality >> reset [
	current := nil
]
