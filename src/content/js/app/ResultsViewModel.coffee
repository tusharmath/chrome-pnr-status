define ['lodash'], (_) ->
	class ResultsViewModel
		constructor:(data={}, @isVisible=false) ->	
			@passengers = data.pax
			@chartPrepared = if data.charted is true then 'Yes' else 'No'
			
			@bookingStatus = if ( _.every data.pax, (i)-> i.status is 'CNF') is true then 'Confirmed' else 'Not Confirmed'
			
			#Trains
			@trainName =if data.tname then data.tname.toLowerCase() else ''
			@trainNumber = data.tnum
			
			#Stations
			@fromStation = data.from
			@toStation = data.to
			#Time
			@timeStamp = new Date
			@travelDate = data.tdate
			