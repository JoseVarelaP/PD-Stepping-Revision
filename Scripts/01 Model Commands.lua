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

--[[ 
	Now that we have all the data needed to show the Played/Total display,
	It's time to put it on a string.
	The function basically reads:

	SongGroups[Name Of The Group][ Total Songs Played ] / SongGroups[Name Of The Group][ Total Songs in Folder ]

	And then CalculatePercentageSongs() will calculate a 0-1 range that FormatPercentScore will convert into
	a full percentage, to show how much you have progressed on that particular folder.
]]
function DIVA:GroupCompleted(params)
	return SongGroups[params][1].."/"..SongGroups[params][2].." ("..FormatPercentScore( DIVA:CalculatePercentageSongs(params) )..")"
end

-- Used to retrieve files from the 'Locations' folder.
function DIVA:GetPathLocation(filepart1,filepart2)
	return "/"..THEME:GetCurrentThemeDirectory().."/Locations/"..filepart1 .. filepart2
end

function DIVA:AbleToPlayRandomSongs()
	return #SONGMAN:GetAllSongs() > 0
end

-- Random Song Updater
function DIVA:ResetRandomSong()
	-- We have songs, then we coninue.
	if ThemePrefs.Get("EnableRandomSongPlay") and DIVA:AbleToPlayRandomSongs() then
		-- If we have it on a set folder, then look at that folder, and pick a random song from it.
		if ThemePrefs.Get("FolderToPlayRandomMusic") ~= "All" then
			local Sel = SONGMAN:GetSongsInGroup(ThemePrefs.Get("FolderToPlayRandomMusic"))
			if #Sel > 1 then
				DIVA_RandomSong = Sel[math.random(1,#Sel)]
				DIVA:Folder_Random()
			else
				-- But if the folder only has 1 song, warn about it, and set it directly to it.
				DIVA_RandomSong = Sel[1]
				DIVA:SingleSongWarning()
			end
		else
			DIVA_RandomSong = SONGMAN:GetRandomSong()
		end
		-- After this is done, send a Update MessageCommand to alert the actors that
		-- the Random song has changed. 
		MESSAGEMAN:Broadcast("DivaSongChanged")
	else
		-- If we don't have any songs, then warn about it.
		DIVA:NoSongsWarning()
    end
end

-- Calculate a 0-1 value.
-- This is used for the Played/Total display.
function DIVA:CalculatePercentageSongs(params)
	return (SongGroups[params][1]/SongGroups[params][2])
end

-- Just if it has subtitles
function DIVA:HasSubtitles(WhatToLoad)
	return string.len( WhatToLoad:GetDisplaySubTitle() ) > 1
end

-- Check if the current model from the player has any issues.
function DIVA:IsSafeToLoad(pn)
	-- Don't apply the check if we have the character set to "off" (default)
	if GAMESTATE:GetCharacter(pn):GetDisplayName() ~= "default" then
		-- Otherwise, check the model path.
		if GAMESTATE:GetCharacter(pn):GetModelPath() ~= "" then return true
		else
			lua.ReportScriptError(
				string.format( THEME:GetString("Common","ModelLoadError"), ToEnumShortString(pn), GAMESTATE:GetCharacter(pn):GetDisplayName() )
			)
			return false
		end
	end
end

-- Check if the player has any character loaded right now.
function DIVA:HasAnyCharacters(pn)
	return GAMESTATE:IsPlayerEnabled(pn) and GAMESTATE:GetCharacter(pn):GetDisplayName() ~= "default" and DIVA:IsSafeToLoad(pn)
end

-- Self explanatory.
function DIVA:BothPlayersEnabled()
	return GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2)
end