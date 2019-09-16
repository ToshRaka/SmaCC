Class {
	#name : #SmaCCRefactoringResult,
	#superclass : #Object,
	#instVars : [
		'properties',
		'matchFound',
		'preconditions',
		'postconditions',
		'applicable',
		'correct'
	],
	#category : #'SmaCC_Rfg-Core'
}

{ #category : #accessing }
SmaCCRefactoringResult >> applicable: aBoolean [
	applicable := aBoolean
]

{ #category : #accessing }
SmaCCRefactoringResult >> correct: aBoolean [
	correct := aBoolean
]

{ #category : #initialization }
SmaCCRefactoringResult >> initialize [
	super initialize.
	properties := Dictionary new.
	preconditions := OrderedCollection new.
	postconditions := OrderedCollection new
]

{ #category : #accessing }
SmaCCRefactoringResult >> isApplicable [
		^ applicable
]

{ #category : #accessing }
SmaCCRefactoringResult >> isCorrect [
	^ correct
]

{ #category : #accessing }
SmaCCRefactoringResult >> postconditions [
	^ postconditions
]

{ #category : #accessing }
SmaCCRefactoringResult >> postconditions: aSmaCCAbstractCondition [
	postconditions := aSmaCCAbstractCondition
]

{ #category : #accessing }
SmaCCRefactoringResult >> preconditions [
	^ preconditions
]

{ #category : #accessing }
SmaCCRefactoringResult >> preconditions: aSmaCCAbstractCondition [
	preconditions := aSmaCCAbstractCondition
]

{ #category : #accessing }
SmaCCRefactoringResult >> properties [
	^ properties
]
