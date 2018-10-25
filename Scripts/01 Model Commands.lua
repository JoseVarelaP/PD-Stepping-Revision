-- Main Stepping Revision functions
------------------------------------------------

-- Configuration board by Jousway
Config = {};

-- We don't need the write, just load
function Config.Load(key,file)
	if not FILEMAN:DoesFileExist(file) then return false end
	
	local Container = {}

	local configfile = RageFileUtil.CreateRageFile()
	configfile:Open(file, 1)
	
	local configcontent = configfile:Read()
	
	configfile:Close()
	configfile:destroy()
	
	for line in string.gmatch(configcontent.."\n", "(.-)\n") do
		for KeyVal, Val in string.gmatch(line, "(.-)=(.+)") do
			if key == KeyVal then return Val end
		end		
	end
end

------------------------------------------------
DIVA = {
	------------------------------------------------
	-- Command line debug stuff
	-- They're also to inform the user of certain things.
	------------------------------------------------
	Folder_Random = function()
	Trace(
		"-----------------------------------\n"..
		"New Folder_Random Song: " ..
		getenv("DIVA_RandomSong"):GetDisplayFullTitle().." - "
		..getenv("DIVA_RandomSong"):GetDisplayArtist().."\n"..
		"-----------------------------------"
	)
	end,
	SingleSongWarning = function()
	lua.ReportScriptError( THEME:GetString("Common","SongLoaderSingleSong") )
	end,
	NoSongsWarning = function()
	lua.ReportScriptError( THEME:GetString("Common","SongLoaderNoSongs") )
	end,
	
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
	SongGroups = {};
	TotalForCompletion = {};
}
------------------------------------------------

