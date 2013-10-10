requirejs.config 
	baseUrl: "content/js/lib"
	shim:
		bootstrap: 
			deps: ['jquery']
	paths: 
		app: "../app"

require [
			'app/SubmitViewModel'
			'app/ResultsViewModel'
			'app/ViewUtil'
			'jquery'
			'bootstrap'
	],
	(SubmitViewModel, ResultsViewModel, ViewUtil, $) ->
		
		$(document).ready ->
			$('body').fadeIn 1000

		

		views = new ViewUtil

		onResponse = (response) ->			
			views.updateView new ResultsViewModel(response, true), resultsView

				
		#Binding Submit View
		submitView = views.bindView new SubmitViewModel(onResponse), 'SubmitView'
		resultsView = views.bindView new ResultsViewModel, 'ResultsView'

