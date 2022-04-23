Class {
	#name : #ScM117ViewLiquidacion,
	#superclass : #WAComponent,
	#instVars : [
		'liquidacion'
	],
	#category : #'Signo-M117-Core'
}

{ #category : #'as yet unclassified' }
ScM117ViewLiquidacion >> actualizaPartida: unaPartida con: unImporte [
	liquidacion at: unaPartida put: unImporte.
	Transcript show: 'actualizada partida: '; show: unaPartida asString; cr
]

{ #category : #initialization }
ScM117ViewLiquidacion >> initialize [ 
	super initialize.
	liquidacion := ScM117ModelLiquidacion new.
]

{ #category : #accessing }
ScM117ViewLiquidacion >> liquidacion [

	^ liquidacion
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderADeducirOn: html [
	html
		tbsRow: [ html tbsColumn
				mediumSize: 6;
				with:
					'A deducir (exclusivamente en caso de declaración complementaria). Resultados a ingresar de anteriores declaraciones por el mismo concepto, ejercicio y periodo'.
			html tbsColumn
				mediumOffset: 3;
				mediumSize: 3;
				with: [ self renderCaptionP10On: html ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderBaseRetencionesAOn: html [
	html
		tbsRow: [ html tbsColumn
				mediumSize: 6;
				with: 'Base de las retenciones e ingresos a cuenta'.
			html tbsColumn
				mediumSize: 3;
				with: [ self renderCaptionP02On: html ].
			html tbsColumn
				mediumSize: 3;
				with: [ self renderCaptionP05On: html ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderBaseRetencionesBOn: html [
	html
		tbsRow: [ html tbsColumn
				mediumSize: 6;
				with: 'Base de las retenciones e ingresos a cuenta'.
			html tbsColumn
				mediumSize: 3;
				with: [ self renderCaptionP07On: html ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderCabecerasLiquidacionOn: html [
	html
		tbsRow: [ html tbsColumn
				mediumOffset: 6;
				mediumSize: 3;
				with:
					'Transmisiones o reembolsos acciones y participaciones representativas del capital o del patrimonio de las instituciones de inversión colectiva'.
			html tbsColumn
				mediumSize: 3;
				with: 'Transmisiones derechos de suscripción' ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderCaptionP01On: html [
	html
		tbsFormGroup: [ html
				tbsInputGroup: [ html tbsInputGroupAddOn: '01'.
					html textInput tbsFormControl
						id: '01';
						style: 'text-align: right';
						value: (liquidacion at: '01');
						callback: [ :unImporte | self actualizaPartida: '01' con: unImporte asNumber ] ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderCaptionP02On: html [
	html
		tbsFormGroup: [ html
				tbsInputGroup: [ html tbsInputGroupAddOn: '02'.
					html textInput tbsFormControl
						id: '02';
						style: 'text-align: right';
						value: (liquidacion at: '02');
						callback: [ :unImporte | self actualizaPartida: '02' con: unImporte asNumber ] ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderCaptionP03On: html [
	"El código en el método onChange:
		((html jQuery id: 'liquidacion-total') load serializeForm
								html: [ :r | self renderTotalLiquidacionOn: r ])
	 hace lo siguiente:
		1.-serializa el formulario en que se encuentra embebido este campo
		2.-lo envía al servidor y seaside ejecuta los callbacks asociados a todos los controles del mismo (si los tienen)
		3.-genera una respuesta en html (la generada por el método renderTotalLiquidacionOn:) y
		4.-el contenido de la respuesta se carga en el elemento identificado por el id 'liquidacion-total'.
		
	como el callback actualiza el modelo asociado a este componente (establece el valor de la partida '03') al renderizar 
	el área del total de la liquidación esta se muestra con los valores actualizados del modelo y da la sensación de que 
	los componentes con valores acumulados de otras partidas se actualizan.
	
	Para ver otra forma de hacer esto, ver el método renderCaptionP06On: y leer el comentario del mismo
	"

	html
		tbsFormGroup: [ html
				tbsInputGroup: [ html tbsInputGroupAddOn: '03'.
					html textInput tbsFormControl
						id: '03';
						style: 'text-align: right';
						value: (liquidacion at: '03');
						callback: [ :unImporte | self actualizaPartida: '03' con: unImporte asNumber ];
						onChange:
							((html jQuery id: 'liquidacion-total') load serializeForm
								html: [ :r | self renderTotalLiquidacionOn: r ]) ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderCaptionP04On: html [
	html
		tbsFormGroup: [ html
				tbsInputGroup: [ html tbsInputGroupAddOn: '04'.
					html textInput tbsFormControl
						id: '04';
						style: 'text-align: right';
						value: (liquidacion at: '04');
						callback: [ :unImporte | self actualizaPartida: '04' con: unImporte asNumber ] ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderCaptionP05On: html [
	html
		tbsFormGroup: [ html
				tbsInputGroup: [ html tbsInputGroupAddOn: '05'.
					html textInput tbsFormControl
						id: '05';
						style: 'text-align: right';
						value: (liquidacion at: '05');
						callback:  [ :unImporte | self actualizaPartida: '05' con: unImporte asNumber ] ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderCaptionP06On: html [
	"El código del método onChange: es,
	(ajax
		callback: [ :unImporte | self actualizaPartida: '06' con: unImporte asNumber ]
			value: html jQuery this value;
		script: [ :s | 
			s << (html jQuery id: 'liquidacion-total')
			html: [ :r | self renderTotalLiquidacionOn: r ] ])
	hace lo siguiente, cuando se modifica la partida:
		1.- realiza una llamada al servidor con el valor de la partia y ejecuta el callback asociado al objeto ajax con
		ese valor como parámetro.
		2.- el callback del paso 1 actualiza el valor de la partida '06' en el modelo de la liquidacion (actualizaPartida:con:)
		3.- y genera una respuesta html con el contenido renderizado por el método (renderTotalLiquidacionCon:) 
		4.- y con el html generado en el paso anterior (3) se actualiza el elemento con identificador 'liquidacion-total'
	A diferencia del método (renderCaptionP03On:) en el que el servidor recibe todo el formulario serializado lo que hace que se 
	ejecuten todos los callback asociados a los campos de entrada del mismo y se actualice todo el modelo, aquí sólo se recibe
	el campo modificado y en el modelo sólo se actualiza esa partida. El callback asociado al html no se ejecuta, sólo se ejecuta
	el asociado a la llamada ajax
	 "

	| ajax |
	ajax := html jQuery ajax.
	html
		tbsFormGroup: [ html
				tbsInputGroup: [ html tbsInputGroupAddOn: '06'.
					html textInput tbsFormControl
						id: '06';
						style: 'text-align: right';
						value: (liquidacion at: '06');
						callback: [ :unImporte | self actualizaPartida: '06' con: unImporte asNumber ];
							onChange:
							(ajax
								callback: [ :unImporte | self actualizaPartida: '06' con: unImporte asNumber ]
									value: html jQuery this value;
								script: [ :s | 
									s << (html jQuery id: 'liquidacion-total')
										html: [ :r | self renderTotalLiquidacionOn: r ] ]) ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderCaptionP07On: html [
	html
		tbsFormGroup: [ html
				tbsInputGroup: [ html tbsInputGroupAddOn: '07'.
					html textInput tbsFormControl
						id: '07';
						style: 'text-align: right';
						value: (liquidacion at: '07');
						callback: [ :unImporte | self actualizaPartida: '07' con: unImporte asNumber ] ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderCaptionP08On: html [
	| ajax |
	ajax := html jQuery ajax.
	html
		tbsFormGroup: [ html
				tbsInputGroup: [ html tbsInputGroupAddOn: '08'.
					html textInput tbsFormControl
						id: '08';
						style: 'text-align: right';
						value: (liquidacion at: '08');
						callback: [ :unImporte | self actualizaPartida: '08' con: unImporte asNumber ];
						onChange:
							(ajax
								callback: [ :unImporte | self actualizaPartida: '08' con: unImporte asNumber ]
									value: (html jQuery this) value;
								script: [ :s | 
									s << (html jQuery id: 'liquidacion-total')
										html: [ :r | self renderTotalLiquidacionOn: r ] ]) ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderCaptionP09On: html [
	| converter |
	converter := (GRSignPrinter new , (GRNumberPrinter new precision: 2)).
		html
		tbsFormGroup: [ html
				tbsInputGroup: [ html tbsInputGroupAddOn: '09'.
					html textInput tbsFormControl
						id: '09';
						readonly: true;
						style: 'text-align: right';
						value: (converter print: (liquidacion at: '09'));
						callback: [ :unImporte | self actualizaPartida: '09' con: unImporte asNumber ] ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderCaptionP10On: html [
	html
		tbsFormGroup: [ html
				tbsInputGroup: [ html tbsInputGroupAddOn: '10'.
					html textInput tbsFormControl
						id: '10';
						readonly: true;
						style: 'text-align: right';
						value: (liquidacion at: '10');
						callback:  [ :unImporte | self actualizaPartida: '10' con: unImporte asNumber ] ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderCaptionP11On: html [
	html
		tbsFormGroup: [ html
				tbsInputGroup: [ html tbsInputGroupAddOn: '11'.
					html textInput tbsFormControl
						id: '11';
						readonly: true;
						style: 'text-align: right';
						value: (liquidacion at: '11');
						callback:  [ :unImporte | self actualizaPartida: '11' con: unImporte asNumber ] ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderContentOn: html [
	html
		tbsPanel beDefault with: [ html tbsPanelHeading: [ html strong: 'Liquidación' ].
			html
				tbsPanelBody: [ self renderDetalleLiquidacionOn: html.
					self renderTotalLiquidacionOn: html ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderDetalleLiquidacionOn: html [
	self renderCabecerasLiquidacionOn: html.
	self renderGroupLiquidacionOn: html
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderGroupLiquidacionOn: html [
	html tbsRow: [ html strong: 'A) Retenciones e ingresos a cuenta' ].
	self renderNroPerceptoresOn: html.
	self renderBaseRetencionesAOn: html.
	self renderRetencionesIngresosACuentaAOn: html.
	html tbsRow: [ html strong: 'B) Pago a cuenta' ].
	self renderBaseRetencionesBOn: html.
	self renderRetencionesIngresosBCuentaAOn: html.
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderNroPerceptoresOn: html [
	html
		tbsRow: [ html tbsColumn
				mediumSize: 6;
				with: 'Número de perceptores'.
				html tbsColumn mediumSize: 3; with: [ self renderCaptionP01On: html ].
				html tbsColumn mediumSize: 3; with: [ self renderCaptionP04On: html ]]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderResultadoOn: html [
	html
		tbsRow: [ html tbsColumn
				mediumSize: 6;
				with: 'Resultado a ingresar ([09] - [10])'.
			html tbsColumn
				mediumOffset: 3;
				mediumSize: 3;
				with: [ self renderCaptionP11On: html ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderRetencionesIngresosACuentaAOn: html [
		html
		tbsRow: [ html tbsColumn
				mediumSize: 6;
				with: 'Retenciones e ingresos a cuenta'.
			html tbsColumn
				mediumSize: 3;
				with: [ self renderCaptionP03On: html ].
			html tbsColumn
				mediumSize: 3;
				with: [ self renderCaptionP06On: html ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderRetencionesIngresosBCuentaAOn: html [
	html
		tbsRow: [ html tbsColumn
				mediumSize: 6;
				with: 'Retenciones e ingresos a cuenta'.
			html tbsColumn
				mediumSize: 3;
				with: [ self renderCaptionP08On: html ] ]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderSumaRetencionesOn: html [
	html
		tbsRow: [ html tbsColumn
				mediumSize: 6;
				with:
					'Suma de retenciones e ingresos a cuenta y regularización, en su caso ([03] + [06] + [08])'.
				html tbsColumn mediumOffset:3; mediumSize: 3; with: [self renderCaptionP09On: html ]]
]

{ #category : #rendering }
ScM117ViewLiquidacion >> renderTotalLiquidacionOn: html [
	html div
		id: 'liquidacion-total';
		with: [ html tbsRow: [ html strong: 'Total liquidación' ].
			self renderSumaRetencionesOn: html.
			self renderADeducirOn: html.
			self renderResultadoOn: html ]
]

{ #category : #'as yet unclassified' }
ScM117ViewLiquidacion >> updatedP03 [
	Transcript
		show: 'updatedP03 called..';
		cr.
]
