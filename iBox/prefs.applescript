property selecmonitor : "1"
property defaultLocation : ""

on clicked theObject
	if name of theObject is "closepref" then
		getSettingsFromUI()
		writeSettings()
		hide window "Pr�f�rences"
		show window "home"
	else if name of theObject is "prefvideo" then
		set can choose directories of open panel to true
		set can choose files of open panel to false
		display open panel attached to window "Pr�f�rences"
	end if
end clicked

on panel ended theObject with result withResult
	if withResult is 1 then
		set theFolder to item 1 of (path names of open panel as list)
	else if withResult is 0 then
		tell user defaults
			set theFolder to contents of default entry "defaultLocation"
		end tell
	end if
	set contents of text field "cheminvideo" of window "Pr�f�rences" to theFolder as string
end panel ended

on opened theObject
	readSettings()
	setSettingsInUI()
end opened

on getSettingsFromUI()
	tell window "Pr�f�rences"
		set defaultLocation to contents of text field "cheminvideo"
	end tell
end getSettingsFromUI

on setSettingsInUI()
	tell window "Pr�f�rences"
		set contents of text field "cheminvideo" to defaultLocation
	end tell
end setSettingsInUI

on readSettings()
	tell user defaults
		set defaultLocation to contents of default entry "defaultLocation"
	end tell
end readSettings

on writeSettings()
	tell user defaults
		set contents of default entry "defaultLocation" to defaultLocation
	end tell
end writeSettings
