Class {
	#name : #MetavSymbolNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'symbolName'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavSymbolNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitSymbol: self
]

{ #category : #generated }
MetavSymbolNode >> symbolName [
	^ symbolName
]

{ #category : #generated }
MetavSymbolNode >> symbolName: aSmaCCToken [
	symbolName := aSmaCCToken
]

{ #category : #generated }
MetavSymbolNode >> tokenVariables [
	^ #(#symbolName)
]
