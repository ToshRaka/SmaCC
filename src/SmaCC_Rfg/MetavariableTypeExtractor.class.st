Class {
	#name : #MetavariableTypeExtractor,
	#superclass : #MetavMetavariableNodeVisitor,
	#instVars : [
		'typeStack',
		'model'
	],
	#category : #'SmaCC_Rfg-Types'
}

{ #category : #public }
MetavariableTypeExtractor >> extract: aMetavDeclarationNode [
	model identifier ifNil: [ model identifier: aMetavDeclarationNode metavariableName value].
	aMetavDeclarationNode expression isNil 
		ifTrue: [ typeStack addLast: RfgTypeSpecification new ]
		ifFalse: [ self visitMetavariable: aMetavDeclarationNode ].
	model type: typeStack last.
	(model type isKindOf: RfgANDTypeSpecification)
		ifTrue: [ model metaparent: (RfgMetavariableNode identifier: model identifier) ].
	^ model
]

{ #category : #initialization }
MetavariableTypeExtractor >> initialize [
	super initialize.
	typeStack := OrderedCollection new.
	model := RfgMetavariableToken new
]

{ #category : #visiting }
MetavariableTypeExtractor >> visitEmbedded: anEmbedded [
	"submetavariable here, find how to implement it"

]

{ #category : #visiting }
MetavariableTypeExtractor >> visitEnhancedOperandList: anEnhancedOperandList [
	| currentTypes |
	self visitMetavariable: anEnhancedOperandList.
	currentTypes := typeStack removeLast: anEnhancedOperandList operands size.
	typeStack addLast: (currentTypes size = 1
		ifTrue: [ currentTypes first ]
		ifFalse: [ 
			| curatedTypes |
			curatedTypes := OrderedCollection new.
			currentTypes do: [ :each | (each isKindOf: RfgANDTypeSpecification)
				ifTrue: [ each subtypes do: [ :subtype | each copyCardinalityTo: subtype. curatedTypes addLast: subtype ] ]
				ifFalse: [ curatedTypes addLast: each ] ].
			RfgANDTypeSpecification subtypes: curatedTypes ])
]

{ #category : #visiting }
MetavariableTypeExtractor >> visitGroup: aGroup [
	^ self visitMetavariable: aGroup
]

{ #category : #visiting }
MetavariableTypeExtractor >> visitKeyword: aKeyword [
	| userType |
	userType := aKeyword keywordName value.
	typeStack addLast: (RfgTypeSpecification symbolType: userType nodeType: #SmaCCToken)
]

{ #category : #visiting }
MetavariableTypeExtractor >> visitKleenePlus: aKleenePlus [
	self visitMetavariable: aKleenePlus.
	typeStack last bePlus
]

{ #category : #visiting }
MetavariableTypeExtractor >> visitKleeneStar: aKleeneStar [
	self visitMetavariable: aKleeneStar.
	typeStack last beStar
]

{ #category : #visiting }
MetavariableTypeExtractor >> visitNonGreedyKleenePlus: aNonGreedyKleenePlus [
	self visitMetavariable: aNonGreedyKleenePlus.
	typeStack last bePlus; beNonGreedy
]

{ #category : #visiting }
MetavariableTypeExtractor >> visitNonGreedyKleeneStar: aNonGreedyKleeneStar [
	self visitMetavariable: aNonGreedyKleeneStar.
	typeStack last beStar; beNonGreedy
]

{ #category : #visiting }
MetavariableTypeExtractor >> visitOR: anOR [
	| currentTypes |
	self visitMetavariable: anOR.
	currentTypes := typeStack removeLast: anOR alternatives size.
	typeStack addLast: (currentTypes size = 1
		ifTrue: [ currentTypes first ]
		ifFalse: [ RfgORTypeSpecification subtypes: currentTypes asOrderedCollection ])
]

{ #category : #visiting }
MetavariableTypeExtractor >> visitOption: anOption [
	self visitMetavariable: anOption.
	typeStack last beOption
]

{ #category : #visiting }
MetavariableTypeExtractor >> visitSymbol: aSymbol [
	| userType |
	userType := aSymbol symbolName value asSymbol.
	((self class environment at: userType) includesBehavior: SmaCCParseNode)
		ifFalse: [ self halt."Throw Error: node not recognized" ].
	typeStack addLast: (RfgTypeSpecification nodeType: userType)
]

{ #category : #visiting }
MetavariableTypeExtractor >> visitToken: aToken [
	| userType |
	userType := aToken tokenName value.
	typeStack addLast: (RfgTypeSpecification symbolType: userType nodeType: #SmaCCToken)
]

{ #category : #visiting }
MetavariableTypeExtractor >> visitWildcard: aWildcard [
	typeStack addLast: (RfgTypeSpecification new)
]
