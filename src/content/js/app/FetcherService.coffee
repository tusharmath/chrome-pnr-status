define ['app/TimerService', 'app/HttpService'], (TimerService, HttpService) ->

	class FetcherService
		constructor: (@pnrNumber=1234567890, @interval=8000) ->
			#Initialize Timer Service
			timerService = new TimerService @interval

			@stop = ->
				timerService.stop()
			
			@start= (callback) ->
				fetch = ->
					callback()
					HttpService.Get 'http://randomapiurl/#{me.pnrNumber}', callback
				timerService.start(fetch)


