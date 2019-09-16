Class {
	#name : #MetavWildcardNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'_Token'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavWildcardNode >> _Token [
	^ _Token
]

{ #category : #generated }
MetavWildcardNode >> _Token: aSmaCCToken [
	_Token := aSmaCCToken
]

{ #category : #generated }
MetavWildcardNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitWildcard: self
]

{ #category : #generated }
MetavWildcardNode >> tokenVariables [
	^ #(#_Token)
]
