define ->
	class TimerService
		constructor: ( @interval) ->
			timer = {}
			@start=(callback) ->
				timer = setInterval callback, @interval
				callback()
			@stop= ->
				clearInterval timer

