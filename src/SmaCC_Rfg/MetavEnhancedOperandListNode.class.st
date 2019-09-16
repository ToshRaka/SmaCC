Class {
	#name : #MetavEnhancedOperandListNode,
	#superclass : #MetavMetavariableNode,
	#instVars : [
		'operands'
	],
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavEnhancedOperandListNode >> acceptVisitor: aMetavariableVisitor [
	^ aMetavariableVisitor visitEnhancedOperandList: self
]

{ #category : #generated }
MetavEnhancedOperandListNode >> compositeNodeVariables [
	^ #(#operands)
]

{ #category : #'generated-initialize-release' }
MetavEnhancedOperandListNode >> initialize [
	super initialize.
	operands := OrderedCollection new: 2.
]

{ #category : #generated }
MetavEnhancedOperandListNode >> operands [
	^ operands
]

{ #category : #generated }
MetavEnhancedOperandListNode >> operands: anOrderedCollection [
	self setParents: self operands to: nil.
	operands := anOrderedCollection.
	self setParents: self operands to: self
]
