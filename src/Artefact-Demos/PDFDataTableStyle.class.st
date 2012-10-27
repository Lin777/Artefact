Class {
	#name : #PDFDataTableStyle,
	#superclass : #PDFComposite,
	#instVars : [
		'columns',
		'data',
		'inkForColumns',
		'fillColorForColumns'
	],
	#category : #'Artefact-Styles'
}

{ #category : #accessing }
PDFDataTableStyle >> columns [
	^ columns
]

{ #category : #accessing }
PDFDataTableStyle >> columns: anObject [
	columns := anObject
]

{ #category : #accessing }
PDFDataTableStyle >> data [
	^ data
]

{ #category : #accessing }
PDFDataTableStyle >> data: anObject [
	data := anObject
]

{ #category : #render }
PDFDataTableStyle >> renderContentOn: aPage [
	"answer the content of a datatable"
		
	(self columns isNil) ifFalse: [
		self columns do: [ :string | 
			self out: (PDFCellStyle new 
				wh: self wh; 
				ink: (self inkForColumns);
				fillColor: (self fillColorForColumns);
				border: true;
				font: (self font); 
				text: string; 
				alignToCenter). 
			]
		].
	
	self out: (PDFLineFeed new).
	
	(self data isNil) ifFalse: [
		self data do: [ :line |
			line do: [ :value |
				self out: (PDFCellStyle new
				wh: self wh;
				ink: self ink;
				fillColor: self fillColor;
				border: true;
				font: self font;
				text: value;
				alignToCenter).
				].
				self out: (PDFLineFeed new).
			].
		].
	
	^self buffer
	
]