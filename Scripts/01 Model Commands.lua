-- Main Stepping Revision functions
DIVA = {
	-- Command line debug stuff
	Folder_Random = function()
	Trace(
		"-----------------------------------\n"..
		"New Folder_Random Song: " ..
		DIVA_RandomSong:GetDisplayFullTitle().." - "
		..DIVA_RandomSong:GetDisplayArtist().."\n"..
		"-----------------------------------"
	)
	end,
	SingleSongWarning = function()
	lua.ReportScriptError( "Random Song Play: Current Folder only contains 1 song. StepMania might get confused when picking the song via random. Selecting to index 1.")
	end,
	NoSongsWarning = function()
	lua.ReportScriptError( "Random Song Play: No songs were found in your StepMania install folder! Switching back to fallback music.")
	end,
}

function DIVA:GetPathLocation(filepart1,filepart2)
	return "/"..THEME:GetCurrentThemeDirectory().."/Locations/"..filepart1 .. filepart2
end

function DIVA:AbleToPlayRandomSongs()
	return ThemePrefs.Get("EnableRandomSongPlay") and #SONGMAN:GetAllSongs() > 0
end

function DIVA:ResetRandomSong()
	if DIVA_RandomSong and DIVA:AbleToPlayRandomSongs() then
		if ThemePrefs.Get("FolderToPlayRandomMusic") ~= "All" then
			local Sel = SONGMAN:GetSongsInGroup(ThemePrefs.Get("FolderToPlayRandomMusic"))
			if #Sel > 1 then
				DIVA_RandomSong = Sel[math.random(1,#Sel)]
				DIVA:Folder_Random()
			else
				DIVA_RandomSong = Sel[1]
				DIVA:SingleSongWarning()
			end
		else
			DIVA_RandomSong = SONGMAN:GetRandomSong()
		end
		MESSAGEMAN:Broadcast("DivaSongChanged")
	else
		DIVA:NoSongsWarning()
		DIVA_RandomSong = nil
    end
end

function DIVA:HasSubtitles(WhatToLoad)
	return string.len( WhatToLoad:GetDisplaySubTitle() ) > 1
end

function DIVA:IsSafeToLoad(pn)
	if GAMESTATE:GetCharacter(pn):GetModelPath() ~= "" then return true
	else
		lua.ReportScriptError(
			string.format( THEME:GetString("Common","ModelLoadError"), ToEnumShortString(pn), GAMESTATE:GetCharacter(pn):GetDisplayName() )
		)
		return false
	end
end

function DIVA:HasAnyCharacters(pn)
	return GAMESTATE:IsPlayerEnabled(pn) and GAMESTATE:GetCharacter(pn):GetDisplayName() ~= "default" and DIVA:IsSafeToLoad(pn)
end

function DIVA:BothPlayersEnabled()
	return GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2)
end