Class {
	#name : #SmaCCParserTypeDirectiveNode,
	#superclass : #SmaCCDirectiveNode,
	#instVars : [
		'typeToken',
		'name'
	],
	#category : #'SmaCC_Grammar_Parser'
}

{ #category : #generated }
SmaCCParserTypeDirectiveNode >> acceptVisitor: aDefinitionVisitor [
	^ aDefinitionVisitor visitParserTypeDirective: self
]

{ #category : #generated }
SmaCCParserTypeDirectiveNode >> name [
	^ name
]

{ #category : #generated }
SmaCCParserTypeDirectiveNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
SmaCCParserTypeDirectiveNode >> tokenVariables [
	^ #(#typeToken #name #directiveStartToken #semicolon)
]

{ #category : #generated }
SmaCCParserTypeDirectiveNode >> typeToken [
	^ typeToken
]

{ #category : #generated }
SmaCCParserTypeDirectiveNode >> typeToken: aSmaCCToken [
	typeToken := aSmaCCToken
]
