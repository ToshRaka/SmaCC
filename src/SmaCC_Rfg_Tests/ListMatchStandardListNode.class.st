Class {
	#name : #ListMatchStandardListNode,
	#superclass : #ListMatchProgramNode,
	#instVars : [
		'elems'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
ListMatchStandardListNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitStandardList: self
]

{ #category : #generated }
ListMatchStandardListNode >> compositeNodeVariables [
	^ #(#elems)
]

{ #category : #generated }
ListMatchStandardListNode >> elems [
	^ elems
]

{ #category : #generated }
ListMatchStandardListNode >> elems: anOrderedCollection [
	self setParents: self elems to: nil.
	elems := anOrderedCollection.
	self setParents: self elems to: self
]

{ #category : #'generated-initialize-release' }
ListMatchStandardListNode >> initialize [
	super initialize.
	elems := OrderedCollection new: 2.
]
