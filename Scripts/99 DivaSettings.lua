-- a simple target
-- make as less lines as possible on the metrics

-- it's that simple of an objective

DSet = {
	ThemeSetting = function(name) return "lua,ThemePrefRow('"..name.."')" end,
	
	Shared = {
		ScrollOn = function(self)
			self:maxwidth(180):zoom( WideScale(0.5,0.7) )
			:addx(-300):decelerate(0.2):addx(300)
		end,
		ScrollOff = function(self)
			self:accelerate(0.2):addx(-300)
		end,

		ExpX = function() return SCREEN_RIGHT-310 end,
		ExpY = function() return SCREEN_CENTER_Y-50 end,
		ExpOn = function(self)
		self:wrapwidthpixels(370):horizalign(left):zoom(0.6)
		:vertalign(top):diffusealpha(0):sleep(1)
		:linear(0.1):diffusealpha(1)
		end,
		ExpOff = function(self) self:accelerate(0.2):diffusealpha(0) end,
	},
	TitleMenu = {
		ScrollerTransform = function(self,offset,itemIndex,numItems)
			self:y((70)*(itemIndex-(numItems-1)/2))
			self:x(10*offset)
		end,
		LineNames = function()
		local Result = ''

		Result = Result .. "GameStart,"
		Result = Result .. "QuickPlay,"
		Result = Result .. "Options,"
		Result = Result .. "Edit,"
		Result = Result .. "Jukebox,"
		Result = Result .. "Exit,"

		return Result
		end,
		ChoiceQuickPlay = function()
		return "applydefaultoptions;screen,ScreenSelectMusic;style,single;text,QuickPlay"
		end,
		ScrollOn = function(self)
			self:zoom(0.7):addx(-300):decelerate(0.3):addx(300)
		end,
		ScrollOff = function(self)
			self:accelerate(0.2):addx(-300)
		end,
	},
	ScreenOptionsService = {
		NumRowsShown = function() return 7 end,
		LineNames = function()
		local Result = ''
		
		Result = Result .. "GameType," -- Select Game
		Result = Result .. "GraphicSound," -- Graphics/Sound Options
		Result = Result .. "KeyConfig," -- Key Configuration
		Result = Result .. "InputOptions," -- Input
		Result = Result .. "SoundGraphics," -- Display Options
		Result = Result .. "Profiles," -- obvs
		Result = Result .. "Advanced," -- advanced shit yo
		Result = Result .. "Theme," -- The Project Diva: Stepping Revision Settings
		Result = Result .. "Reload," -- Reload Songs
		Result = Result .. "Credits," -- StepMania Credits
		Result = Result .. "SRCredits," -- Project Diva: Stepping Revision Credits

		return Result
		end,

		RowTransform = function(self,positionIndex,itemIndex,numItems)
		self:y( (SCREEN_CENTER_Y-WideScale(110,140)) + (WideScale(45,50)*positionIndex) )
		self:x( 0*positionIndex )
		end,

		LineSRCredits = function()
		return "gamecommand;screen,ScreenDVSRCredits;name,SRCredits"
		end,
		LineTheme = function()
		return "gamecommand;screen,ScreenOptionsTheme;name,Theme Options"
		end,
	},

	AdvancedOptions = {
		LineNames = function()
			Result = ""

			Result = Result .. "3,4,8,11,13,14,15,16,28,29,30,31,32"

			return Result
		end,
	},

	ThemeOptions = {
		LineNames = function()
			Result = ""
		
			Result = Result .. "CurrentStageLocation,"
			
			if ThemePrefs.Get("CurrentStageLocation") and ThemePrefs.Get("CurrentStageLocation") ~= "None" then
				Result = Result .. "CurrentStageLighting,"
			end

			Result = Result .. "DedicatedCharacterShow,"

			if ThemePrefs.Get("DedicatedCharacterShow") then
				Result = Result .. "DediCharsSettings,"
			end

			Result = Result .. "EnableRandomSongPlay,"

			if ThemePrefs.Get("EnableRandomSongPlay") then
				Result = Result .. "FolderToPlayRandomMusic,"
				Result = Result .. "ShowRandomSongBackground,"
			end

			if ThemePrefs.Get("ShowCharactersOnHome") then
				Result = Result .. "AllowMultipleModels,"
			end
			if ThemePrefs.Get("ShowCharactersOnHome") and ThemePrefs.Get("AllowMultipleModels") then
				Result = Result .. "ModelsInRoom,"
			end

			return Result;
		end,

		LineDediCharsSettings = function()
		return "gamecommand;screen,ScreenDediCharsSettings;name,Dedicated Character Settings"
		end,
		RowTransform = function(self,positionIndex,itemIndex,numItems)
		self:y( (SCREEN_CENTER_Y-120) + (40*positionIndex) )
		self:x( 0*positionIndex )
		end,
	},

	DediSettings = {
		LineNames = function()
			Result = ""

			Result = Result .. "DediModelBPM,"
			Result = Result .. "DediSongData,"
			Result = Result .. "DediMeasureCamera,"

			return Result;
		end,
	},

	Gameplay = {
	LyricDisplay = function(self)
 	self:xy(SCREEN_LEFT+80, SCREEN_BOTTOM-12):zoom(0.6):horizalign(left):draworder(101)
	end,
	},

	ScreenPrompt = {
		AnswerShow = function(self) self:maxwidth(100):zoom(0.5):draworder(101) end,
		AnswerHide = function(self) self:sleep(0.3):accelerate(0.2):diffusealpha(0) end,
		AnswerY = function() return SCREEN_CENTER_Y+20 end,
	},

	SelectMusic = {
		DescriptionSet = function(self,param)
			if param.Steps then
				if param.Steps and string.len( param.Steps:GetDescription() ) > 1 then
					self:settext( 
							ToEnumShortString(param.Steps:GetDifficulty())..
							"\n"
							..param.Steps:GetDescription()
								)
					self:zoom( 0.4 )
				else
					self:settext( ToEnumShortString(param.Steps:GetDifficulty()) )
					self:zoom( 0.6 )
				end
				self:stopeffect()
			end
			if param.Steps and param.Steps:IsAnEdit() then
				if string.len( param.Steps:GetDescription() ) > 1 then
					self:settext( "Edit\n".. param.Steps:GetDescription() )
				else
					self:settext( "Edit" )
				end
				self:diffuseshift()
				self:effectcolor1(0,1,1,1)
				self:effectcolor2(0,0.8,0.8,1)
			end
		end,

		TickSet = function(self,param)
			if param.Steps then
				self:diffuse(CustomDifficultyToColor(param.CustomDifficulty));
			end
		end,
	},

	PlayerOptions = {
		RowTransform = function(self,positionIndex,itemIndex,numItems)
			self:y( (SCREEN_CENTER_Y-70) + (28*positionIndex) );
		end,
	},

	MusicWheel = {
		WheelTransform = function(self,offsetFromCenter,itemIndex,numItems)
			self:y( offsetFromCenter*85 )
			self:x( 10*offsetFromCenter )
			self:diffusealpha(1)
			if itemIndex < 7 then self:diffusealpha( 0.25 ) end
			if itemIndex > 13 then self:diffusealpha( 0.55 ) end
			if itemIndex == 8 then self:x(10) end
		end,
	},
}