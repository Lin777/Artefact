"
A PDFLayout is the abstract class which any layout inherit. It contains a list of elements to place. A layout that inherit from PDFLayout just have to implement computeNextPositionElement

Instance Variables
	elements:		<Object>
	nextElementFrom:		<Object>

elements
	- xxxxx

nextElementFrom
	- xxxxx

"
Class {
	#name : #PDFLayout,
	#superclass : #PDFComposite,
	#instVars : [
		'elements',
		'nextElementFrom'
	],
	#category : #'Artefact-Elements'
}

{ #category : #adding }
PDFLayout >> add: aPDFElement [
	self elements addLast: aPDFElement
]

{ #category : #render }
PDFLayout >> computeNextElementPositionWith: aPDFGenerator styleSheet: aStyleSheet elementPosition: aPosition dimension: aDimension [
	^ self subclassResponsibility
]

{ #category : #render }
PDFLayout >> createOriginalDimensionDictionary [
	| dimensions |
	dimensions := Dictionary new. 
	self elements do: [ :anElement | dimensions at: anElement put: anElement wh ].
	^ dimensions
]

{ #category : #render }
PDFLayout >> createOriginalPositionDictionary [
	| positions |
	positions := Dictionary new. 
	self elements do: [ :anElement | positions at: anElement put: anElement from ].
	^ positions
]

{ #category : #render }
PDFLayout >> defineElementDimension: anElement with: aPDFGenerator styleSheet: aStyleSheet [
	anElement wh: (anElement minimumDimensionWith: aPDFGenerator styleSheet: aStyleSheet)
]

{ #category : #render }
PDFLayout >> defineElementPosition: anElement with: aPDFGenerator styleSheet: aStyleSheet [
	^ self subclassResponsibility 
]

{ #category : #accessing }
PDFLayout >> elements [
	^ elements
]

{ #category : #accessing }
PDFLayout >> elements: anObject [
	elements := anObject
]

{ #category : #render }
PDFLayout >> generateCodeSegmentsCollectionWith: aPDFGenerator styleSheet: compositeStyleSheet [
	| elementsOriginalPosition codeSegments elementsOriginalDimension |
	elementsOriginalPosition := self createOriginalPositionDictionary.
	elementsOriginalDimension := self createOriginalDimensionDictionary.
	codeSegments := self elements
		collect: [ :anElement | 
			self defineElementPosition: anElement with: aPDFGenerator styleSheet: compositeStyleSheet.
			self defineElementDimension: anElement with: aPDFGenerator styleSheet: compositeStyleSheet.
			anElement generateCodeSegmentWith: aPDFGenerator styleSheet: compositeStyleSheet ].
	elementsOriginalPosition keysAndValuesDo: [ :anElement :aPosition | anElement from: aPosition ].
	elementsOriginalDimension keysAndValuesDo: [ :anElement :aDimension | anElement wh: aDimension ].
	^ codeSegments
]

{ #category : #accessing }
PDFLayout >> initialize [ 
	super initialize.
	elements:= OrderedCollection new.
]

{ #category : #accessing }
PDFLayout >> nextElementFrom [
	^ nextElementFrom ifNil: [ self from ]
]

{ #category : #accessing }
PDFLayout >> nextElementFrom: nextPosition [
	nextElementFrom:= nextPosition
]