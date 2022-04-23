Class {
	#name : #ScAnnComplementaria,
	#superclass : #Announcement,
	#instVars : [
		'complementaria'
	],
	#category : #'Signo-M117-Core'
}

{ #category : #'instance creation' }
ScAnnComplementaria class >> with: aBoolean [

	^ (self basicNew)
		setComplementaria: aBoolean
]

{ #category : #accessing }
ScAnnComplementaria >> complementaria [ 
	^ complementaria
]

{ #category : #initialization }
ScAnnComplementaria >> setComplementaria: aBoolean [

	complementaria := aBoolean
]
