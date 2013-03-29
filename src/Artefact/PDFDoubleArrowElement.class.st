Class {
	#name : #PDFDoubleArrowElement,
	#superclass : #PDFArrow,
	#category : #'Artefact-Elements-Composites'
}

{ #category : #render }
PDFDoubleArrowElement >> getSubElementsWith: aPDFGenerator styleSheet: aStyleSheet [
	"answer the style description"

	^ {(PDFLineElement new
		styleSheet: self styleSheet;
		from: self from;
		to: self to)} , (self headAt: self to angle: self angle) , (self headAt: self from angle: self angle - Float pi)
]