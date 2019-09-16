Extension { #name : #SmaCCParseNode }

{ #category : #'*SmaCC_Rfg-Syntactic' }
SmaCCParseNode >> isOption [
	^ false
]

{ #category : #'*SmaCC_Rfg-Syntactic' }
SmaCCParseNode >> isPlus [
	^ false
]

{ #category : #'*SmaCC_Rfg-Syntactic' }
SmaCCParseNode >> isStar [
	^ false
]

{ #category : #'*SmaCC_Rfg-Syntactic' }
SmaCCParseNode >> sortedNodesAndTokens [
	| symbols addBlock |
	symbols := OrderedCollection new.
	addBlock := [ :each | each ifNotNil: [ symbols add: each ] ].
	self nodesDo: addBlock andTokensDo: addBlock.
	^ symbols
		asSortedCollection: [ :a :b | 
			| startA startB |
			startA := a startPosition.
			startB := b startPosition.
			startA isNil or: [ b notNil and: [ startA < startB ] ] ]
]

{ #category : #'*SmaCC_Rfg-Syntactic' }
SmaCCParseNode >> syntacticMatch: aSmaCCParseNode inContext: aDictionary [
	self class = aSmaCCParseNode class
		ifFalse: [ ^ false ].
	(self
		syntacticMatchVariables: self tokenVariables
		to: aSmaCCParseNode
		inContext: aDictionary)
		ifFalse: [ ^ false ].
	(self
		syntacticMatchVariables: self nodeVariables
		to: aSmaCCParseNode
		inContext: aDictionary)
		ifFalse: [ ^ false ].
	(self
		syntacticMatchCollectionVariables: self compositeTokenVariables
		to: aSmaCCParseNode
		inContext: aDictionary)
		ifFalse: [ ^ false ].
	^ self
		syntacticMatchCollectionVariables: self compositeNodeVariables
		to: aSmaCCParseNode
		inContext: aDictionary
]

{ #category : #'*SmaCC_Rfg-Syntactic' }
SmaCCParseNode >> syntacticMatchCollection: matchNodes index: matchIndex to: programNodes index: programIndex inContext: aRfgContext [
	| node |
	matchNodes size < matchIndex
		ifTrue: [ ^ programNodes size < programIndex ].
	node := matchNodes at: matchIndex.
	(node isStar or: [ node isPlus ])
		ifTrue: [ node isGreedy
				ifTrue: [ ^ node
						greedyMatchCollection: matchNodes
						index: matchIndex
						to: programNodes
						index: programIndex
						inContext: aRfgContext ]
				ifFalse: [ ^ node
						nonGreedyMatchCollection: matchNodes
						index: matchIndex
						to: programNodes
						index: programIndex
						inContext: aRfgContext ] ].
	programNodes size < programIndex
		ifTrue: [ ^ false ].
	(node syntacticMatch: (programNodes at: programIndex) inContext: aRfgContext)
		ifFalse: [ ^ false ].
	^ node 
		syntacticMatchCollection: matchNodes
		index: matchIndex + 1
		to: programNodes
		index: programIndex + 1
		inContext: aRfgContext
]

{ #category : #'*SmaCC_Rfg-Syntactic' }
SmaCCParseNode >> syntacticMatchCollection: receiverCollection to: argumentCollection inContext: aDictionary [
	^ self
		syntacticMatchCollection: receiverCollection
		index: 1
		to: argumentCollection
		index: 1
		inContext: aDictionary
]

{ #category : #'*SmaCC_Rfg-Syntactic' }
SmaCCParseNode >> syntacticMatchCollectionVariables: aCollection to: aSmaCCParseNode inContext: aDictionary [
	^ aCollection
		allSatisfy:
			[ :each | 
			self
				syntacticMatchCollection: (self perform: each)
				to: (aSmaCCParseNode perform: each)
				inContext: aDictionary ]
]

{ #category : #'*SmaCC_Rfg-Syntactic' }
SmaCCParseNode >> syntacticMatchVariables: aCollection to: aSmaCCParseNode inContext: aDictionary [
	^ aCollection
		allSatisfy:
			[ :each | 
			| myValue otherValue |
			myValue := self perform: each.
			otherValue := aSmaCCParseNode perform: each.
			myValue isNil
				ifTrue: [ otherValue isNil ]
				ifFalse: [ myValue syntacticMatch: otherValue inContext: aDictionary ] ]
]
