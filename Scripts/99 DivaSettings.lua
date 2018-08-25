-- a simple target
-- make as less lines as possible on the metrics

-- it's that simple of an objective

DSet = {
	ThemeSetting = function(name) return "lua,ThemePrefRow('"..name.."')" end,
	
	Shared = {
		ScrollOn = function(self)
			(cmd(zoom,0.7;addx,-300;sleep,0.2;decelerate,0.2;addx,300))(self);
		end,
		ScrollOff = function(self)
			(cmd(accelerate,0.2;addx,-300;))(self);
		end,

		ExpX = function() return SCREEN_RIGHT-310 end,
		ExpY = function() return SCREEN_CENTER_Y-50 end,
		ExpOn = function(self)
		(cmd(wrapwidthpixels,370;horizalign,left;zoom,0.6;vertalign,top;diffusealpha,0;sleep,0.1;linear,0.1;diffusealpha,1))(self);
		end,
		ExpOff = function(self) (cmd(accelerate,0.2;diffusealpha,0))(self); end,
	},
	TitleMenu = {
		ScrollerTransform = function(self,offset,itemIndex,numItems)
			self:y((42)*(itemIndex-(numItems-1)/2))
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
	},
	ScreenOptionsService = {
		NumRowsShown = function() return 7 end,
		LineNames = function()
		local Result = ''
		
		Result = Result .. "GameType," -- Select Game
		Result = Result .. "GraphicSound," -- Graphics/Sound Options
		Result = Result .. "KeyConfig," -- Key Configuration
		Result = Result .. "Arcade," -- Arcade Options
		Result = Result .. "InputOptions," -- Input
		Result = Result .. "SoundGraphics," -- Display Options
		Result = Result .. "Profiles," -- obvs
		Result = Result .. "Network," -- obvs
		Result = Result .. "Advanced," -- advanced shit yo
		Result = Result .. "Theme," -- The Project Diva: Stepping Revision Settings
		Result = Result .. "Reload," -- Reload Songs
		Result = Result .. "Credits," -- StepMania Credits
		Result = Result .. "SRCredits," -- Project Diva: Stepping Revision Credits

		return Result
		end,

		RowTransform = function(self,positionIndex,itemIndex,numItems)
		self:y( (SCREEN_CENTER_Y-70) + (28*positionIndex) )
		end,

		LineSRCredits = function()
		return "gamecommand;screen,ScreenDVSRCredits;name,SRCredits"
		end,
		LineTheme = function()
		return "gamecommand;screen,ScreenOptionsTheme;name,Theme Options"
		end,
	},

	ThemeOptions = {
		LineNames = function()
			Result = ""
		
			if ThemePrefs.Get("CurrentStageLocation") and ThemePrefs.Get("CurrentStageLocation") ~= "None" then
				Result = Result .. "CurrentStageLighting,"
			end
		
			-- Currently this is still being tested. (ok not really)
			-- It has been already tested, it works flawlessly.
			-- Only issue right now will be to find appropiate locations.
			Result = Result .. "CurrentStageLocation,"

			Result = Result .. "DedicatedCharacterShow,"

			if ThemePrefs.Get("DedicatedCharacterShow") then
				Result = Result .. "DediCharsSettings,"
			end

			Result = Result .. "ShowCharactersOnHome,"

			Result = Result .. "EnableRandomSongPlay,"

			if ThemePrefs.Get("EnableRandomSongPlay") then
				Result = Result .. "FolderToPlayRandomMusic,"				
			end

			-- dunno how the fuck i can make this work.
			-- if someone knows, I would be great to know.
			-- if you wanna see what i tried doing, check ThemePrefs.lua

			if ThemePrefs.Get("ShowCharactersOnHome") then
				Result = Result .. "MainCharacterOnHome,"
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
 	(cmd(x,SCREEN_LEFT+80;y,SCREEN_BOTTOM-12;zoom,0.6;horizalign,left;draworder,101;))(self);
	end,
	},

	ScreenPrompt = {
		AnswerShow = function(self) (cmd(maxwidth,100;zoom,0.5;draworder,101;))(self); end,
		AnswerHide = function(self) (cmd(sleep,0.3;accelerate,0.2;diffusealpha,0))(self); end,
		AnswerY = function() return SCREEN_CENTER_Y+20 end,
	},

	SelectMusic = {
		DescriptionSet = function(self,param)
			if param.Steps then
				if string.len( param.Steps:GetDescription() ) > 1 then
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
			self:y( offsetFromCenter*42 )
		end,
	},
}