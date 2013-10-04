requirejs.config 
	baseUrl: "content/js/lib"
	paths: 
		app: "../app"

require [
			'app/SubmitViewModel'
			'app/ResultsViewModel'
			'app/ViewUtil'
	],
	(SubmitViewModel, ResultsViewModel, ViewUtil) ->
		
		views = new ViewUtil

		onResponse = (response) ->
			console.log response
			
			views.updateView new ResultsViewModel(response, true), resultsView

				
		#Binding Submit View
		submitView = views.bindView new SubmitViewModel(onResponse), 'SubmitView'
		resultsView = views.bindView new ResultsViewModel, 'ResultsView'


