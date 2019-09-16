Class {
	#name : #MetavDeclarationNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'metavariableName',
		'colonToken',
		'expression'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavDeclarationNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitDeclaration: self
]

{ #category : #generated }
MetavDeclarationNode >> colonToken [
	^ colonToken
]

{ #category : #generated }
MetavDeclarationNode >> colonToken: aSmaCCToken [
	colonToken := aSmaCCToken
]

{ #category : #generated }
MetavDeclarationNode >> expression [
	^ expression
]

{ #category : #generated }
MetavDeclarationNode >> expression: aMetavORNode [
	self expression notNil
		ifTrue: [ self expression parent: nil ].
	expression := aMetavORNode.
	self expression notNil
		ifTrue: [ self expression parent: self ]
]

{ #category : #generated }
MetavDeclarationNode >> metavariableName [
	^ metavariableName
]

{ #category : #generated }
MetavDeclarationNode >> metavariableName: aSmaCCToken [
	metavariableName := aSmaCCToken
]

{ #category : #generated }
MetavDeclarationNode >> nodeVariables [
	^ #(#expression)
]

{ #category : #generated }
MetavDeclarationNode >> tokenVariables [
	^ #(#metavariableName #colonToken)
]
