Class {
	#name : #CPPDoWhileStatementNode,
	#superclass : #CPPStatementNode,
	#instVars : [
		'doToken',
		'statement',
		'whileToken',
		'leftParen',
		'condition',
		'rightParen',
		'semicolon'
	],
	#category : #'SmaCC_CPP_Parser'
}

{ #category : #generated }
CPPDoWhileStatementNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitDoWhileStatement: self
]

{ #category : #generated }
CPPDoWhileStatementNode >> condition [
	^ condition
]

{ #category : #generated }
CPPDoWhileStatementNode >> condition: aCPPExpressionNode [
	self condition notNil
		ifTrue: [ self condition parent: nil ].
	condition := aCPPExpressionNode.
	self condition notNil
		ifTrue: [ self condition parent: self ]
]

{ #category : #generated }
CPPDoWhileStatementNode >> doToken [
	^ doToken
]

{ #category : #generated }
CPPDoWhileStatementNode >> doToken: aSmaCCToken [
	doToken := aSmaCCToken
]

{ #category : #generated }
CPPDoWhileStatementNode >> leftParen [
	^ leftParen
]

{ #category : #generated }
CPPDoWhileStatementNode >> leftParen: aSmaCCToken [
	leftParen := aSmaCCToken
]

{ #category : #generated }
CPPDoWhileStatementNode >> nodeVariables [
	^ #(#condition)
]

{ #category : #generated }
CPPDoWhileStatementNode >> otherVariables [
	^ #(#statement)
]

{ #category : #generated }
CPPDoWhileStatementNode >> rightParen [
	^ rightParen
]

{ #category : #generated }
CPPDoWhileStatementNode >> rightParen: aSmaCCToken [
	rightParen := aSmaCCToken
]

{ #category : #generated }
CPPDoWhileStatementNode >> semicolon [
	^ semicolon
]

{ #category : #generated }
CPPDoWhileStatementNode >> semicolon: aSmaCCToken [
	semicolon := aSmaCCToken
]

{ #category : #generated }
CPPDoWhileStatementNode >> statement [
	^ statement
]

{ #category : #generated }
CPPDoWhileStatementNode >> statement: anObject [
	statement := anObject
]

{ #category : #generated }
CPPDoWhileStatementNode >> tokenVariables [
	^ #(#doToken #whileToken #leftParen #rightParen #semicolon)
]

{ #category : #generated }
CPPDoWhileStatementNode >> whileToken [
	^ whileToken
]

{ #category : #generated }
CPPDoWhileStatementNode >> whileToken: aSmaCCToken [
	whileToken := aSmaCCToken
]