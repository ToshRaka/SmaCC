Extension { #name : #SmaCCToken }

{ #category : #'*SmaCC_Rfg-Syntactic' }
SmaCCToken >> syntacticMatch: anObject inContext: aRfgContext [
	^ self = anObject
]
