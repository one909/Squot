*Squot-Tools
browse
	^ (MCSnapshotBrowser forSnapshot: (MCSnapshot fromDefinitions: {self}))
		categorySelection: 1;
		classSelection: 1;
		protocolSelection: 1;
		methodSelection: 1;
		showLabelled: 'Snapshot of ', self summary