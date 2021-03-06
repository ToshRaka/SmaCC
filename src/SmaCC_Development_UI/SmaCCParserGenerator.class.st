Class {
	#name : #SmaCCParserGenerator,
	#superclass : #ComposableModel,
	#instVars : [
		'tabModel',
		'definitionModel',
		'messagesModel',
		'symbolsModel',
		'itemSetsModel',
		'testModel',
		'parserClassName',
		'scannerClassName',
		'allowUnicode',
		'codeGeneratorType',
		'savedDefinition',
		'menu',
		'viewItemSets',
		'viewSymbols',
		'menuItems',
		'packageName'
	],
	#classVars : [
		'ShowPrecedenceConflicts'
	],
	#category : #'SmaCC_Development_UI'
}

{ #category : #specs }
SmaCCParserGenerator class >> defaultSpec [
	<spec>
	^ SpecColumnLayout composed
		add: #menu height: self toolbarHeight;
		add: #tabs;
		yourself
]

{ #category : #'class initialization' }
SmaCCParserGenerator class >> initialize [
	ShowPrecedenceConflicts := false
]

{ #category : #'world menu' }
SmaCCParserGenerator class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'SmaCC Parser Generator')
		parent: #Tools;
		order: 490.1;
		help: 'SmaCC Parser Generator Tool';
		action: [ self open ]
]

{ #category : #'instance creation' }
SmaCCParserGenerator class >> open [
	^ self new
		extent: 550 @ 450;
		openWithSpec;
		yourself
]

{ #category : #actions }
SmaCCParserGenerator >> close [
	self isModified
		ifTrue: [ self promptToSaveChanges
				ifFalse: [ ^ self ] ].
	self window close
]

{ #category : #private }
SmaCCParserGenerator >> codeGeneratorClass [
	^ SmaCCCodeGenerator withAllSubclasses
		detect: [ :each | each typeName = codeGeneratorType ]
		ifNone: [ SmaCCSmalltalkCodeGenerator new ]
]

{ #category : #private }
SmaCCParserGenerator >> codeGeneratorClasses [
	^ SmaCCCodeGenerator withAllSubclasses select: [ :each | each typeName notNil ]
]

{ #category : #actions }
SmaCCParserGenerator >> compile [
	^self compile: #LALR1
]

{ #category : #private }
SmaCCParserGenerator >> compile: aSymbol [
	| grammar stream oldCharacterSize parserCompiler messages |
	(self scannerClassName isEmpty or: [ self parserClassName isEmpty ])
		ifTrue: [ ^ UIManager default alert: 'Both classes are not specified' ].
	((Smalltalk includesKey: self parserClassName)
		or: [ packageName notNil ])
		ifFalse: [ self setPackage.
			packageName isNil
				ifTrue: [ ^ self ] ].
	messages := OrderedCollection new.
	Cursor wait
		showWhile: [ oldCharacterSize := SmaCCGrammar maximumCharacterValue.
			[ SmaCCGrammar
				maximumCharacterValue:
					(allowUnicode
						ifTrue: [ 16rE01EF ]
						ifFalse: [ 255 ]).
			self verifyParser
				ifFalse: [ ^ self ].
			parserCompiler := self compiler.
			parserCompiler
				codeGenerator: self codeGeneratorClass new;
				buildDefinition: self definition.
			parserCompiler codeGenerator defaultCategory: packageName.
			parserCompiler
				scannerClass: self scannerClassName;
				parserClass: self parserClassName.
			grammar := parserCompiler grammar.
			grammar type: aSymbol.
			stream := WriteStream on: String new.
			[ parserCompiler createChanges.
			parserCompiler codeGenerator compileChanges.
			viewSymbols
				ifTrue: [ symbolsModel text: parserCompiler symbolsComment ].
			viewItemSets
				ifTrue: [ itemSetsModel text: parserCompiler itemSetsComment ] ]
				on: SmaCCCompilationNotification
				do: [ :ex | 
					(ShowPrecedenceConflicts
						or: [ ('*precedence*' match: ex messageText) not ])
						ifTrue: [ messages
								add:
									ex messageText , (String with: Character cr with: Character cr)
										, ex tag ].
					ex pass ].
			messages asSortedCollection
				do: [ :each | 
					stream
						nextPutAll: '-------------------------';
						cr;
						nextPutAll: each;
						cr ].
			messagesModel text: stream contents.
			messagesModel text notEmpty
				ifTrue: [ tabModel selectedTab: (tabModel tabs at: 2) ].
			self markAsUnmodified ]
				ensure: [ SmaCCGrammar maximumCharacterValue: oldCharacterSize ] ]
]

{ #category : #private }
SmaCCParserGenerator >> compiler [
	^SmaCCGrammarCompiler new
]

{ #category : #actions }
SmaCCParserGenerator >> debugParse [
	| process |
	process := [ self parserClass parse: testModel text asString ] newProcess.
	[ (process suspendedContext receiver isKindOf: SmaCCParser) and: [ process suspendedContext selector = #parse ] ]
		whileFalse: [ process step: process suspendedContext ].
	process debug
]

{ #category : #private }
SmaCCParserGenerator >> definition [
	^ definitionModel text asString
]

{ #category : #private }
SmaCCParserGenerator >> definition: source [
	definitionModel text: source
]

{ #category : #initialization }
SmaCCParserGenerator >> definitionTab [
	definitionModel := self instantiate: TextModel.
	definitionModel autoAccept: true.
	^ self newTab
		closeable: false;
		label: 'Definition';
		presenter: definitionModel;
		yourself
]

{ #category : #private }
SmaCCParserGenerator >> displayError: aString at: position [
	self textWidget
		ifNotNil:
			[ :each | 
			each
				text: (each text copyFrom: 1 to: position - 1) , aString , ' ->' , (each text copyFrom: position to: each text size).
			each setSelection: (position to: position + aString size + 2) ]
]

{ #category : #initialization }
SmaCCParserGenerator >> fileMenu [
	^ MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: 'Open...';
						action: [ self findParserClass ] ];
				addItem: [ :item | 
					item
						name: 'Save';
						action: [ self compile ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: 'Exit';
						action: [ self close ] ] ]
]

{ #category : #actions }
SmaCCParserGenerator >> findParserClass [
	| class subclasses |
	self isModified
		ifTrue: [ self promptToSaveChanges
				ifFalse: [ ^ self ] ].
	subclasses := (SmaCCParser allSubclasses asSortedCollection: [ :a :b | a name < b name ]) asArray.
	class := UIManager default
		chooseFrom: (subclasses collect: [ :each | each name ])
		values: subclasses
		message: 'What class do you want to use?'.
	class isNil
		ifTrue: [ ^ self ].
	self parserClassName: class name.
	self updateDefinitionFor: class.
	self markAsUnmodified
]

{ #category : #initialization }
SmaCCParserGenerator >> initialize [
	allowUnicode := false.
	parserClassName := ''.
	scannerClassName := ''.
	codeGeneratorType := #Smalltalk.
	savedDefinition := ''.
	viewSymbols := true.
	viewItemSets := false.
	menuItems := Dictionary new.
	super initialize
]

{ #category : #initialization }
SmaCCParserGenerator >> initializeMenubar [
	menu := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: 'File';
						subMenu: self fileMenu ];
				addItem: [ :item | 
					item
						name: 'Options';
						subMenu: self optionsMenu ];
				addItem: [ :item | 
					item
						name: 'View';
						subMenu: self viewMenu ] ]
]

{ #category : #initialization }
SmaCCParserGenerator >> initializeTabModel [
	tabModel := self instantiate: SmaCCTabManagerPresenter.
	tabModel
		addTab: self definitionTab;
		addTab: self messagesTab;
		addTab: self symbolsTab;
		addTab: self itemSetsTab;
		addTab: self testTab
]

{ #category : #initialization }
SmaCCParserGenerator >> initializeWidgets [
	self initializeTabModel.
	self initializeMenubar.
	self updateOptionsMenu.
	self updateViewMenu
]

{ #category : #private }
SmaCCParserGenerator >> isModified [
	^ savedDefinition ~= self definition
]

{ #category : #testing }
SmaCCParserGenerator >> isUnicode [
	^ allowUnicode
]

{ #category : #private }
SmaCCParserGenerator >> isValidName: aString [
	^ aString first isUppercase and: [ RBScanner isVariable: aString ]
]

{ #category : #initialization }
SmaCCParserGenerator >> itemSetsTab [
	itemSetsModel := self instantiate: TextModel.
	itemSetsModel disable.
	^ self newTab
		closeable: false;
		label: 'Item Sets';
		presenter: itemSetsModel;
		yourself
]

{ #category : #private }
SmaCCParserGenerator >> language [
	^ codeGeneratorType
]

{ #category : #actions }
SmaCCParserGenerator >> markAsUnmodified [
	savedDefinition := self definition
]

{ #category : #accessing }
SmaCCParserGenerator >> menu [
	^ menu
]

{ #category : #private }
SmaCCParserGenerator >> menuItemFor: aSymbol [
	^ menuItems at: aSymbol
]

{ #category : #initialization }
SmaCCParserGenerator >> messagesTab [
	messagesModel := self instantiate: TextModel.
	messagesModel disable.
	^ self newTab
		closeable: false;
		label: 'Messages';
		presenter: messagesModel;
		yourself
]

{ #category : #initialization }
SmaCCParserGenerator >> optionsMenu [
	^ MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					menuItems at: #setScannerClass put: item.
					item
						autoRefresh: true;
						name: 'Scanner Class...';
						action: [ self setScannerClass ] ];
				addItem: [ :item | 
					menuItems at: #setParserClass put: item.
					item
						autoRefresh: true;
						name: 'Parser Class...';
						action: [ self setParserClass ] ];
				addItem: [ :item | 
					menuItems at: #setPackage put: item.
					item
						autoRefresh: true;
						name: 'Set Package...';
						action: [ self setPackage ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					menuItems at: #useUnicode put: item.
					item
						autoRefresh: true;
						name: 'Allow Unicode Characters';
						action: [ self useUnicode ] ];
				addItem: [ :item | 
					menuItems at: #optimizeTransitionTable put: item.
					item
						autoRefresh: true;
						name: 'Optimize Transition Table';
						action: [ self toggleOptimizeTransitionTable ] ] ]
]

{ #category : #actions }
SmaCCParserGenerator >> parse [
	self parseAndEvaluate: [ :each | UIManager default message: 'Parses without errors' ]
]

{ #category : #private }
SmaCCParserGenerator >> parseAndEvaluate: aBlock [
	| class |
	class := self parserClass.
	class isNil
		ifTrue: [ ^ UIManager default alert: 'No parser defined' ].
	aBlock
		value:
			(class
				parse: testModel text asString
				onError:
					[ :aString :position | 
					tabModel selectedTab: tabModel tabs last.
					self displayError: aString at: position.
					^ self ])
]

{ #category : #actions }
SmaCCParserGenerator >> parseAndInspect [
	self parseAndEvaluate: [ :each | each inspect ]
]

{ #category : #private }
SmaCCParserGenerator >> parserClass [
	self parserClassName isEmpty
		ifTrue: [ ^ nil ].
	^ Smalltalk at: self parserClassName asSymbol
]

{ #category : #accessing }
SmaCCParserGenerator >> parserClassName [
	^ parserClassName
]

{ #category : #accessing }
SmaCCParserGenerator >> parserClassName: aString [
	parserClassName := aString.
	self updateOptionsMenu
]

{ #category : #private }
SmaCCParserGenerator >> promptToSaveChanges [
	^ (self confirm: 'The definition has been modified. Do you wish to retain your changes?') not
]

{ #category : #accessing }
SmaCCParserGenerator >> scannerClassName [
	^ scannerClassName
]

{ #category : #accessing }
SmaCCParserGenerator >> scannerClassName: aString [
	scannerClassName := aString.
	self updateOptionsMenu
]

{ #category : #actions }
SmaCCParserGenerator >> setCodeGenerator: aSymbol [
	codeGeneratorType := aSymbol
]

{ #category : #actions }
SmaCCParserGenerator >> setPackage [
	| name |
	name := UIManager default
		enterOrRequestFrom: RPackage organizer packageNames asSortedCollection
		title: 'Select package:'.
	(name isNil or: [ name isEmpty ])
		ifTrue: [ ^ self ].
	packageName := name
]

{ #category : #actions }
SmaCCParserGenerator >> setParserClass [
	| name |
	name := UIManager default request: 'Enter parser class name:' initialAnswer: self parserClassName.
	(name isNil or: [ name isEmpty ])
		ifTrue: [ ^ self ].
	(self isValidName: name)
		ifFalse: [ ^ UIManager default inform: 'Invalid Class Name' ].
	self parserClassName: name asSymbol
]

{ #category : #actions }
SmaCCParserGenerator >> setScannerClass [
	| name |
	name := UIManager default request: 'Enter scanner class name:' initialAnswer: self scannerClassName.
	(name isNil or: [ name isEmpty ])
		ifTrue: [ ^ self ].
	(self isValidName: name)
		ifFalse: [ ^ UIManager default inform: 'Invalid Class Name' ].
	self scannerClassName: name asSymbol
]

{ #category : #private }
SmaCCParserGenerator >> switchToDefinition [
	tabModel selectedTab label ~= 'Definition'
		ifTrue: [ tabModel selectedTab: tabModel tabs first ]
]

{ #category : #initialization }
SmaCCParserGenerator >> symbolsTab [
	symbolsModel := self instantiate: TextModel.
	symbolsModel disable.
	^ self newTab
		closeable: false;
		label: 'Symbols';
		presenter: symbolsModel;
		yourself
]

{ #category : #accessing }
SmaCCParserGenerator >> tabs [
	^ tabModel
]

{ #category : #initialization }
SmaCCParserGenerator >> testMenu: aMenu [
	^ aMenu
		add: 'Find...' selector: #find;
		addLine;
		add: 'Evaluate' target: self selector: #parse;
		add: 'Inspect...' target: self selector: #parseAndInspect;
		add: 'Debug' target: self selector: #debugParse;
		yourself
]

{ #category : #initialization }
SmaCCParserGenerator >> testTab [
	testModel := self instantiate: TextModel.
	testModel
		autoAccept: true;
		menuHolder: [ :mnu | self testMenu: mnu ].
	^ self newTab
		closeable: false;
		label: 'Test';
		presenter: testModel;
		yourself
]

{ #category : #private }
SmaCCParserGenerator >> textWidget [
	tabModel selectedTab == definitionModel owner
		ifTrue: [ ^ definitionModel ].
	tabModel selectedTab == testModel owner
		ifTrue: [ ^ testModel ].
	^ nil
]

{ #category : #accessing }
SmaCCParserGenerator >> title [
	^ 'SmaCC'
]

{ #category : #actions }
SmaCCParserGenerator >> toggleOptimizeTransitionTable [
	SmaCCGrammarCompiler toggleOptimizeTransitionTable.
	self updateOptionsMenu
]

{ #category : #private }
SmaCCParserGenerator >> updateDefinitionFor: parserClass [
	| scannerClass |
	scannerClass := [ parserClass scannerClass ]
		on: Error
		do: [ :ex | ex return: nil ].
	scannerClass notNil
		ifTrue: [ self scannerClassName: scannerClass name ].
	self definition: parserClass definitionString.
	messagesModel text: ''.
	symbolsModel text: ''.
	itemSetsModel text: ''.
	self switchToDefinition
]

{ #category : #private }
SmaCCParserGenerator >> updateMenuItem: aSymbol checked: aBoolean [
	| item |
	item := self menuItemFor: aSymbol.
	item
		icon:
			(self
				iconNamed:
					(aBoolean
						ifTrue: [ #checkBoxOn ]
						ifFalse: [ #checkBoxOff ]))
]

{ #category : #private }
SmaCCParserGenerator >> updateOptionsMenu [
	(self menuItemFor: #setScannerClass)
		name:
			'Scanner Class'
				,
					(scannerClassName isEmpty
						ifTrue: [ '' ]
						ifFalse: [ ' (' , scannerClassName , ')' ]) , '...'.
	(self menuItemFor: #setParserClass)
		name:
			'Parser Class'
				,
					(parserClassName isEmpty
						ifTrue: [ '' ]
						ifFalse: [ ' (' , parserClassName , ')' ]) , '...'.
	self updateMenuItem: #useUnicode checked: self isUnicode.
	self updateMenuItem: #optimizeTransitionTable checked: SmaCCGrammarCompiler optimizeTransitionTable
]

{ #category : #private }
SmaCCParserGenerator >> updateViewMenu [
	self updateMenuItem: #viewSymbolsClicked checked: viewSymbols.
	self updateMenuItem: #viewItemSetsClicked checked: viewItemSets
]

{ #category : #actions }
SmaCCParserGenerator >> useUnicode [
	allowUnicode := allowUnicode not.
	self updateOptionsMenu
]

{ #category : #private }
SmaCCParserGenerator >> verifyParser [
	^ [ SmaCCGrammarCompiler new
		codeGenerator: self codeGeneratorClass new;
		buildDefinition: self definition.
	true ]
		on: SmaCCParserError
		do:
			[ :ex | 
			self switchToDefinition.
			self displayError: ex description at: ex tag position.
			ex return: false ]
]

{ #category : #actions }
SmaCCParserGenerator >> viewItemSetsClicked [
	viewItemSets := viewItemSets not.
	self updateViewMenu
]

{ #category : #initialization }
SmaCCParserGenerator >> viewMenu [
	^ MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					menuItems at: #viewSymbolsClicked put: item.
					item
						autoRefresh: true;
						name: 'Symbols';
						action: [ self viewSymbolsClicked ] ];
				addItem: [ :item | 
					menuItems at: #viewItemSetsClicked put: item.
					item
						autoRefresh: true;
						name: 'Item Sets';
						action: [ self viewItemSetsClicked ] ] ]
]

{ #category : #actions }
SmaCCParserGenerator >> viewSymbolsClicked [
	viewSymbols := viewSymbols not.
	self updateViewMenu
]
