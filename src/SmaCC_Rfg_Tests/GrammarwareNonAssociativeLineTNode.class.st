Class {
	#name : #GrammarwareNonAssociativeLineTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'nonassocToken',
		'noassocTokenses'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareNonAssociativeLineTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitNonAssociativeLine: self
]

{ #category : #generated }
GrammarwareNonAssociativeLineTNode >> compositeNodeVariables [
	^ #(#noassocTokenses #rules)
]

{ #category : #'generated-initialize-release' }
GrammarwareNonAssociativeLineTNode >> initialize [
	super initialize.
	noassocTokenses := OrderedCollection new: 2.
]

{ #category : #generated }
GrammarwareNonAssociativeLineTNode >> noassocTokenses [
	^ noassocTokenses
]

{ #category : #generated }
GrammarwareNonAssociativeLineTNode >> noassocTokenses: anOrderedCollection [
	self setParents: self noassocTokenses to: nil.
	noassocTokenses := anOrderedCollection.
	self setParents: self noassocTokenses to: self
]

{ #category : #generated }
GrammarwareNonAssociativeLineTNode >> nonassocToken [
	^ nonassocToken
]

{ #category : #generated }
GrammarwareNonAssociativeLineTNode >> nonassocToken: aSmaCCToken [
	nonassocToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareNonAssociativeLineTNode >> tokenVariables [
	^ #(#nonassocToken)
]
