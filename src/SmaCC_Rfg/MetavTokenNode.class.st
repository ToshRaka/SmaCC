Class {
	#name : #MetavTokenNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'tokenName'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavTokenNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitToken: self
]

{ #category : #generated }
MetavTokenNode >> tokenName [
	^ tokenName
]

{ #category : #generated }
MetavTokenNode >> tokenName: aSmaCCToken [
	tokenName := aSmaCCToken
]

{ #category : #generated }
MetavTokenNode >> tokenVariables [
	^ #(#tokenName)
]
