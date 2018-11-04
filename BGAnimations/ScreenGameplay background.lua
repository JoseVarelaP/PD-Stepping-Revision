--[[
	Welcome to the Dedicated Character Display for Project Diva: Stepping Revision.
	In here you'll see how it works. For a programmer, including myself, you'll find it extremely simple.
	I tried my best to do it that way. So that even new players and newcomers can learn from it.
]]

--[[
	Let's begin by setting the enviroment that this will be placed on.
	We Center it, make a fov so depth can happen, flip the Y axis because Characters
	in StepMania are flipped, and set the Z position depending on Aspect Ratio because
	the z field changes on the current Aspect Ratio, so correct that.
]]
local background = Def.ActorFrame{};

-- In case location is disabled, but characters are still shown, display
-- the song's background.
if ThemePrefs.Get("CurrentStageLocation") == "None" then
background[#background+1] = Def.Sprite{
	OnCommand=function(self)
	self:LoadFromCurrentSongBackground(GAMESTATE:GetCurrentSong())
	self:scale_or_crop_background()
	end;
	CurrentSongChangedMessageCommand=function(self)
	self:LoadFromCurrentSongBackground(GAMESTATE:GetCurrentSong())
	self:scale_or_crop_background()
	end,
};
end

local t = Def.ActorFrame{
	InitCommand=function(self)
		self:Center():fov(90):rotationy(180):z( WideScale(300,400) ):addy(10);
	end;
	OnCommand=function(self) Camera = self; end;
};

--Settings & Shortcuts
local BeatsBeforeNextSegment = 8*ThemePrefs.Get("DediMeasureCamera")

-- Set the time to wait
local Frm = 1/60

local NumCam = DIVA:CheckStageConfigurationNumber(5,"NumCameras")
local StageHasCamera = FILEMAN:DoesFileExist(DIVA:CallCurrentStage().."/Cameras.lua")
CurrentStageCamera = 0

-- timing manager
t[#t+1] = Def.Quad{
	Condition=ThemePrefs.Get("DedicatedCharacterShow");
	OnCommand=function(self)
		self:visible(false)
		:queuemessage("InitialTween"):queuecommand("WaitForStart");
	end;
	CurrentSongChangedMessageCommand=function(self)
		self:stoptweening():queuecommand("WaitForStart"):queuemessage("InitialTween")
	end;
	WaitForStartCommand=function(self)
	-- set globals, we need these later.
	DEDICHAR:SetTimingData()

	-- Clear this one out in case the player restarts the screen.
	-- And to also properly reset the counter if it does.
	setenv("NextSegment",nil)

	self:sleep(Frm)
	if getenv("now")<getenv("start") then
		self:queuecommand("WaitForStart")
	else
		self:queuemessage("Camera1")
		self:sleep(Frm)
		self:queuecommand("TrackTime")
	end
	end,
	TrackTimeCommand=function(self)
	if not getenv("NextSegment") then
		setenv("NextSegment",getenv("now") + BeatsBeforeNextSegment)
	end

	DEDICHAR:SetTimingData()

	self:sleep(Frm)
	if DIVA:AnyoneHasChar() then
		if getenv("now") >= getenv("NextSegment") then
			self:queuemessage("Camera".. DEDICHAR:CameraRandom())
			CurrentStageCamera = CurrentStageCamera + 1
			setenv("NextSegment",getenv("now") + BeatsBeforeNextSegment)
		end
		self:queuecommand("TrackTime")
	end
	end,
};

-- Stage Enviroment
t[#t+1] = Def.ActorFrame{
	Condition=ThemePrefs.Get("DedicatedCharacterShow") and DIVA:AnyoneHasChar() and
	ThemePrefs.Get("CurrentStageLocation") ~= "None";

		--Load the Stage
		Def.Model {
			Condition=DIVA:LocationIsSafeToLoad();
			Meshes=DIVA:GetPathLocation("",ThemePrefs.Get("CurrentStageLocation").."/model.txt");
			Materials=DEDICHAR:Load_Appropiate_Material();
			Bones=DIVA:GetPathLocation("",ThemePrefs.Get("CurrentStageLocation").."/model.txt");
			OnCommand=function(self)
				self:cullmode("CullMode_None"):zoom( DIVA:CheckStageConfigurationNumber(1,"StageZoom") )
				self:xy( DIVA:CheckStageConfigurationNumber(0,"StageXOffset"), DIVA:CheckStageConfigurationNumber(0,"StageYOffset") )
			end,
		};

};

--[[
	The actual character.
	Checks if the character is functional, is loaded by the player, and if the Dedi Character Show is enabled.
	I really wish I could make this only use one model instead of two.
	It would save a lot of space, without having to do duplicates.

	But due to StepMania's inability to load bones to models directly, I have to "trick" the user
	Into believing that the character has started dancing, by loading two, and then hiding the
	warmup model and showing the dance character once the very first note has passed.
]]

