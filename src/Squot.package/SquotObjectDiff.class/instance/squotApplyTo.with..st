patching
squotApplyTo: aShadow with: aPatcher
	"Apply my changes to aShadow (the representation of an object in a snapshot)
	and answer the result."
	^ aShadow applyDiff: self with: aPatcher