Class {
	#name : #SmaCCAndCondition,
	#superclass : #SmaCCAbstractCondition,
	#instVars : [
		'left',
		'right',
		'leftFail',
		'rightFail'
	],
	#category : #'SmaCC_Rfg-Conditions'
}

{ #category : #'as yet unclassified' }
SmaCCAndCondition class >> left: aSmaCCAbstractCondition andRight: bSmaCCAbstractCondition [
	^ self new
		left: aSmaCCAbstractCondition;
		right: bSmaCCAbstractCondition;
		yourself
]

{ #category : #checking }
SmaCCAndCondition >> check [
	left check
		ifFalse: [ leftFail := true.
			^ false ].
	right check
		ifFalse: [ rightFail := true.
			^ false ].
	^ true
]

{ #category : #accessing }
SmaCCAndCondition >> left: aSmaCCAbstractCondition [
	left := aSmaCCAbstractCondition
]

{ #category : #accessing }
SmaCCAndCondition >> leftFail [
	^ leftFail 
]

{ #category : #accessing }
SmaCCAndCondition >> right: aSmaCCAbstractCondition [
	right := aSmaCCAbstractCondition
]

{ #category : #accessing }
SmaCCAndCondition >> rightFail [
	^ rightFail
]
