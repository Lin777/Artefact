Class {
	#name : #PDFLetterFormat,
	#superclass : #PDFFormat,
	#category : #'Artefact-Formats'
}

{ #category : #'as yet unclassified' }
PDFLetterFormat >> defaultSize [
	^ 612 point @ 1008 point
]