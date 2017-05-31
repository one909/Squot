tests
testMergeWithoutConflicts
	| sampleClass packagePath firstVersion secondMethodSource secondVersion  thirdMethodSource thirdVersion otherHistorian |
	"create a base version"
	sampleClass := classFactory newClass.
	sampleClass compile: 'firstMethod ^ self' classified: 'methods of first version'.
	workingCopy add: (PackageInfo named: classFactory packageName) at: 'src'.
	packagePath := (workingCopy store pathsOf: (PackageInfo named: classFactory packageName)) anyOne.
	workingCopy saveNewVersionMessage: 'first version' interactive: false.
	firstVersion := workingCopy baseVersion.
	"create first merge parent"
	sampleClass compile: (secondMethodSource := 'secondMethod ^ self') classified: 'methods of second version'.
	workingCopy saveNewVersionMessage: 'second version' interactive: false.
	secondVersion := workingCopy baseVersion.
	"create second merge parent"
	firstVersion snapshot in: [:firstSnapshot | | packageArtifact newSnapshot |
		packageArtifact := firstSnapshot artifactAt: packagePath.
		newSnapshot := firstSnapshot createNewBuilder
			add: (packageArtifact copyWithDifferentContent:
				(MCSnapshot fromDefinitions: packageArtifact content definitions,
					{MCMethodDefinition className: sampleClass name
						selector: #thirdMethod category: 'methods of third version'
						timeStamp: 'whatever'
						source: (thirdMethodSource := 'thirdMethod ^ self')}));
			buildSnapshot.
		otherHistorian := repository historianNamed: 'other'.
		otherHistorian version: firstVersion.
		thirdVersion := otherHistorian createNewVersion: newSnapshot
			with: [:newVersion | newVersion message: 'third version']].
	"merge the version of the other historian"
	[[workingCopy
		mergeVersionInteractively: thirdVersion
		ifCanceled: [self fail: 'this code should not be reached']]
		on: SquotSelectionOfChangesRequested do: [:request |
			"make sure the third method will be added"
			(request patch diffAt: packagePath) content operations
				detect: [:each | each definition isMethodDefinition and: [each toSource asString = thirdMethodSource]]
				ifNone: [self fail: 'third method not in the patch'].
			"the second method should not be modified"
			self deny: ((request patch diffAt: packagePath) content
				operations anySatisfy: [:each |
					each definition isMethodDefinition and: [each fromSource asString = secondMethodSource]]).
			request resume: request patch "accept all changes"]]
		valueSupplyingAnswers: {{'*'. #default}}.
	self assert: secondMethodSource
		equals: (sampleClass >> #secondMethod) getSource asString
		description: 'second method unchanged after merge'.
	self assert: thirdMethodSource
		equals: (sampleClass >> #thirdMethod) getSource asString
		description: 'third method loaded after merge'.
	self assert: secondVersion equals: workingCopy lastLoadedHistorian version.