Class {
	#name : #ScComponentC1,
	#superclass : #WAComponent,
	#instVars : [
		'esComplementaria'
	],
	#category : #'Signo-M117-Core'
}

{ #category : #accessing }
ScComponentC1 >> esComplementaria [

	^ esComplementaria 
]

{ #category : #initialization }
ScComponentC1 >> initialize [
	super initialize.
	esComplementaria := false
]

{ #category : #rendering }
ScComponentC1 >> renderContentOn: html [
	| ajax |
	ajax := html jQuery ajax.
	html tbsPanel beDefault
		with: [ html tbsPanelHeading: 'Componente C1'.
			html
				tbsPanelBody: [ html checkbox
						id: 'es-complementaria';
						value: self esComplementaria;
						onChange:
							(ajax
								callback: [ :aBoolean | self setComplementaria: aBoolean ]
								value: ((html jQuery id: 'es-complementaria') propertyAt: 'checked')).
					html space.
					html text: '¿Es complementaria?' ] ]
]

{ #category : #initialization }
ScComponentC1 >> setComplementaria: aBoolean [
	
	esComplementaria := aBoolean.
	self session announcer announce: (ScAnnComplementaria with: aBoolean)
]
