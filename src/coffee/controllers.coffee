PNR_Fetcher = require './js/PnrFetcher'
PNR_Status = require './js/PnrStatusModel'
_ = require 'underscore'

_LivePnrController = ($scope)->
	$scope.isWorking = false
	$scope.ResultView =
		isLoaded: false

	$scope.SubmitView = 
		button_value: "Start Fetching"
		button_class: "btn-primary"
		pnrNumber: 8616415262
		formSubmit: ->
			$scope.isWorking = not $scope.isWorking

			if $scope.isWorking is true
				$scope.SubmitView.button_class = "btn-warning"
				$scope.SubmitView.button_value = "Stop Fetching"
				$scope.pnr = new PNR_Fetcher $scope.SubmitView.pnrNumber, (result)->
					#know more: http://docs.angularjs.org/api/ng.$rootScope.Scope#$apply

					if(result.status is 'INVALID')
						$scope.SubmitView.button_class = "btn-primary"
						$scope.SubmitView.button_value = "Invalid PNR, Try Again"
					if _.size(result.data) > 0
						$scope.$apply ->
							$scope.ResultView = new PNR_Status result.data
							$scope.ResultView.isLoaded = true
					else if $scope.ResultView.isLoaded is false
						$scope.SubmitView.button_class = "btn-primary"
						$scope.SubmitView.button_value = "Try Again"
				
				$scope.pnr.start()
			else
				$scope.SubmitView.button_class = "btn-primary"
				$scope.SubmitView.button_value = "Start Fetching"
				$scope.pnr.stop()	
		
window.LivePnrController = _LivePnrController