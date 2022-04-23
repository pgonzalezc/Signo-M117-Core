Class {
	#name : #ScM117ViewRoot,
	#superclass : #WAComponent,
	#instVars : [
		'children'
	],
	#category : #'Signo-M117-Core'
}

{ #category : #testing }
ScM117ViewRoot class >> canBeRoot [

	^true
]

{ #category : #'class initialization' }
ScM117ViewRoot class >> initialize [
	WAAdmin register: self asApplicationAt: 'modelo/m117'
]

{ #category : #'as yet unclassified' }
ScM117ViewRoot >> enviar [
	
	Transcript
		show: ('[{1}]' format: {(children at: 1) liquidacion export});
		cr
]

{ #category : #initialization }
ScM117ViewRoot >> initialize [
	super initialize.
	children := {ScM117ViewLiquidacion new}
]

{ #category : #rendering }
ScM117ViewRoot >> renderContentOn: html [
	html
		form: [ children do: [ :each | html render: each ].
			html tbsButton bePrimary
				value: 'Enviar';
				callback: [ self enviar ] ]
]
