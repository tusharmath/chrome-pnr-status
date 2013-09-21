PnrStatus = require './js/GetPnr'

window.LivePnrController = ($scope)->
	$scope.SubmitView = 
		pnrNumber :  8616415262
		status: "idle"
		formSubmit: ->
			sview = $scope.SubmitView
			pnr = new PnrStatus sview.pnrNumber, (result)->
				$scope.$apply -> $scope.ResultView = result.data
				alert 'data received'
			pnr.start()
	$scope.ResultView = {}
