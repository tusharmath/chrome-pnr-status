
define ->
	Get : (url, onSuccess, onError) ->
		setTimeout (->onSuccess sampleData), 3000


#Data for special cases
sampleData =
	status: "OK"
	data:
		pnr_number: 1234567890
		train_name: "ERNAKULAM EXP"
		train_number: "12677"
		from:
			name: "Bangalore City"
			code: "SBC"

		to:
			name: "Coimbatore Jn."
			code: "CBE"

		alight:
			name: "Coimbatore Jn."
			code: "CBE"

		board:
			name: "Bangalore City"
			code: "SBC"

		class: "2S"
		travel_date: "2-6-2011"
		passenger: [
			seat_number: "D8, 31,GN"
			status: "CNF"
		,
			seat_number: "D8, 32,GN"
			status: "CNF"
		]
		chart_prepared: false
