#8504436159
define ['app/TimerService', 'app/HttpService'], (TimerService, HttpService) ->

	class FetcherService
		constructor: (@interval=1000*30) ->
			#Initialize Timer Service
			timerService = new TimerService @interval

			@stop = ->
				timerService.stop()
			
			@start= (pnrNumber=6712133131, callback) ->
				me = @
				fetch = ->
					callback()
					HttpService.Get "http://www.railpnrapi.com/#{pnrNumber}", callback
				timerService.start(fetch)


