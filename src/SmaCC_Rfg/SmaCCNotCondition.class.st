Class {
	#name : #SmaCCNotCondition,
	#superclass : #SmaCCAbstractCondition,
	#instVars : [
		'condition'
	],
	#category : #'SmaCC_Rfg-Conditions'
}

{ #category : #checking }
SmaCCNotCondition >> check [
	^ condition check not
]

{ #category : #accessing }
SmaCCNotCondition >> condition: aSmaCCAbstractCondition [
	condition := aSmaCCAbstractCondition
]
