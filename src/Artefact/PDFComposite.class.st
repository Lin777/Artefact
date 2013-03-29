"
A PDFComposite is the abstract class which any composite inherit. A composite is a PDFElement grouping many PDFElement to create more elaborated elements than PDFBasic (for example a PDFArrowElement is a composition of PDFLine to draw an arrow).

A composit that inherit from PDFComposite just have to implement a getSubElements method returning a collection of PDFElement.

Instance Variables
	filled:		<Object>

filled
	- xxxxx

"
Class {
	#name : #PDFComposite,
	#superclass : #PDFElement,
	#instVars : [
		'filled'
	],
	#category : #'Artefact-Elements'
}

{ #category : #accessing }
PDFComposite >> dotted: aPDFDottedObject [
	self styleSheet dotted: aPDFDottedObject
]

{ #category : #accessing }
PDFComposite >> drawColor: aColor [
	self styleSheet drawColor: aColor
]

{ #category : #accessing }
PDFComposite >> fillColor: aColor [
	self filled: true.
	self styleSheet fillColor: aColor
]

{ #category : #accessing }
PDFComposite >> filled [
	^ filled
]

{ #category : #accessing }
PDFComposite >> filled: anObject [
	filled := anObject
]

{ #category : #accessing }
PDFComposite >> font: aFont [
	self styleSheet font: aFont
]

{ #category : #render }
PDFComposite >> generateCodeSegmentWith: aPDFGenerator styleSheet: aStyleSheet [
	| compositeStyleSheet |
	compositeStyleSheet := aStyleSheet + self styleSheet.
	^ PDFCompositeCodeSegment
		from: (self generateCodeSegmentsCollectionWith: aPDFGenerator styleSheet: compositeStyleSheet)
		styleSheet: compositeStyleSheet
]

{ #category : #render }
PDFComposite >> generateCodeSegmentsCollectionWith: aPDFGenerator styleSheet: compositeStyleSheet [
	^ (self getSubElementsWith: aPDFGenerator styleSheet: compositeStyleSheet)
		collect: [ :aSubElement | aSubElement generateCodeSegmentWith: aPDFGenerator styleSheet: compositeStyleSheet ]
]

{ #category : #render }
PDFComposite >> getSubElementsWith: aPDFGenerator styleSheet: anObject [
	""
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PDFComposite >> initialize [ 
	super initialize.
	self filled: false
]

{ #category : #accessing }
PDFComposite >> textColor: aColor [
	self styleSheet textColor: aColor
]

{ #category : #accessing }
PDFComposite >> thickness: aThickness [
	self styleSheet thickness: aThickness 
 
]