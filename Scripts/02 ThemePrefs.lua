function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end

--[[
	Range system from Simply Love by dbk2. Really useful stuff.

	Documentation:
	range() accepts one, two, or three arguments and returns a table
	Example Usage:
	
	range(4)			--> {1, 2, 3, 4}
	range(4, 7)		--> {4, 5, 6, 7}
	range(5, 27, 5) 	--> {5, 10, 15, 20, 25}
	
	either of these are acceptable
	range(-1,-3, 0.5)	--> {-1, -1.5, -2, -2.5, -3 }
	range(-1,-3, -0.5)	--> {-1, -1.5, -2, -2.5, -3 }
	
	but this just doens't make sense and will return an empty table
	range(1, 3, -0.5)	--> {}
]]

function range(start, stop, step)
	if start == nil then return end

	if not stop then
		stop = start
		start = 1
	end

	step = step or (start < stop and 1 or -1)

	-- if step has been explicitly provided as a positve number
	-- but the start and stop values tell us to decrement
	-- multiply step by -1 to allow decrementing to occur
	if step > 0 and start > stop then
		step = -1 * step
	end

	local t = {}
	while start < stop+step do
		t[#t+1] = start
		start = start + step
	end
	return t
end

-- Perserved for future work
--[[
local function ReturnCharacterNames()
	local CharacterNamesTable = {}

	for i=1,table.getn(CHARMAN:GetAllCharacters()) do
		table.insert(CharacterNamesTable, CHARMAN:GetAllCharacters()[i]:GetDisplayName())
	end

	return CharacterNamesTable
end

local function ReturnCharacterIDs()
	local TableToReturn = {}

	for i=1,table.getn(CHARMAN:GetAllCharacters()) do
		table.insert(TableToReturn, CHARMAN:GetAllCharacters()[i]:GetCharacterID())
	end

	return TableToReturn
end
--]]

function MusicFolder_AddChoices(n)
	local TableToReturn = {}

	for i=1,table.getn(SONGMAN:GetSongGroupNames()) do
		table.insert(TableToReturn, SONGMAN:GetSongGroupNames()[i])
	end

	table.insert(TableToReturn, "All");

	if TableToReturn ~= nil then
		if n == nil then
			return TableToReturn;
		else
			return TableToReturn[n];
		end
	else
		return
	end
end

LOADER = {}

function LOADER:LoadStages()
	local TableToReturn = FILEMAN:GetDirListing( THEME:GetCurrentThemeDirectory().."/Locations/", true, false )

	return TableToReturn
end

function LOADER:LoadStageNames()
	local ResultTable = {}
	local file = RageFileUtil.CreateRageFile()
	local Directory = FILEMAN:GetDirListing( THEME:GetCurrentThemeDirectory().."/Locations/", true, false )

	for i=1,#Directory do
		local filetoload = THEME:GetCurrentThemeDirectory().."/Locations/"..Directory[i].."/LocationName.nam"
		if FILEMAN:DoesFileExist(filetoload) then
			file:Open(THEME:GetCurrentThemeDirectory().."/Locations/"..Directory[i].."/LocationName.nam", 1)
			local content = file:Read()
			table.insert(ResultTable, content)
			file:Close()
		end
	end
	file:destroy()

	return ResultTable
end

-- Now let's start adding the options
Prefs =
{
	AllowMultipleModels =
	{
		Default = false,
		Choices = { OptionNameString("Off"), OptionNameString("On") },
		Values = { false, true },
	},

	ModelsInRoom =
	{
		Default = 1,
		Choices = range(5),
		Values = range(5),
	},

	CurrentStageLighting =
	{
		Default = "Day",
		Choices = { OptionNameString("Auto"), OptionNameString("Day"), OptionNameString("Night") },
		Values = { "Auto", "Day", "Night" },
	},

	CurrentStageLocation =
	{
		Default = "None",
		Choices = LOADER:LoadStageNames(),
		Values = LOADER:LoadStages(),
	},

	DedicatedCharacterShow =
	{
		Default = false,
		Choices = { OptionNameString("Off"), OptionNameString("On") },
		Values = { false,true },
	},

	-- Dedicated character settings
	DediModelBPM =
	{
		Default = false,
		Choices = { OptionNameString("Off"), OptionNameString("On") },
		Values = { false,true },
	},
	DediSongData =
	{
		Default = false,
		Choices = { OptionNameString("Off"), OptionNameString("On") },
		Values = { false,true },
	},
	DediMeasureCamera =
	{
		Default = 2,
		Choices = range(4),
		Values = range(4),
	},

	-- Some other stuff
	EnableRandomSongPlay =
	{
		Default = false,
		Choices = { OptionNameString("Off"), OptionNameString("On") },
		Values = { false,true },
	},

	ShowRandomSongBackground =
	{
		Default = false,
		Choices = { OptionNameString("Off"), OptionNameString("On") },
		Values = { false,true },
	},

	FolderToPlayRandomMusic =
	{
		Default = MusicFolder_AddChoices(1),
		Choices = MusicFolder_AddChoices(),
		Values = MusicFolder_AddChoices(),
	},
}

ThemePrefs.InitAll(Prefs)