"use strict"
http = require 'http'
print = console.log

class PnrStatus 
	constructor: (@pnr=8216477093, @callback, @interval=10*60*1000) ->
		@url = "http://pnrapi.alagu.net/api/v1.0/pnr/#{@pnr}"
		@continue = true
	
	start: -> 
		me = @	
		http.get me.url,
		(response) -> response.on 'data', 
			(buffer) ->
				(->
					if @continue is true
						@timer = setTimeout (-> me.start()), @interval 
					@callback JSON.parse buffer.toString()					
				).call me
				
	stop: ->
		@continue = false
		clearTimeout @timer

module.exports = PnrStatus