define ['app/FetcherService'], (FetecherService) ->
	class SubmitViewModel
		constructor:(callback, @pnrNumber=1234567890) ->
			
			@started = false
			@loading = false
			
			fService = new FetecherService Number(@pnrNumber)

					
			@submit=->	
				@loading true

				me = @
				onResponse = (response) ->
					
					if response
						me.loading false
						callback response	
					else 
						me.loading true

				if @started() is false 
					fService.start onResponse
				else 
					fService.stop()
				@started not @started()