--[[
	What we're going to do, is grab all the song groups, and then
	grab the songs inside of those groups, and check which songs haven't been
	played and which are, to create the Played/Total display.
]]
function DIVA:UpdateSongGroupListing()
    local TotalEverything = 0
	for groupname in ivalues(SONGMAN:GetSongGroupNames()) do
    	local songs = SONGMAN:GetSongsInGroup(groupname) 
    	local NumTotalNew = 0
	    
    	for song in ivalues(songs) do
	        
        	if not PROFILEMAN:IsSongNew(song) then
            	NumTotalNew = NumTotalNew + 1
            	TotalEverything = TotalEverything + 1
        	end
	
    	end
	
    	DIVA["SongGroups"][groupname] = { NumTotalNew, #songs }
	end
    DIVA["TotalForCompletion"] = { TotalEverything, #SONGMAN:GetAllSongs() }
end

-- This is here in case someone updates the theme's scripts.
-- Cause if updates without it, the global tables reset. Leaving nothing.
-- That can lead to crashes.
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
	local Output = " "
	if GAMESTATE:GetSortOrder() == "SortOrder_Group" then
		Output = DIVA["SongGroups"][params][1].."/"..DIVA["SongGroups"][params][2].." Played ("..FormatPercentScore( DIVA:CalculatePercentageSongs(params) )..")"
	end
	return Output
end

-- Used to retrieve files from the 'Locations' folder.
function DIVA:GetPathLocation(filepart1,filepart2)
	return "/"..THEME:GetCurrentThemeDirectory().."/Locations/"..filepart1 .. filepart2
end

function DIVA:CallCurrentStage()
	return THEME:GetCurrentThemeDirectory().."/Locations/"..ThemePrefs.Get("CurrentStageLocation")
end

-- For all kinds of settings that are boolean based
function DIVA:CheckBooleanOnLocationSetting(setting)
	local filetoload = DIVA:CallCurrentStage().."/ModelConfig.cfg";
	local content = Config.Load(setting,filetoload)
	if content == "true" then return true end
	return false
end

function Actor:xyz(xpos,ypos,zpos)
	self:xy(xpos,ypos):z(zpos)
	return self
end

-- For all kinds of settings that are number based
function DIVA:CheckStageConfigurationNumber(def,conf)
	local result = def or 0
	local filetoload = DIVA:CallCurrentStage().."/ModelConfig.cfg";
	local content = Config.Load(conf,filetoload)
	if content then result = tonumber(content) end
	return result
end

function DIVA:LocationIsSafeToLoad()
	if not FILEMAN:DoesFileExist(DIVA:CallCurrentStage().."/model.txt") then
		lua.ReportScriptError(
			string.format( THEME:GetString("Common","LocationLoadError"), ThemePrefs.Get("CurrentStageLocation"))
			)
		return false
	end
	return true
end

-- Random Song Updater
function DIVA:ResetRandomSong()
	-- We have songs, then we coninue.
	if ThemePrefs.Get("EnableRandomSongPlay") then
		if #SONGMAN:GetAllSongs() > 0 then
			-- If we have it on a set folder, then look at that folder, and pick a random song from it.
			if ThemePrefs.Get("FolderToPlayRandomMusic") ~= "All" then
				local Sel = SONGMAN:GetSongsInGroup(ThemePrefs.Get("FolderToPlayRandomMusic"))
				if #Sel > 1 then
					setenv( "DIVA_RandomSong", Sel[math.random(1,#Sel)] )
					DIVA:Folder_Random()
				else
					-- But if the folder only has 1 song, warn about it, and set it directly to it.
					setenv( "DIVA_RandomSong", Sel[1] )
					DIVA:SingleSongWarning()
				end
			else
				setenv( "DIVA_RandomSong", SONGMAN:GetRandomSong() )
			end
			-- After this is done, send a Update MessageCommand to alert the actors that
			-- the Random song has changed. 
			MESSAGEMAN:Broadcast("DivaSongChanged")
		else
		-- If we don't have any songs, then warn about it.
		DIVA:NoSongsWarning()
		end
    end
end

-- Calculate a 0-1 value.
-- This is used for the Played/Total display.
-- Why not just directly make it calculate the percentage in the function?
-- Because having number values instead of a string is easier to make conditionals.
-- You don't have to make [this == "that"], but instead just [this > val].
-- It ensures better results in case the value goes fucko if it was a string.
function DIVA:CalculatePercentageSongs(params)
	if GAMESTATE:GetSortOrder() == "SortOrder_Group" then
		return (DIVA["SongGroups"][params][1]/DIVA["SongGroups"][params][2])
	end
	return 0
end

-- Just if it has subtitles
function DIVA:HasSubtitles(WhatToLoad)
	return string.len( WhatToLoad:GetDisplaySubTitle() ) > 1
end

function DIVA:CharactersAllowedToSelect()
	return ThemePrefs.Get("DedicatedCharacterShow") and #CHARMAN:GetAllCharacters() > 0
end

-- Check if the current model from the player has any issues.
function DIVA:IsSafeToLoad(pn)
	-- Don't apply the check if we have the character set to "off" (default)
	if GAMESTATE:GetCharacter(pn):GetDisplayName() ~= "default" then
		-- Otherwise, check the model path.
		if GAMESTATE:GetCharacter(pn):GetModelPath() == "" then
			lua.ReportScriptError(
				string.format( THEME:GetString("Common","ModelLoadError"), ToEnumShortString(pn), GAMESTATE:GetCharacter(pn):GetDisplayName() )
			)
			return false
		end
		if GAMESTATE:GetCharacter(pn):GetDanceAnimationPath() == "" or
			GAMESTATE:GetCharacter(pn):GetRestAnimationPath() == "" or 
			GAMESTATE:GetCharacter(pn):GetWarmUpAnimationPath() == ""
			then
			lua.ReportScriptError(
				string.format( THEME:GetString("Common","ModelAnimLoadError"), ToEnumShortString(pn), GAMESTATE:GetCharacter(pn):GetDisplayName() )
			)
			return false
		end
	end
	return true
end

-- Check if the player has any character loaded right now.
function DIVA:HasAnyCharacters(pn)
	return GAMESTATE:IsPlayerEnabled(pn) and GAMESTATE:GetCharacter(pn):GetDisplayName() ~= "default" and DIVA:IsSafeToLoad(pn)
end

-- Self explanatory.
function DIVA:BothPlayersEnabled()
	return GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2)
end

-- Camera utilities
CAMERA = {}
-- some utilities
-- This will reset the camera in case it is needed.
-- It is quite recommended that this is applied on the start of every Camera MessageCommand.
function CAMERA:ResetCamera()
	Camera:rotationy(180):rotationx(0):rotationz(0)
	:z(WideScale(300,400))
	:stopeffect()

	return self
end

function setenv(name,value) GAMESTATE:Env()[name] = value end
function getenv(name) return GAMESTATE:Env()[name] end