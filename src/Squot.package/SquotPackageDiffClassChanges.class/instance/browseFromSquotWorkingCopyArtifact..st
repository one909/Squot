tools
browseFromSquotWorkingCopyArtifact: aWorkingCopyArtifact
	^ ((PackageInfo squotEnvironmentOf: aWorkingCopyArtifact)
		classOrTraitNamed: className)
		browse