Class {
	#name : #ListMatchCommaSeparatedListNode,
	#superclass : #ListMatchProgramNode,
	#instVars : [
		'elems',
		'commaTokens'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
ListMatchCommaSeparatedListNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitCommaSeparatedList: self
]

{ #category : #generated }
ListMatchCommaSeparatedListNode >> commaTokens [
	^ commaTokens
]

{ #category : #generated }
ListMatchCommaSeparatedListNode >> commaTokens: anOrderedCollection [
	commaTokens := anOrderedCollection
]

{ #category : #generated }
ListMatchCommaSeparatedListNode >> compositeNodeVariables [
	^ #(#elems)
]

{ #category : #generated }
ListMatchCommaSeparatedListNode >> compositeTokenVariables [
	^ #(#commaTokens)
]

{ #category : #generated }
ListMatchCommaSeparatedListNode >> elems [
	^ elems
]

{ #category : #generated }
ListMatchCommaSeparatedListNode >> elems: anOrderedCollection [
	self setParents: self elems to: nil.
	elems := anOrderedCollection.
	self setParents: self elems to: self
]

{ #category : #'generated-initialize-release' }
ListMatchCommaSeparatedListNode >> initialize [
	super initialize.
	elems := OrderedCollection new: 2.
	commaTokens := OrderedCollection new: 2.
]
