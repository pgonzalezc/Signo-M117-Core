Class {
	#name : #ScM117ModelLiquidacion,
	#superclass : #Object,
	#instVars : [
		'partidas'
	],
	#category : #'Signo-M117-Core'
}

{ #category : #accessing }
ScM117ModelLiquidacion >> at: unaPartida [
	unaPartida asNumber = 9
		ifTrue: [ ^ (self at: 3) + (self at: 6) + (self at: 8) ].
	unaPartida asNumber = 11
		ifTrue: [ ^ (self at: 9) - (self at: 10) ].
	^ partidas at: unaPartida asNumber
]

{ #category : #accessing }
ScM117ModelLiquidacion >> at: unaPartida put: unImporte [
	(partidas keys anySatisfy: [ :p | p = unaPartida asNumber ])
		ifTrue: [ partidas at: unaPartida asNumber put: unImporte asNumber ]
]

{ #category : #'as yet unclassified' }
ScM117ModelLiquidacion >> export [
	| converter |
	converter := GRNumberPrinter new
		digits: 17;
		precision: 0;
		padding: $0.
	
	^ String
		streamContents:
			[ :s | 1 to: 11 do: [ :aKey | s << (converter print: (self at: aKey) * 100) ] ]
]

{ #category : #initialization }
ScM117ModelLiquidacion >> initialize [
	super initialize.
	partidas := Dictionary new.
	#(1 2 3 4 5 6 7 8 10)
		do: [ :each | partidas at: each put: 0.0 ]
]
