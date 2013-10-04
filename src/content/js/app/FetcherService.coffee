#8504436159
define ['app/TimerService', 'app/HttpService'], (TimerService, HttpService) ->

	class FetcherService
		constructor: (@pnrNumber=6712133131, @interval=8000) ->
			#Initialize Timer Service
			timerService = new TimerService @interval

			@stop = ->
				timerService.stop()
			
			@start= (callback) ->
				me = @
				fetch = ->
					callback()
					HttpService.Get "http://www.railpnrapi.com/#{me.pnrNumber}", callback
				timerService.start(fetch)


