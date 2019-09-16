Class {
	#name : #ListMatchProgramNodeVisitor,
	#superclass : #SmaCCParseNodeVisitor,
	#category : #'SmaCC_Rfg_Tests-Core-Parser'
}

{ #category : #generated }
ListMatchProgramNodeVisitor >> visitCommaSeparatedList: aCommaSeparatedList [
	^ self visitProgram: aCommaSeparatedList
]

{ #category : #generated }
ListMatchProgramNodeVisitor >> visitIdentifier: anIdentifier [
	^ self visitProgram: anIdentifier
]

{ #category : #generated }
ListMatchProgramNodeVisitor >> visitNumber: aNumber [
	^ self visitProgram: aNumber
]

{ #category : #generated }
ListMatchProgramNodeVisitor >> visitProgram: aProgram [
	^ self visitSmaCCParseNode: aProgram
]

{ #category : #generated }
ListMatchProgramNodeVisitor >> visitRoot: aRoot [
	^ self visitProgram: aRoot
]

{ #category : #generated }
ListMatchProgramNodeVisitor >> visitStandardList: aStandardList [
	^ self visitProgram: aStandardList
]
