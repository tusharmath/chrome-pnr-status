m = require 'moment'
_ = require 'underscore'

class PnrStatusModel
	constructor: (data)->
		@chartPrepared = if data.chart_prepared is true then "Yes" else "No"

		#Train
		@trainNumber = data.train_number
		@trainName = data.train_name.toLowerCase()
		
		#Times
		@departureDate = m(data.travel_date.date, 'DD-MM-YYYY').format('DD-MMM-YYYY')
		@departureTime = m(data.from.time, 'HH:mm').format('hh:mm A')
		@arrivalTime = m(data.to.time, 'HH:mm').format('hh:mm A')
		@timeStamp = m().format('DD-MMM-YYYY, hh:mm A')
		
		#Places
		@boardingStation = data.board.name.toLowerCase()
		@fromStation = data.from.name.toLowerCase()
		@toStation = data.to.name.toLowerCase()

		#Ticket
		@class = data.class
		@passengers = data.passenger.map (p) -> seatNumber : p.seat_number, status : p.status
		
		if (_.every data.passenger, (p) -> p.seat_number.indexOf('Confirmed') > -1) is true
			@currentStatus = "Confirmed"
		else 
			@currentStatus = "Not Confirmed"
		console.log @
module.exports = PnrStatusModel		