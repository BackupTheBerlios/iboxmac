property theDataSource : null
property posixvideo : ""

on clicked theObject
	if name of theObject is "home" then
		show window "home"
		hide window "VLC"
	else if name of theObject is "stop" then
		tell application "VLC"
			stop
		end tell
	else if name of theObject is "suivant" then
		tell application "VLC"
			next
		end tell
	else if name of theObject is "precedant" then
		tell application "VLC"
			previous
		end tell
	else if name of theObject is "play" then
		tell application "VLC"
			play
			activate
		end tell
	end if
end clicked

on opened theObject
	set draws background of scroll view "listecatvideo" of window "VLC" to false
	set theDataSource to make new data source at end of data sources with properties {name:"listecatvideo"}
	tell theDataSource
		make new data column at end of data columns of theDataSource with properties {name:"categorie"}
	end tell
	tell user defaults
		set posixvideo to contents of default entry "defaultLocation"
	end tell
	set posixx to modPath(posixvideo)
	set posixvideos to list folder posixx without invisibles
	set tabledatavideo to posixvideos
	tell theDataSource
		append theDataSource with tabledatavideo
	end tell
	set data source of table view "listecatvideo" of scroll view "listecatvideo" of window "VLC" to theDataSource
	tell table view "listecatvideo" of scroll view "listecatvideo" of window "VLC" to update
end opened

on selection changed theObject
	if name of theObject is "listecatvideo" then
		set theWindow to window of theObject
		set selectedDataRows to selected data rows of theObject
		if (count of selectedDataRows) = 0 then
			my nonligne(theWindow)
		else
			my uneligne(theWindow, item 1 of selectedDataRows)
		end if
	end if
end selection changed

on modPath(x)
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to "/"
	set i to count text item of x
	set neue to ""
	repeat with j from 2 to i
		set neue to neue & (text item j of x) & ":"
	end repeat
	set AppleScript's text item delimiters to oldDelimiters
	if neue starts with "Volumes:" then
		set oldDelimiterss to AppleScript's text item delimiters
		set AppleScript's text item delimiters to "Volumes:"
		get last text item of neue
		set neues to the result
		set AppleScript's text item delimiters to oldDelimiterss
	else if neue starts with "Users:" then
		tell application "Finder"
			get name of startup disk
			set neueuser to result
		end tell
		set neues to neueuser & ":" & neue
	else if neue ends with ":" then
		tell application "Finder"
			get name of startup disk
			set testtt to result
		end tell
		set neues to testtt & ":" & neue
	end if
	return neues
end modPath

on uneligne(theWindow, theRow)
	set posixxx to modPath(posixvideo)
	tell theWindow
		set pouetet to contents of data cell "categorie" of theRow
	end tell
	set trucmuche to (posixxx & pouetet & ":")
	set posixvideoss to list folder trucmuche without invisibles
	set catfilmDataSource to make new data source at end of data sources with properties {name:"catfilm"}
	tell catfilmDataSource
		make new data column at end of data columns of catfilmDataSource with properties {name:"films"}
	end tell
	tell catfilmDataSource
		append catfilmDataSource with posixvideoss
	end tell
	set data source of table view "catfilm" of scroll view "catfilm" of window "VLC" to catfilmDataSource
	tell table view "catfilm" of scroll view "catfilm" of window "VLC" to update
end uneligne