Class {
	#name : #SmaCCVertex,
	#superclass : #Object,
	#instVars : [
		'lastResult',
		'layer',
		'next'
	],
	#category : #'SmaCC_Rfg-DAG'
}

{ #category : #public }
SmaCCVertex >> apply [
	self subclassResponsibility
]

{ #category : #break }
SmaCCVertex >> break [
	layer break
]

{ #category : #accessing }
SmaCCVertex >> next [
	^ next
]

{ #category : #accessing }
SmaCCVertex >> next: aSmaCCVertex [
	next := aSmaCCVertex
]
