Class {
	#name : #SmaCCExtractRefactoring,
	#superclass : #SmaCCGrammarRefactoring,
	#instVars : [
		'rule',
		'alternative',
		'start',
		'end',
		'lhsName'
	],
	#category : #'SmaCC_Rfg-Core'
}

{ #category : #'as yet unclassified' }
SmaCCExtractRefactoring class >> extractFromRule: aString andAlternative: aInteger from: bInteger to: cInteger withName: bString [
	^ self new
		alternative: aInteger;
		rule: aString;
		start: bInteger;
		end: cInteger;
		lhsName: bString;
		yourself 
		 
]

{ #category : #accessing }
SmaCCExtractRefactoring >> alternative [
	^ alternative
]

{ #category : #accessing }
SmaCCExtractRefactoring >> alternative: anObject [
	alternative := anObject
]

{ #category : #accessing }
SmaCCExtractRefactoring >> end [
	^ end
]

{ #category : #accessing }
SmaCCExtractRefactoring >> end: anObject [
	end := anObject
]

{ #category : #accessing }
SmaCCExtractRefactoring >> lhsName [
	^ lhsName
]

{ #category : #accessing }
SmaCCExtractRefactoring >> lhsName: anObject [
	lhsName := anObject
]

{ #category : #accessing }
SmaCCExtractRefactoring >> rule [
	^ rule
]

{ #category : #accessing }
SmaCCExtractRefactoring >> rule: anObject [
	rule := anObject
]

{ #category : #accessing }
SmaCCExtractRefactoring >> start [
	^ start
]

{ #category : #accessing }
SmaCCExtractRefactoring >> start: anObject [
	start := anObject
]
