Class {
	#name : #ScComponentC2,
	#superclass : #WAComponent,
	#instVars : [
		'esComplementaria'
	],
	#category : #'Signo-M117-Core'
}

{ #category : #initialization }
ScComponentC2 >> initialize [
	super initialize.
	esComplementaria := false.
	self session announcer
		when: ScAnnComplementaria
		do: [ :anAnn | self reactToComplementaria: anAnn ]
]

{ #category : #'as yet unclassified' }
ScComponentC2 >> reactToComplementaria: anAnnouncement [
	esComplementaria := anAnnouncement complementaria .
	Transcript
		show: 'Announcement recibido. Value: ';
		show: anAnnouncement complementaria;
		cr
]

{ #category : #rendering }
ScComponentC2 >> renderContentOn: html [
	html tbsPanel beDefault
		with: [ html tbsPanelHeading: 'Componente C2'.
			html
				tbsPanelBody: [ html textInput tbsFormControl
						id: 'text-input';
						disabled: esComplementaria not ] ]
]
