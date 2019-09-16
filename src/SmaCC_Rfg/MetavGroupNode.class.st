Class {
	#name : #MetavGroupNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'leftParenToken',
		'expression',
		'rightParenToken'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavGroupNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitGroup: self
]

{ #category : #generated }
MetavGroupNode >> expression [
	^ expression
]

{ #category : #generated }
MetavGroupNode >> expression: aMetavORNode [
	self expression notNil
		ifTrue: [ self expression parent: nil ].
	expression := aMetavORNode.
	self expression notNil
		ifTrue: [ self expression parent: self ]
]

{ #category : #generated }
MetavGroupNode >> leftParenToken [
	^ leftParenToken
]

{ #category : #generated }
MetavGroupNode >> leftParenToken: aSmaCCToken [
	leftParenToken := aSmaCCToken
]

{ #category : #generated }
MetavGroupNode >> nodeVariables [
	^ #(#expression)
]

{ #category : #generated }
MetavGroupNode >> rightParenToken [
	^ rightParenToken
]

{ #category : #generated }
MetavGroupNode >> rightParenToken: aSmaCCToken [
	rightParenToken := aSmaCCToken
]

{ #category : #generated }
MetavGroupNode >> tokenVariables [
	^ #(#leftParenToken #rightParenToken)
]
