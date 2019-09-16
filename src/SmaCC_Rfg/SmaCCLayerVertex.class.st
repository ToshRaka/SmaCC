Class {
	#name : #SmaCCLayerVertex,
	#superclass : #SmaCCVertex,
	#instVars : [
		'vertices',
		'level'
	],
	#category : #'SmaCC_Rfg-DAG'
}

{ #category : #adding }
SmaCCLayerVertex >> addVertex: aSmaCCVertex [
	vertices addLast: aSmaCCVertex
]

{ #category : #adding }
SmaCCLayerVertex >> addVertices: aCollection [
	aCollection do: [ :each | self addVertex: each ]
]

{ #category : #public }
SmaCCLayerVertex >> apply [
	next apply
]

{ #category : #break }
SmaCCLayerVertex >> break [
	vertices reverseDo: [ :each | each undo ]
]

{ #category : #initialization }
SmaCCLayerVertex >> initialize [
	super initialize.
	vertices := OrderedCollection new.
]
