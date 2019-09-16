Class {
	#name : #MetavMetavariableNodeVisitor,
	#superclass : #SmaCCParseNodeVisitor,
	#category : #'SmaCC_Rfg-Parsing'
}

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitDeclaration: aDeclaration [
	^ self visitMetavariable: aDeclaration
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitEmbedded: anEmbedded [
	^ self visitMetavariable: anEmbedded
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitEnhancedOperandList: anEnhancedOperandList [
	^ self visitMetavariable: anEnhancedOperandList
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitGroup: aGroup [
	^ self visitMetavariable: aGroup
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitKeyword: aKeyword [
	^ self visitMetavariable: aKeyword
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitKleenePlus: aKleenePlus [
	^ self visitMetavariable: aKleenePlus
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitKleeneStar: aKleeneStar [
	^ self visitMetavariable: aKleeneStar
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitMetavariable: aMetavariable [
	^ self visitSmaCCParseNode: aMetavariable
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitNonGreedyKleenePlus: aNonGreedyKleenePlus [
	^ self visitMetavariable: aNonGreedyKleenePlus
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitNonGreedyKleeneStar: aNonGreedyKleeneStar [
	^ self visitMetavariable: aNonGreedyKleeneStar
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitOR: anOR [
	^ self visitMetavariable: anOR
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitOption: anOption [
	^ self visitMetavariable: anOption
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitSymbol: aSymbol [
	^ self visitMetavariable: aSymbol
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitToken: aToken [
	^ self visitMetavariable: aToken
]

{ #category : #generated }
MetavMetavariableNodeVisitor >> visitWildcard: aWildcard [
	^ self visitMetavariable: aWildcard
]
