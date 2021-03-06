testing
testRectangle
	| shadow |
	shadow := capturer captureStandalone: (1@2 corner: 3@4).
	self assert: shadow slots size = 2.
	self assert: ((shadow slots at: 'origin') isMemberOf: (capturer captureStandalone: 1@2) undecorated class).
	self assert: ((shadow slots at: 'origin') slots at: 'x') value = 1.
	self assert: ((shadow slots at: 'origin') slots at: 'y') value = 2.
	self assert: ((shadow slots at: 'corner') isMemberOf: (capturer captureStandalone: 3@4) undecorated class).
	self assert: ((shadow slots at: 'corner') slots at: 'x') value = 3.
	self assert: ((shadow slots at: 'corner') slots at: 'y') value = 4.