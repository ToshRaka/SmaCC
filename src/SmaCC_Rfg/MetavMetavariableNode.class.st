Class {
	#name : #MetavMetavariableNode,
	#superclass : #SmaCCParseNode,
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavMetavariableNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitMetavariable: self
]
