as yet unclassified
printOn: aStream
	super printOn: aStream.
	aStream nextPut: $(;
		print: path asString;
		nextPut: $).