if ThemePrefs.Get("DedicatedCharacterShow") and DIVA:AnyoneHasChar() then
	for player in ivalues(PlayerNumber) do
		if GAMESTATE:IsPlayerEnabled(player) and DIVA:IsSafeToLoad(player) then
		-- This will be the warmup model.
		t[#t+1] = Def.Model {
				Meshes=GAMESTATE:GetCharacter(player):GetModelPath(),
				Materials=GAMESTATE:GetCharacter(player):GetModelPath(),
				Bones=GAMESTATE:GetCharacter(player):GetWarmUpAnimationPath(),
				OnCommand=function(self)
				self:cullmode("CullMode_None")
				if DIVA:BothPlayersEnabled() then self:x( (player == PLAYER_1 and 8) or -8 ) end
				self:zoom( DEDICHAR:HasBabyCharacter(player) and 0.7 or 1 )
				:queuecommand("UpdateRate")
				end,
				UpdateRateCommand=function(self)
				-- Check function to see how it works.
				self:rate( DEDICHAR:UpdateModelRate() ):sleep(Frm)
				:visible( getenv("now")<getenv("start") and true or false)
				:queuecommand("UpdateRate")
				end,
		};
		-- Load the Character
		t[#t+1] = Def.Model {
				Meshes=GAMESTATE:GetCharacter(player):GetModelPath(),
				Materials=GAMESTATE:GetCharacter(player):GetModelPath(),
				Bones=GAMESTATE:GetCharacter(player):GetDanceAnimationPath(),
				OnCommand=function(self)
				self:cullmode("CullMode_None")
				-- position time
				-- reminder that x position is inverted because we inverted the Y axis
				-- to make the character face towards the screen.
				if DIVA:BothPlayersEnabled() then self:x( (player == PLAYER_1 and 8) or -8 ) end
				self:zoom( DEDICHAR:HasBabyCharacter(player) and 0.7 or 1 )
				:queuecommand("UpdateRate")
				end,
				-- Update Model animation speed depending on song's BPM.
				-- To match SM's way of animation speeds
				UpdateRateCommand=function(self)
				-- Check function to see how it works.
				self:rate( DEDICHAR:UpdateModelRate() ):sleep(Frm)
				:visible( getenv("now")>getenv("start") and true or false)
				:queuecommand("UpdateRate")
				end,
		};
		end
	end
end

-- Some song info before we start
t[#t+1] = Def.ActorFrame{
	Condition=ThemePrefs.Get("DedicatedCharacterShow") and ThemePrefs.Get("DediSongData");

	InitCommand=function(self)
		self:xyz(0,-10,-5):rotationy(180):diffusealpha(0):sleep(0.3):decelerate(0.2):diffusealpha(1);
	end;

		LoadActor( THEME:GetPathG("","BGElements/CircleInner") )..{
			OnCommand=function(self)
				self:diffusealpha(0.3):spin():effectmagnitude(0,0,24):zoom(0.08):z(-10);
			end;
		};
	
		Def.Quad{
		OnCommand=function(self)
			self:zoomto(40,6):y(1):diffuse(0,0.5,0.5,1):fadeleft(1):faderight(1);
		end;
		};

		Def.Sprite {
			BeginCommand=function(self) self:LoadFromCurrentSongBackground() end;
			OnCommand=function(self)
				self:scaletoclipped(648/30,480/30)
				:croptop(0.37):cropbottom(0.25)
				:fadeleft(0.2):faderight(0.2)
				:diffuse(0.7,0.7,0.7,1)
			end;
		};
	
		LoadFont("Common Normal")..{
		Text=GAMESTATE:GetCurrentSong():GetDisplayArtist();
		InitCommand=function(self)
			self:zoom(0.07):shadowlengthy(0.2);
		end;
		};
	
		LoadFont("Common Normal")..{
		Text=GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
		InitCommand=function(self)
			self:shadowlengthy(0.2):y(2):zoom(0.05)
		end;
		};

	OnCommand=function(self) self:queuecommand("UpdateToSleep") end;
	UpdateToSleepCommand=function(self)
	self:sleep(Frm)
	if getenv("now")<( getenv("start")-4 ) then
		self:queuecommand("UpdateToSleep")
	else
		self:queuecommand("FadeAway")
	end
	end,
	FadeAwayCommand=function(self) self:accelerate(0.2):diffusealpha(0) end;
};

-- The cameras
if StageHasCamera then
	t[#t+1] = LoadActor( "../../../"..DIVA:CallCurrentStage().."/Cameras.lua" )
else
	t[#t+1] = LoadActor( "../Locations/Default_Camera.lua" )
end

background[#background+1] = t;

return background;