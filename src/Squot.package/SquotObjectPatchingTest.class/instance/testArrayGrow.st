testing
testArrayGrow
	| original target |
	original := #(1 2).
	target := #(1 2 3).
	self assert: target equals: (self patchedFrom: original to: target).