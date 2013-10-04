
define ->
	Get : (url, onSuccess) ->	
		xhr = new XMLHttpRequest
		handleStateChange = (a,b,c)->
			if xhr.readyState is 4
				onSuccess JSON.parse xhr.responseText
		xhr.onreadystatechange = handleStateChange
		xhr.open("GET", url, true);
		xhr.send();