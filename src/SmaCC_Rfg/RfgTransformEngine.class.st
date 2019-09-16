Class {
	#name : #RfgTransformEngine,
	#superclass : #Object,
	#instVars : [
		'ast',
		'transforms',
		'cachedString'
	],
	#category : #'SmaCC_Rfg-Matching'
}

{ #category : #'instance-creation' }
RfgTransformEngine class >> transforms: aCollection ast: aSmaCCParseNode [
	^ self new 
		transforms: aCollection;
		ast: aSmaCCParseNode;
		yourself
]

{ #category : #sorting }
RfgTransformEngine >> addTransformFirst: aRfgStringTransform [
	transforms addFirst: aRfgStringTransform
]

{ #category : #sorting }
RfgTransformEngine >> addTransformLast: aRfgStringTransform [
	transforms addLast: aRfgStringTransform
]

{ #category : #accessing }
RfgTransformEngine >> ast [
	^ ast
]

{ #category : #accessing }
RfgTransformEngine >> ast: anObject [
	ast := anObject
]

{ #category : #initialization }
RfgTransformEngine >> initialize [
	super initialize.
	transforms := OrderedCollection new.
	
]

{ #category : #sorting }
RfgTransformEngine >> removeTransform: aRfgStringTransform [
	transforms remove: aRfgStringTransform
]

{ #category : #private }
RfgTransformEngine >> resetCache [
	cachedString := nil
]

{ #category : #rewriting }
RfgTransformEngine >> rewrite [
	^ self rewriteAST: ast
]

{ #category : #rewriting }
RfgTransformEngine >> rewriteAST: aSmaCCParseNode [
	cachedString ifNil: [ cachedString := aSmaCCParseNode completeSource copy ].
	self rewriteNode: aSmaCCParseNode.
	^ cachedString asString
]

{ #category : #rewriting }
RfgTransformEngine >> rewriteNode: aSmaCCParseNode [
	transforms do: [ :transform |
		transform matches do: [ :match | 
			match instanceTree = aSmaCCParseNode 
				ifTrue: [ ^ transform rewriteMatch: match in: cachedString with: self ] ] ].
	(aSmaCCParseNode isKindOf: SmaCCToken)
		ifFalse: [ aSmaCCParseNode sortedNodesAndTokens
			do: [ :child | self rewriteNode: child ] ]
]

{ #category : #sorting }
RfgTransformEngine >> sortTransforms: sortBlock [
	transforms sort: sortBlock
]

{ #category : #accessing }
RfgTransformEngine >> transforms [
	^ transforms
]

{ #category : #accessing }
RfgTransformEngine >> transforms: anObject [
	transforms := anObject
]
