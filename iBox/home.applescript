global latest_album

on clicked theObject
	if name of theObject is "vlcicone" then
		show window "VLC" (*ouverture de la fenêtre Vidéo*)
		hide window "home" (*fermeture de la fenêtre Principale*)
	else if name of theObject is "zic" then
		show window "zic" (*ouverture de la fenêtre Music*)
		hide window "home" (*fermeture de la fenêtre Principale*)
	else if name of theObject is "jeux" then
		show window "jeux" (*ouverture de la fenêtre Jeux*)
		hide window "home" (*fermeture de la fenêtre Principale*)
	else if name of theObject is "testscreen" then
		set window "home" to (call method "beginFullScreen")
	else if name of theObject is "testscreen2" then
		set window "home" to (call method "endFullScreen")
	end if
end clicked

on launched theObject
	tell application "iTunes" (*Lancement d'iTunes*)
		run
	end tell
	tell application "VLC" (*Lancement de VLC*)
		run
	end tell
	tell application "Finder"
		--	set visible of every process whose name is not "iBox" to false (*seul iBox reste visible à l'écran*)
	end tell
end launched

on will finish launching theObject
	registerSettings()
end will finish launching

on choose menu item menupref
	show window "Préférences" (*ouverture de la fenêtre Préférence*)
	hide window "home"
end choose menu item

on idle theObject
	set TrackName to "iTunes n'est pas en lecture"
	set TrackArtist to ""
	set TrackAlbum to ""
	set Trackdure to ""
	set pic to "itunes"
	tell application "iTunes"
		if the player state = playing then
			set theTrack to current track
			set PlayButtonTitle to 1
			if the name of theTrack exists then
				set TrackName to the name of theTrack
			else
				set TrackName to "iTunes n'est pas en lecture"
			end if
			if the artist of theTrack exists then
				set TrackArtist to the artist of theTrack
			else
				set TrackArtist to ""
			end if
			if the album of theTrack exists then
				set TrackAlbum to the album of theTrack
			else
				set TrackAlbum to ""
			end if
			if duration of theTrack exists then
				set Trackdure to duration of theTrack
			else
				set Trackdure to ""
			end if
			if artworks of theTrack exists then
				set picdata to data of front artwork of theTrack
				if the current track's database ID is not my latest_album then
					set my latest_album to the current track's database ID
					tell application "Finder"
						set fileName to ":tmp:artwork2avatar.pict" as string
						try
							do shell script "rm /tmp/artwork2avatar.pict"
						end try
						open for access fileName write permission 1
						copy the result to fileReference
						write picdata starting at 0 to fileReference as picture
						close access fileReference
					end tell
				end if
				set pic to "/tmp/artwork2avatar.pict"
			else
				set pic to "itunes"
			end if
		else
			set PlayButtonTitle to 0
		end if
	end tell
	delete image of image view "itunes" of window "zic"
	set image of image view "itunes" of window "zic" to load image pic
	set state of button "playpause" of window "zic" to PlayButtonTitle
	set contents of text field "ttitre" of window "zic" to TrackName
	set contents of text field "tartiste" of window "zic" to TrackArtist
	set contents of text field "talbum" of window "zic" to TrackAlbum
	set contents of text field "tdure" of window "zic" to Trackdure
	return 2
end idle

on awake from nib theObject
	set latest_album to 0
end awake from nib

on registerSettings()
	tell application "Finder"
		set thePathdefault to path to movies folder
	end tell
	set posixthePathdefault to POSIX path of thePathdefault
	set oldDelimitersss to AppleScript's text item delimiters
	set AppleScript's text item delimiters to "/"
	set utilisateur to text item 2 of posixthePathdefault
	set nomutilisateur to text item 3 of posixthePathdefault
	set foldermovies to text item 4 of posixthePathdefault
	set AppleScript's text item delimiters to oldDelimitersss
	set correctchemin to "/" & utilisateur & "/" & nomutilisateur & "/" & foldermovies
	tell user defaults
		make new default entry at end of default entries with properties {name:"defaultLocation", contents:correctchemin}
		register
	end tell
end registerSettings
