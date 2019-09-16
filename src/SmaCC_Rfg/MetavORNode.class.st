Class {
	#name : #MetavORNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'alternatives',
		'orTokens'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavORNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitOR: self
]

{ #category : #generated }
MetavORNode >> alternatives [
	^ alternatives
]

{ #category : #generated }
MetavORNode >> alternatives: anOrderedCollection [
	self setParents: self alternatives to: nil.
	alternatives := anOrderedCollection.
	self setParents: self alternatives to: self
]

{ #category : #generated }
MetavORNode >> compositeNodeVariables [
	^ #(#alternatives)
]

{ #category : #generated }
MetavORNode >> compositeTokenVariables [
	^ #(#orTokens)
]

{ #category : #'generated-initialize-release' }
MetavORNode >> initialize [
	super initialize.
	alternatives := OrderedCollection new: 2.
	orTokens := OrderedCollection new: 2.
]

{ #category : #generated }
MetavORNode >> orTokens [
	^ orTokens
]

{ #category : #generated }
MetavORNode >> orTokens: anOrderedCollection [
	orTokens := anOrderedCollection
]
