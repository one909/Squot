toolbuilder
buildButtons: builder
	^ {
	builder pluggableButtonSpec new
		model: self; 
		label: 'Save and Close';
		action: #actionSaveAndClose.
	builder pluggableButtonSpec new
		model: self; 
		label: 'Cancel';
		action: #actionCancel.
	}