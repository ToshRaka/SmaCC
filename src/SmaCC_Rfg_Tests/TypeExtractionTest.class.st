Class {
	#name : #TypeExtractionTest,
	#superclass : #TestCase,
	#category : #'SmaCC_Rfg_Tests-Core'
}

{ #category : #tests }
TypeExtractionTest >> testEmbeddedMetavariable [
	| ast result |
	ast := SmaCCMetavariableParser parse: 'a : metav'.
	result := MetavariableTypeExtractor new extract: ast.
]

{ #category : #tests }
TypeExtractionTest >> testKeyword [
	| ast result |
	ast := SmaCCMetavariableParser parse: 'a : ":"'.
	result := MetavariableTypeExtractor new extract: ast.
	self assert: result type symbolType equals: '":"'
]

{ #category : #tests }
TypeExtractionTest >> testList [
	| ast result |
	ast := SmaCCMetavariableParser parse: 'a : MetavORNode (":" MetavORNode)*'.
	result := MetavariableTypeExtractor new extract: ast.
	self assert: (result type isKindOf: RfgANDTypeSpecification).
	self assert: result type subtypes size equals: 3.
	self assert: (result type subtypes at: 2) cardinality isStar
]

{ #category : #tests }
TypeExtractionTest >> testNode [
	| ast result |
	ast := SmaCCMetavariableParser parse: 'a : MetavORNode'.
	result := MetavariableTypeExtractor new extract: ast.
	self assert: result type nodeType equals: 'MetavORNode'
]

{ #category : #tests }
TypeExtractionTest >> testNodeOption [
	| ast result |
	ast := SmaCCMetavariableParser parse: 'a : MetavORNode?'.
	result := MetavariableTypeExtractor new extract: ast.
	self assert: result type nodeType equals: 'MetavORNode'.
	self assert: result type cardinality isOption
]

{ #category : #tests }
TypeExtractionTest >> testNodePlus [
	| ast result |
	ast := SmaCCMetavariableParser parse: 'a : MetavORNode+'.
	result := MetavariableTypeExtractor new extract: ast.
	self assert: result type cardinality isPlus
]

{ #category : #tests }
TypeExtractionTest >> testNodeStar [
	| ast result |
	ast := SmaCCMetavariableParser parse: 'a : MetavORNode*'.
	result := MetavariableTypeExtractor new extract: ast.
	self assert: result type cardinality isStar
]

{ #category : #tests }
TypeExtractionTest >> testOR [
	| ast result |
	ast := SmaCCMetavariableParser parse: 'a : MetavORNode|<token>'.
	result := MetavariableTypeExtractor new extract: ast.
	self assert: (result type isKindOf: RfgORTypeSpecification) 
]

{ #category : #tests }
TypeExtractionTest >> testToken [
	| ast result |
	ast := SmaCCMetavariableParser parse: 'a : <token>'.
	result := MetavariableTypeExtractor new extract: ast.
	self assert: result type symbolType equals: '<token>'
]
