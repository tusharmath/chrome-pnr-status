define ['lodash'], (_) ->
	class ResultsViewModel
		constructor:(data={}, @isVisible=false) ->	
			@passengers = data.passenger
			@chartPrepared = if data.chart_prepared is true then 'YES' else 'NO'
			
			@bookingStatus = if ( _.every data.passenger, (i)-> i.status is 'CNF') is true then 'Confirmed' else 'Not Confirmed'
			
			#Trains
			@trainName =if data.train then data.train_name.toLowerCase() else ''
			@trainNumber = data.train_number
			
			#Stations
			@fromStation = if data.from then data.from.name + " (#{data.from.code})" else ''
			@toStation =if data.to then data.to.name + " (#{data.to.code})" else ''
			@boardingStation = if data.board then data.board.name + " (#{data.board.code})" else ''

			#Time
			@timeStamp = new Date
			@travelDate = data.travel_date
			@timeRemaining = 0
			