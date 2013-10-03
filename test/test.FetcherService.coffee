require './'

describe 'FetcherService', ->
		it 'should be crazy', (done)->
			[FetcherService] = requirejs 'FetcherService'
			onResponse = (data) ->
				data.status.should.equal 'OK'
			fService = new FetcherService 1234567890, onResponse
			fService.start()