Class {
	#name : #ScComponentRoot,
	#superclass : #WAComponent,
	#instVars : [
		'children'
	],
	#category : #'Signo-M117-Core'
}

{ #category : #testing }
ScComponentRoot class >> canBeRoot [

	^ true
]

{ #category : #'class initialization' }
ScComponentRoot class >> initialize [
	<script>
	WAAdmin register: self asApplicationAt: '/modelo/children'
]

{ #category : #hooks }
ScComponentRoot >> children [ 
	
	^ children
]

{ #category : #initialization }
ScComponentRoot >> initialize [ 
	
	super initialize.
	children := { ScComponentC1 new . ScComponentC2 new }
]

{ #category : #rendering }
ScComponentRoot >> renderContentOn: html [ 

	html form: [ 
		children do:[ :each | html render: each
		 ]]
]
