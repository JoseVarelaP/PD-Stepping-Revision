DEDICHAR = {};

-- This will check if the current stage is able to change its lighting cycle.
-- Not all locations can do this, so doing this will save space.
function DEDICHAR:Load_Appropiate_Material()
	local ToFind = "/main_material.txt"
	if DIVA:CheckBooleanOnLocationSetting("AbleToChangeLight") then
		ToFind = "/"..FuturaToLoad.."_material.txt"
	end
	return DIVA:GetPathLocation("",ThemePrefs.Get("CurrentStageLocation")..ToFind);
end

function DEDICHAR:CameraRandom()
	if NumCam and StageHasCamera then
		if DIVA:CheckBooleanOnLocationSetting("IsCameraTweenSequential") then
			if CurrentStageCamera > NumCam then
				CurrentStageCamera = 1
			end
			return CurrentStageCamera
		end
		return ( NumCam > 1 and math.random(1, NumCam ) ) or NumCam
	end
	return math.random(1,5)
end

function DEDICHAR:SetTimingData()
	setenv("song", 	GAMESTATE:GetCurrentSong() )
	setenv("start", getenv("song"):GetFirstBeat() )
	setenv("now",	GAMESTATE:GetSongBeat() )
end

function DEDICHAR:UpdateModelRate()
	-- The real kicker, recreating SM's true tempo updater.
	-- StepMania always kept a rate of 0.75 to 1.5, I wanted to break it a little bit more.

	-- These are options
	local RangeMax = ThemePrefs.Get("ModelRateBPMMax")
	local RangeLow = ThemePrefs.Get("ModelRateBPMLow")
	local MultiMax = ThemePrefs.Get("ModelRateMulMax")
	local MultiLow = ThemePrefs.Get("ModelRateMulLow")
	
	-- In case the song is on a rate, then we can multiply it.
	-- It also checks for the song's Haste, if you're using that.
	-- Safe check in case Obtaining HasteRate fails
	local MusicRate = 1
	if SCREENMAN:GetTopScreen() and SCREENMAN:GetTopScreen():GetHasteRate() then
		MusicRate = SCREENMAN:GetTopScreen():GetHasteRate()
	end
	local BPM = (GAMESTATE:GetSongBPS()*60)
	
	-- We're using scale to compare higher values with lower values.
	local UpdateScale = scale( BPM, RangeLow, RangeMax, MultiLow, MultiMax );

	-- Then clamp it so it's on a max and a low ammount
	local Clamped = clamp( UpdateScale, 0.5, 2.5 );

	-- Then take what we have and update depending on the music rate.
	local ToConvert = Clamped*MusicRate
	local SPos = GAMESTATE:GetSongPosition()

	if not SPos:GetFreeze() and not SPos:GetDelay() then
		return ToConvert
	end
	return 0
end

--[[
	This function is quite literally for one specific thing.
	That thing being Baby-Lon. I was mentioned about this specific model,
	being too big from its original size, so this function checks who has Baby-Lon.
	And if it does, we can do a model size shrink to that player.
]]
function DEDICHAR:HasBabyCharacter(pn)
	return GAMESTATE:IsPlayerEnabled(pn) and string.find(GAMESTATE:GetCharacter(pn):GetDisplayName(), "Baby") and DIVA:IsSafeToLoad(pn)
end