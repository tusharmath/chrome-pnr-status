requirejs.config 
	baseUrl: "content/js/lib"
	paths: 
		app: "../app"

require [
			'komapping'
			'knockout'
			'app/SubmitViewModel'
			'app/ResultsViewModel'
	],
	(komapping, ko, SubmitViewModel, ResultsViewModel) ->
		

		#Generic Function
		ko.mapping = komapping
		ko.applyBindingsTo = (model, id) ->
			ko.applyBindings model, document.getElementById id


		#Binding Submit SubmitViewModel
		resultsView = false
		onResponse = (response) ->
			console.log response
			resultsViewData = new ResultsViewModel response.data	
			if not resultsView
				resultsView = ko.mapping.fromJS resultsViewData
				ko.applyBindingsTo resultsView, 'ResultsView'
			else
				ko.mapping.fromJS resultsViewData, resultsView
				

		submitView = ko.mapping.fromJS new SubmitViewModel(onResponse)
		ko.applyBindingsTo submitView, 'SubmitView'



