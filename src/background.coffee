height = 600
width = 300

chrome.app.runtime.onLaunched.addListener ->
	chrome.app.window.create "window.html",
		bounds:
			height: height
			width: width
		resizable: false