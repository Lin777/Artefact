"
A PDFElement is the abstract class for each element that can be included in a PDFPage.

Each PDFElement have the possibility to define which style will be applyed on it instead of the default one.

Instance Variables
	styleSheet:		<Object>

styleSheet
	- xxxxx

"
Class {
	#name : #PDFElement,
	#superclass : #Object,
	#instVars : [
		'styleSheet',
		'from',
		'style',
		'dimension',
		'orientation'
	],
	#category : #'Artefact-Core-Elements'
}

{ #category : #'as yet unclassified' }
PDFElement class >> determineOrientation: aPoint [
	^ ((aPoint y < 0 ifTrue: [ 'top' ] ifFalse: [ 'bottom' ]) , (aPoint x < 0 ifTrue: [ 'Left' ] ifFalse: [ 'Right' ])) asSymbol
]

{ #category : #'as yet unclassified' }
PDFElement class >> from: aPosition [
	^ self new from: aPosition
]

{ #category : #'as yet unclassified' }
PDFElement class >> from: aPosition dimension: aDimension [
	^ (self from: aPosition) dimension: aDimension
]

{ #category : #'as yet unclassified' }
PDFElement class >> from: aPosition to: anotherPosition [
	^ (self from: (aPosition min: anotherPosition) dimension: (anotherPosition - aPosition) abs ) orientation: (self determineOrientation: anotherPosition - aPosition)
]

{ #category : #style }
PDFElement >> buildCompositeStyleSheetFrom: aStyleSheet [
	"realise the addition (ordered from less priority to higher) of differents styleSheet. The first one come from the upper elements. The second one is the context specific to the element. The third one is defined by the user only for this element and so is prioritary"

	^ (aStyleSheet substyles
		at: self style
		ifPresent: [ :subStyle | aStyleSheet withoutSubstyles + subStyle ]
		ifAbsent: [ aStyleSheet ]) + self styleSheet
]

{ #category : #accessing }
PDFElement >> center [
	^ (self from + self to) / 2
]

{ #category : #checking }
PDFElement >> checkAttributes [
	self requiredAttributes
		do: [ :anAttribute | (self perform: anAttribute) ifNil: [ ArtefactUndefinedAttribute signalMissingAttribute: anAttribute for: self ] ]
]

{ #category : #style }
PDFElement >> defaultStyle [
	^ self subclassResponsibility 
]

{ #category : #accessing }
PDFElement >> dimension [
	^ dimension
]

{ #category : #accessing }
PDFElement >> dimension: aDimension [
	dimension:= aDimension 
]

{ #category : #accessing }
PDFElement >> from [
	^ from
]

{ #category : #accessing }
PDFElement >> from: anObject [
	from := anObject
]

{ #category : #render }
PDFElement >> generateCodeSegmentWith: aGenerator styleSheet: aStyleSheet [
	^ self subclassResponsibility 
]

{ #category : #render }
PDFElement >> generateWith: aGenerator styleSheet: aStyleSheet [
	"this method is the main one to generate this PDFElement"
	self checkAttributes.
	^ self generateCodeSegmentWith: aGenerator styleSheet: (self buildCompositeStyleSheetFrom: aStyleSheet)
]

{ #category : #size }
PDFElement >> height [
	^ self dimension y
]

{ #category : #'initialize-release' }
PDFElement >> initialize [ 
	super initialize.
	self orientation: #bottomRight.
	self styleSheet: PDFStyleSheet new.
	self style: self defaultStyle
]

{ #category : #render }
PDFElement >> minimumDimensionWith: aPDFGenerator styleSheet: aStyleSheet [
	"Return the minimum dimension for layout, by default its the one defined by the user"
	^ self dimension
]

{ #category : #accessing }
PDFElement >> orientation [
	^ orientation
]

{ #category : #accessing }
PDFElement >> orientation: anObject [
	orientation := anObject
]

{ #category : #accessing }
PDFElement >> orientedFrom [
	^ ({(#bottomRight -> [ self from ]).
	(#bottomLeft -> [ self to x @ self from y ]).
	(#topRight -> [ self from x @ self to y ]).
	(#topLeft -> [ self to x @ self to y ])} asDictionary at: self orientation) value
]

{ #category : #accessing }
PDFElement >> orientedTo [
	^ ({(#bottomRight -> [ self to ]).
	(#bottomLeft -> [ self from x @ self to y ]).
	(#topRight -> [ self to x @ self from y ]).
	(#topLeft -> [ self from x @ self from y ])} asDictionary at: self orientation) value
]

{ #category : #checking }
PDFElement >> requiredAttributes [
	^ #( from dimension )
]

{ #category : #accessing }
PDFElement >> rotation: anAngle [
	self styleSheet rotation: anAngle 
 
]

{ #category : #accessing }
PDFElement >> style [
	^ style
]

{ #category : #accessing }
PDFElement >> style: anObject [
	style := anObject
]

{ #category : #accessing }
PDFElement >> styleSheet [
	^ styleSheet
]

{ #category : #accessing }
PDFElement >> styleSheet: anObject [
	styleSheet := anObject
]

{ #category : #accessing }
PDFElement >> to [
	^ self from + self dimension
]

{ #category : #size }
PDFElement >> width [
	^ self dimension x
]