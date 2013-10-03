require './'

describe 'Timer Service', ->
		it 'should have start and stop', ->
			[TimerService] = requirejs 'TimerService'
			dummyCallback = ->
			tservice = new TimerService dummyCallback, 56734
			console.log tservice
			tservice.callback.should.equal dummyCallback
			tservice.interval.should.equal 56734
			