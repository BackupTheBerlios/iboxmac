property playlistsDataSource : null

on clicked theObject
	if name of theObject is "home" then
		show window "home"
		hide window "zic"
	else if name of theObject is "playpause" then
		tell application "iTunes"
			playpause
		end tell
	else if name of theObject is "precedant" then
		tell application "iTunes"
			previous track
		end tell
	else if name of theObject is "suivant" then
		tell application "iTunes"
			next track
		end tell
	else if name of theObject is "stop" then
		tell application "iTunes"
			stop
		end tell
	else if name of theObject is "suivantt" then
		tell application "iTunes"
			fast forward
		end tell
	else if name of theObject is "precedantt" then
		tell application "iTunes"
			rewind
		end tell
	else if name of theObject is "visuel" then
		tell application "iTunes"
			set full screen to 1
			set visuals enabled to 1
		end tell
	else if name of theObject is "localplaylist" then
		set contents of text field "textplaylist" of window "zic" to "Playlist iBox"
		tell application "iTunes"
			set choix to the name of every playlist
		end tell
		my localplaylist(choix)
	else if name of theObject is "cd" then
		set contents of text field "textplaylist" of window "zic" to "CD"
		try
			tell application "iTunes"
				set myCD to the name of (sources whose kind is audio CD)
				set choix to myCD
			end tell
			my localplaylist(choix)
		on error
			set choix to "pas de CD" as list
			my localplaylist(choix)
		end try
	else if name of theObject is "sharedplaylist" then
		set contents of text field "textplaylist" of window "zic" to "Playlist Partagée"
		try
			tell application "iTunes"
				set myshared to the name of (sources whose kind is shared library)
				set choix to myshared
			end tell
			my localplaylist(choix)
		on error
			set choix to "pas de Musique partagées" as list
			my localplaylist(choix)
		end try
	end if
end clicked

on opened theObject
	
end opened

on localplaylist(choix)
	set playlistsDataSource to make new data source at end of data sources with properties {name:"playlists"}
	tell playlistsDataSource
		make new data column at end of data columns of playlistsDataSource with properties {name:"Playlists"}
	end tell
	tell playlistsDataSource
		append playlistsDataSource with choix
	end tell
	set data source of table view "playlists" of scroll view "playlists" of window "zic" to playlistsDataSource
	tell table view "playlists" of scroll view "playlists" of window "zic" to update
end localplaylist