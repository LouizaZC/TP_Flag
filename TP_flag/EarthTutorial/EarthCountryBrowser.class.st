"
to do
"
Class {
	#name : 'EarthCountryBrowser',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'countryList',
		'countryCode',
		'countryFlag'
	],
	#category : 'EarthTutorial',
	#package : 'EarthTutorial'
}

{ #category : 'initialization' }
EarthCountryBrowser >> connectPresenters [
	countryList whenSelectedItemChangedDo: [ :item |
	self onCountrySelected: item ].
]

{ #category : 'as yet unclassified' }
EarthCountryBrowser >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		add: (SpBoxLayout newLeftToRight
			add: countryList expand: true;
			add: countryCode width: 40)
		height: self class toolbarHeight;
		add: countryFlag height: 350;
		yourself
]

{ #category : 'as yet unclassified' }
EarthCountryBrowser >> flagForCountryCode: astring [
	| request pngArray |
	request := ZnClient new.
	request get: 'https://flagcdn.com/w320/' , astring asLowercase , '.png'.
	request isSuccess ifTrue: [
	pngArray := request response contents.
		^ ImageReadWriter formFromStream: (ReadStream on: pngArray) ].
		^ BorderedMorph new asForm
]

{ #category : 'initialization' }
EarthCountryBrowser >> initializePresenters [
	super initializePresenters.
	countryList := self newDropList.
	countryList display: [ :item | item name ].
	countryList sortingBlock: [ :a :b | a model name < b model name ].
	countryList items: self model countries.
	countryCode := self newTextInput.
	countryCode editable: false.
	countryCode text: ' -- '.
	countryFlag := self newImage
]

{ #category : 'as yet unclassified' }
EarthCountryBrowser >> onCountrySelected: countryItem [
	countryCode text: ' ' , countryItem code.
	self showFlag: countryItem code
]

{ #category : 'as yet unclassified' }
EarthCountryBrowser >> showFlag [
    | flagFilePath flagImage |
    
    "Step 1: Determine the file path for the flag based on the country code"
    flagFilePath := 'resources/flags/', countryCode , '.png'.
    
    "Step 2: Check if the flag file exists"
   
        "Step 3: Load the image file"
        flagImage := Form fromFileNamed: flagFilePath.
        
        "Step 4: Display the flag image on the interface"
        countryFlag image: flagImage.  "Assuming flagView is the view displaying the flag"
    
    
]