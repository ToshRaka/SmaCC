Class {
	#name : #MetavEmbeddedNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'metavariableName'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavEmbeddedNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitEmbedded: self
]

{ #category : #generated }
MetavEmbeddedNode >> metavariableName [
	^ metavariableName
]

{ #category : #generated }
MetavEmbeddedNode >> metavariableName: aSmaCCToken [
	metavariableName := aSmaCCToken
]

{ #category : #generated }
MetavEmbeddedNode >> tokenVariables [
	^ #(#metavariableName)
]
