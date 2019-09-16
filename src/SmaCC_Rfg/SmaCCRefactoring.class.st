Class {
	#name : #SmaCCRefactoring,
	#superclass : #Object,
	#instVars : [
		'source',
		'ast',
		'parserClass',
		'preconditions',
		'postconditions',
		'result'
	],
	#category : #'SmaCC_Rfg-Core'
}

{ #category : #public }
SmaCCRefactoring >> apply [
	self checkPreconditions ifFalse: [ ^ result ].
	self transform.
	self checkPostconditions ifFalse: [ ^ result ].
	^ result
]

{ #category : #conditions }
SmaCCRefactoring >> checkPostconditions [
	result postconditions: postconditions.
	result correct: postconditions check.
	^ result isCorrect
]

{ #category : #conditions }
SmaCCRefactoring >> checkPreconditions [
	result preconditions: preconditions.
	result applicable: preconditions check.
	^ result isApplicable
]

{ #category : #initialization }
SmaCCRefactoring >> initialize [
	super initialize.
	preconditions := SmaCCCondition new.
	postconditions := SmaCCCondition new.
	result := SmaCCRefactoringResult new.
]

{ #category : #accessing }
SmaCCRefactoring >> parserClass: aClass [
	parserClass := aClass
]

{ #category : #accessing }
SmaCCRefactoring >> postconditions [
	^ postconditions
]

{ #category : #accessing }
SmaCCRefactoring >> postconditions: anObject [
	postconditions := anObject
]

{ #category : #accessing }
SmaCCRefactoring >> preconditions [
	^ preconditions
]

{ #category : #accessing }
SmaCCRefactoring >> preconditions: anObject [
	preconditions := anObject
]

{ #category : #public }
SmaCCRefactoring >> redo [
	self subclassResponsibility
]

{ #category : #accessing }
SmaCCRefactoring >> result [
	^ result
]

{ #category : #accessing }
SmaCCRefactoring >> source: aString [
	source := aString
]

{ #category : #private }
SmaCCRefactoring >> transform [
	self subclassResponsibility
]

{ #category : #public }
SmaCCRefactoring >> undo [
	self subclassResponsibility
]
