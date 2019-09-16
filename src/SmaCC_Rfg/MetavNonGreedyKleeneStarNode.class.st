Class {
	#name : #MetavNonGreedyKleeneStarNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'left',
		'timesQuestionMarkToken'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavNonGreedyKleeneStarNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitNonGreedyKleeneStar: self
]

{ #category : #generated }
MetavNonGreedyKleeneStarNode >> left [
	^ left
]

{ #category : #generated }
MetavNonGreedyKleeneStarNode >> left: aMetavMetavariableNode [
	self left notNil
		ifTrue: [ self left parent: nil ].
	left := aMetavMetavariableNode.
	self left notNil
		ifTrue: [ self left parent: self ]
]

{ #category : #generated }
MetavNonGreedyKleeneStarNode >> nodeVariables [
	^ #(#left)
]

{ #category : #generated }
MetavNonGreedyKleeneStarNode >> timesQuestionMarkToken [
	^ timesQuestionMarkToken
]

{ #category : #generated }
MetavNonGreedyKleeneStarNode >> timesQuestionMarkToken: aSmaCCToken [
	timesQuestionMarkToken := aSmaCCToken
]

{ #category : #generated }
MetavNonGreedyKleeneStarNode >> tokenVariables [
	^ #(#timesQuestionMarkToken)
]
