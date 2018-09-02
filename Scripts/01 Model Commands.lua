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

--[[
	Here's the song table that will contain all the songs.
	The reason why this is a global, is for perfomance concerns.

	Earlier versions of the Played/Total display updated every time an action
	was done in ScreenSelectMusic. (Picking a song, changing difficulty/sort, etc.)
	This resulted on a stutter everytime something happened, which would definetly
	affect the gameplay experience.

	The way it is now, is by making it a global table, which will update every time
	ScreenSelectMusic is opened, and ONLY then.
	This means, that MusicWheelItems don't have to go with the trouble of recalculating
	everything on each update, they already have values to work which come from this table.
--]]
SongGroups = {}

--[[
	What we're going to do, is grab all the song groups, and then
	grab the songs inside of those groups, and check which songs haven't been
	played and which are, to create the Played/Total display.
]]
function DIVA:UpdateSongGroupListing()
	for groupname in ivalues(SONGMAN:GetSongGroupNames()) do
    	local songs = SONGMAN:GetSongsInGroup(groupname) 
    	local NumTotalNew = 0
	    
    	for song in ivalues(songs) do
	        
        	if not PROFILEMAN:IsSongNew(song) then
            	NumTotalNew = NumTotalNew + 1
        	end
	
    	end
	
    	SongGroups[groupname] = { NumTotalNew, #songs }
	end
end

-- This is here in case someone update the theme's scripts.
DIVA:UpdateSongGroupListing()

function DIVA:GroupCompleted(params)
	return SongGroups[params][1].."/"..SongGroups[params][2].." ("..FormatPercentScore( DIVA:CalculatePercentageSongs(params) )..")"
end

function DIVA:GetPathLocation(filepart1,filepart2)
	return "/"..THEME:GetCurrentThemeDirectory().."/Locations/"..filepart1 .. filepart2
end

function DIVA:AbleToPlayRandomSongs()
	return #SONGMAN:GetAllSongs() > 0
end

function DIVA:ResetRandomSong()
	if DIVA_RandomSong and ThemePrefs.Get("EnableRandomSongPlay")then
		if DIVA:AbleToPlayRandomSongs() then
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
		end
    end
end

function DIVA:CalculatePercentageSongs(params)
	return (SongGroups[params][1]/SongGroups[params][2])
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