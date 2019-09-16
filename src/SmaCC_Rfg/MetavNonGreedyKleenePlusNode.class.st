Class {
	#name : #MetavNonGreedyKleenePlusNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'left',
		'plusQuestionMarkToken'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavNonGreedyKleenePlusNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitNonGreedyKleenePlus: self
]

{ #category : #generated }
MetavNonGreedyKleenePlusNode >> left [
	^ left
]

{ #category : #generated }
MetavNonGreedyKleenePlusNode >> left: aMetavMetavariableNode [
	self left notNil
		ifTrue: [ self left parent: nil ].
	left := aMetavMetavariableNode.
	self left notNil
		ifTrue: [ self left parent: self ]
]

{ #category : #generated }
MetavNonGreedyKleenePlusNode >> nodeVariables [
	^ #(#left)
]

{ #category : #generated }
MetavNonGreedyKleenePlusNode >> plusQuestionMarkToken [
	^ plusQuestionMarkToken
]

{ #category : #generated }
MetavNonGreedyKleenePlusNode >> plusQuestionMarkToken: aSmaCCToken [
	plusQuestionMarkToken := aSmaCCToken
]

{ #category : #generated }
MetavNonGreedyKleenePlusNode >> tokenVariables [
	^ #(#plusQuestionMarkToken)
]
