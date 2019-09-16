Class {
	#name : #MetavOptionNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'left',
		'questionMarkToken'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavOptionNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitOption: self
]

{ #category : #generated }
MetavOptionNode >> left [
	^ left
]

{ #category : #generated }
MetavOptionNode >> left: aMetavMetavariableNode [
	self left notNil
		ifTrue: [ self left parent: nil ].
	left := aMetavMetavariableNode.
	self left notNil
		ifTrue: [ self left parent: self ]
]

{ #category : #generated }
MetavOptionNode >> nodeVariables [
	^ #(#left)
]

{ #category : #generated }
MetavOptionNode >> questionMarkToken [
	^ questionMarkToken
]

{ #category : #generated }
MetavOptionNode >> questionMarkToken: aSmaCCToken [
	questionMarkToken := aSmaCCToken
]

{ #category : #generated }
MetavOptionNode >> tokenVariables [
	^ #(#questionMarkToken)
]
