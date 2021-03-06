configuration
configSubkeysAt: aNameString
	| subNames hierarchicalSectionNames relevantSections |
	self ensureConfigOr: [^ #()].
	hierarchicalSectionNames := config sections collect:
		[:each | repository configPartsFromSectionLabel: each label].
	subNames := aNameString splitBy: '.'.
	relevantSections := hierarchicalSectionNames select: [:each |
		each size >= subNames size
			and: [each beginsWith: subNames]].
	^ (relevantSections gather: [:sectionParts |
		sectionParts = subNames
			ifTrue: [(config section: (self configSectionLabelFromParts: sectionParts))
					associations collect: [:each | each key]]
			ifFalse: [{sectionParts at: subNames size + 1}]]) asSet asArray