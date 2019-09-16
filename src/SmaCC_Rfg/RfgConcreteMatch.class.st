Class {
	#name : #RfgConcreteMatch,
	#superclass : #RfgMatch,
	#instVars : [
		'transform'
	],
	#category : #'SmaCC_Rfg-Matching'
}

{ #category : #comparing }
RfgConcreteMatch >> = aRfgConcreteMatch [
	^ self instanceTree = aRfgConcreteMatch instanceTree
		and: [ self context = aRfgConcreteMatch context ]
]

{ #category : #rewriting }
RfgConcreteMatch >> annotateWith: aRfgStringTransform [
	transform := aRfgStringTransform context: context; yourself
]

{ #category : #comparing }
RfgConcreteMatch >> hash [
	^ instanceTree hash bitXor: context hash
]

{ #category : #accessing }
RfgConcreteMatch >> transform [
	^ transform
]

{ #category : #accessing }
RfgConcreteMatch >> transform: anObject [
	transform := anObject
]
