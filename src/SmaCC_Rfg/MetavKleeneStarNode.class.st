Class {
	#name : #MetavKleeneStarNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'left',
		'timesToken'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavKleeneStarNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitKleeneStar: self
]

{ #category : #generated }
MetavKleeneStarNode >> left [
	^ left
]

{ #category : #generated }
MetavKleeneStarNode >> left: aMetavMetavariableNode [
	self left notNil
		ifTrue: [ self left parent: nil ].
	left := aMetavMetavariableNode.
	self left notNil
		ifTrue: [ self left parent: self ]
]

{ #category : #generated }
MetavKleeneStarNode >> nodeVariables [
	^ #(#left)
]

{ #category : #generated }
MetavKleeneStarNode >> timesToken [
	^ timesToken
]

{ #category : #generated }
MetavKleeneStarNode >> timesToken: aSmaCCToken [
	timesToken := aSmaCCToken
]

{ #category : #generated }
MetavKleeneStarNode >> tokenVariables [
	^ #(#timesToken)
]
