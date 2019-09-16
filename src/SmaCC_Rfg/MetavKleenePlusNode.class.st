Class {
	#name : #MetavKleenePlusNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'left',
		'plusToken'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavKleenePlusNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitKleenePlus: self
]

{ #category : #generated }
MetavKleenePlusNode >> left [
	^ left
]

{ #category : #generated }
MetavKleenePlusNode >> left: aMetavMetavariableNode [
	self left notNil
		ifTrue: [ self left parent: nil ].
	left := aMetavMetavariableNode.
	self left notNil
		ifTrue: [ self left parent: self ]
]

{ #category : #generated }
MetavKleenePlusNode >> nodeVariables [
	^ #(#left)
]

{ #category : #generated }
MetavKleenePlusNode >> plusToken [
	^ plusToken
]

{ #category : #generated }
MetavKleenePlusNode >> plusToken: aSmaCCToken [
	plusToken := aSmaCCToken
]

{ #category : #generated }
MetavKleenePlusNode >> tokenVariables [
	^ #(#plusToken)
]
