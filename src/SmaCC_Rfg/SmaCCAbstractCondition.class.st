Class {
	#name : #SmaCCAbstractCondition,
	#superclass : #Object,
	#category : #'SmaCC_Rfg-Conditions'
}

{ #category : #'logical operations' }
SmaCCAbstractCondition >> & aSmaCCAbstractCondition [
	^ SmaCCAndCondition left: self andRight: aSmaCCAbstractCondition
]

{ #category : #checking }
SmaCCAbstractCondition >> check [
	self subclassResponsibility
]

{ #category : #'logical operations' }
SmaCCAbstractCondition >> not [
	^ SmaCCNotCondition new condition: self
]

{ #category : #'logical operations' }
SmaCCAbstractCondition >> | aSmaCCAbstractCondition [
	"Maybe be more effective to have a SmaCCOrCondition"
	^ (self not & aSmaCCAbstractCondition not) not
]
