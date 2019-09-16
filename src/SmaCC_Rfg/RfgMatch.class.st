Class {
	#name : #RfgMatch,
	#superclass : #Object,
	#instVars : [
		'instanceTree',
		'context'
	],
	#category : #'SmaCC_Rfg-Matching'
}

{ #category : #'instance creation' }
RfgMatch class >> with: aRfgParseNode [
	^ self new 
		instanceTree: aRfgParseNode;
		yourself
]

{ #category : #'as yet unclassified' }
RfgMatch class >> with: aRfgParseNode andContext: aRfgScope [
	^ self new 
		instanceTree: aRfgParseNode;
		context: aRfgScope;
		yourself
]

{ #category : #accessing }
RfgMatch >> context [
	^ context
]

{ #category : #accessing }
RfgMatch >> context: anObject [
	context := anObject
]

{ #category : #accessing }
RfgMatch >> instanceTree [
	^ instanceTree
]

{ #category : #accessing }
RfgMatch >> instanceTree: anObject [
	instanceTree := anObject
]
