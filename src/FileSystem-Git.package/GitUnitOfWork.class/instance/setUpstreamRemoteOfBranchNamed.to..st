remotes
setUpstreamRemoteOfBranchNamed: branchName to: remoteName
	^ self configAt: 'branch.', branchName, '.remote' put: remoteName