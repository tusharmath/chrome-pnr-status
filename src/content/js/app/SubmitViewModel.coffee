define ['app/FetcherService'], (FetecherService) ->
	class SubmitViewModel
		constructor:(callback, @pnrNumber) ->
			
			@started = false
			@loading = false
			
			fService = new FetecherService
					
			@submit=->	
				return if not @pnrNumber()

				@loading true

				me = @
				onResponse = (response) ->
					
					if response
						me.loading false
						callback response	
					else 
						me.loading true

				if @started() is false 
					
					fService.start @pnrNumber(), onResponse
				else 
					fService.stop()
				@started not @started()