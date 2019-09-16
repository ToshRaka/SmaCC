Class {
	#name : #SmaCCCondition,
	#superclass : #SmaCCAbstractCondition,
	#instVars : [
		'block'
	],
	#category : #'SmaCC_Rfg-Conditions'
}

{ #category : #accessing }
SmaCCCondition >> block: aBlock [
	block := aBlock
]

{ #category : #checking }
SmaCCCondition >> check [
	^ block value
]
