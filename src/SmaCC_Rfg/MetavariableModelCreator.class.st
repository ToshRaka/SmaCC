Class {
	#name : #MetavariableModelCreator,
	#superclass : #MetavMetavariableNodeVisitor,
	#instVars : [
		'model'
	],
	#category : #'SmaCC_Rfg-Types'
}

{ #category : #initialization }
MetavariableModelCreator >> initialize [
	super initialize.
	model := RfgMetavariableToken new.
]

{ #category : #accessing }
MetavariableModelCreator >> model [
	^ model
]

{ #category : #visiting }
MetavariableModelCreator >> visitDeclaration: aDeclaration [
	model identifier ifNil: [ model identifier: aDeclaration metavariableName value].
	^ self visitMetavariable: aDeclaration
]

{ #category : #visiting }
MetavariableModelCreator >> visitOR: anOR [
	model tree ifNil: [ model tree: anOR ].
	^ self visitMetavariable: anOR
]
