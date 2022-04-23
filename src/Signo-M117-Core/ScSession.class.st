Class {
	#name : #ScSession,
	#superclass : #WASession,
	#instVars : [
		'announcer'
	],
	#category : #'Signo-M117-Core'
}

{ #category : #accessing }
ScSession >> announcer [ 

	^ announcer ifNil: [ announcer := Announcer new ]
]
