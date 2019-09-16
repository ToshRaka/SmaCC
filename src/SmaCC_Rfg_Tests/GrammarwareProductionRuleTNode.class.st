Class {
	#name : #GrammarwareProductionRuleTNode,
	#superclass : #GrammarwareFileTNode,
	#instVars : [
		'lhs',
		'productionToken',
		'rhs',
		'semicolonToken'
	],
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
GrammarwareProductionRuleTNode >> acceptVisitor: aFileVisitor [
	^ aFileVisitor visitProductionRule: self
]

{ #category : #generated }
GrammarwareProductionRuleTNode >> lhs [
	^ lhs
]

{ #category : #generated }
GrammarwareProductionRuleTNode >> lhs: aGrammarwareSymbolTNode [
	self lhs notNil
		ifTrue: [ self lhs parent: nil ].
	lhs := aGrammarwareSymbolTNode.
	self lhs notNil
		ifTrue: [ self lhs parent: self ]
]

{ #category : #generated }
GrammarwareProductionRuleTNode >> nodeVariables [
	^ #(#lhs #rhs)
]

{ #category : #generated }
GrammarwareProductionRuleTNode >> productionToken [
	^ productionToken
]

{ #category : #generated }
GrammarwareProductionRuleTNode >> productionToken: aSmaCCToken [
	productionToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareProductionRuleTNode >> rhs [
	^ rhs
]

{ #category : #generated }
GrammarwareProductionRuleTNode >> rhs: aGrammarwareRightHandSideTNode [
	self rhs notNil
		ifTrue: [ self rhs parent: nil ].
	rhs := aGrammarwareRightHandSideTNode.
	self rhs notNil
		ifTrue: [ self rhs parent: self ]
]

{ #category : #generated }
GrammarwareProductionRuleTNode >> semicolonToken [
	^ semicolonToken
]

{ #category : #generated }
GrammarwareProductionRuleTNode >> semicolonToken: aSmaCCToken [
	semicolonToken := aSmaCCToken
]

{ #category : #generated }
GrammarwareProductionRuleTNode >> tokenVariables [
	^ #(#productionToken #semicolonToken)
]
