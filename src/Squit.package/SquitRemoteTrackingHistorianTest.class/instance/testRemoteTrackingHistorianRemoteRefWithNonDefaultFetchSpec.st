tests
testRemoteTrackingHistorianRemoteRefWithNonDefaultFetchSpec
	| remoteTrackingHistorian |
	remoteTrackingHistorian := self createRemoteTrackingBranchForMasterWithFetchSpec: '+refs/heads/extra/*:refs/remotes/myremote/*'.
	self assert: remoteTrackingHistorian remoteRef name = 'refs/heads/extra/master'.