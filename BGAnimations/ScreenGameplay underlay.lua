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
local t = Def.ActorFrame{
	OnCommand=cmd(Center;fov,90;rotationy,180;z,WideScale(300,400);addy,10;);
}

--[[
	Load the character BEFORE doing anything.
	This is because calling the command directly 
	before loading it first will make a mesh of 
	loading everything with other characters.
]]
local CharacterToLoad = GAMESTATE:GetCharacter(PLAYER_1);

-- This is to load the stage's time of day.
-- It goes along the Current Stage Lighting setting found on the
-- Theme Options.
local FuturaToLoad = ( 
		ThemePrefs.Get("CurrentStageLighting") == "Auto" and 
			((Hour() < 6 or Hour() > 19) and "Night" or "Day")
		) or ThemePrefs.Get("CurrentStageLighting")

--[[
	Settings & Shortcuts
	Make this a setting that the player can change.

	TODO: Get Stages to test properly!
]]
local BeatsBeforeNextSegment = 8*ThemePrefs.Get("DediMeasureCamera")

-- Set the time to wait
local Frm = 1/60

--[[
	Change this to true in case you want to see the timer
	before the next animation on your Log Display. (Only windows)
	If mac, it needs to be on a SystemMessage as the mac cannot display the Log Display.
	Unless you run the game via the terminal.

	Just ensure this is on.
	ShowLogOutput=1
]]
local DebugMode = true

-- In case you want frame-by-frame info on specific stuff.
local MassiveLog = false
local function CameraRandom()
	return math.random(1,3)
end

-- Messages to trace when Debug Mode is on.
local DebugMessages = {
	ModelLoad = function()
		if DebugMode then
			for player in ivalues(PlayerNumber) do
				if GAMESTATE:IsPlayerEnabled(player) then
					Trace(
					"-------------------------------------------\n"..
					"CharacterDisplay: Character Loaded. ("..player..")"..
					"\nCharacterName: "..GAMESTATE:GetCharacter(player):GetDisplayName()
					.."\nCurrentAnimation: "..GAMESTATE:GetCharacter(player):GetDanceAnimationPath()
					.."\nCharacter Location: "..GAMESTATE:GetCharacter(player):GetCharacterDir()
					.."\n-------------------------------------------"
					)
				end
			end
		end
	end,
	TimeBeforeNextCamera = function()
		if DebugMode then
			Trace("CharacterDisplay: Neccesary time before next Camera: ".. NextSegment - now)
		end
	end,
	CameraLoaded = function()
		if DebugMode then
			for player in ivalues(PlayerNumber) do
				if GAMESTATE:IsPlayerEnabled(player) then
					Trace(
					"\n-------------------------------------------\n"..
					"Next Camera Loaded (".. CameraRandom() .."), returning to command.\n"..
					"\nCurrentAnimation: "..GAMESTATE:GetCharacter(player):GetDanceAnimationPath()..
					"\n-------------------------------------------\n"
					)
				end
			end
		end
	end,
};

-- timing manager
t[#t+1] = Def.Quad{
	Condition=ThemePrefs.Get("DedicatedCharacterShow");
	OnCommand=cmd(visible,false;queuemessage,"InitialTween";queuecommand,"WaitForStart");
	WaitForStartCommand=function(self)
	-- set globals, we need these later.
	song = GAMESTATE:GetCurrentSong();
	start = song:GetFirstBeat();
	now = GAMESTATE:GetSongBeat();

	-- Clear this one out in case the player restarts the screen.
	-- And to also properly reset the counter if it does.
	NextSegment = nil

	self:sleep(Frm)
	if now<start then
		self:queuecommand("WaitForStart")
	else
		self:queuemessage("Camera"..CameraRandom())
		self:sleep(Frm)
		self:queuecommand("TrackTime")
	end
	end,
	TrackTimeCommand=function(self)
	if not NextSegment then
		NextSegment = now + BeatsBeforeNextSegment
	end

	now = GAMESTATE:GetSongBeat();

	self:sleep(Frm)
	if now < NextSegment then
		self:queuecommand("TrackTime")
	else
		self:queuemessage("Camera"..CameraRandom())
		NextSegment = now + BeatsBeforeNextSegment
		DebugMessages.CameraLoaded()
		self:queuecommand("TrackTime")
	end
	end,
}


-- Stage Enviroment
t[#t+1] = Def.ActorFrame{
	Condition=ThemePrefs.Get("DedicatedCharacterShow");
	InitCommand=cmd(queuecommand,"BeginCamera");
	BeginCameraCommand=cmd();


		-- Load the Stage
		Def.Model {
			Condition=ThemePrefs.Get("CurrentStageLocation") ~= "None";
			Meshes=ThemePrefs.Get("CurrentStageLocation").."/model.txt";
			Materials=ThemePrefs.Get("CurrentStageLocation").."/"..FuturaToLoad.."_material.txt";
			Bones=ThemePrefs.Get("CurrentStageLocation").."/model.txt";
			OnCommand=function(self)
				self:cullmode("CullMode_Back")
			end,
		};

};

local function BothPlayersEnabled()
	return GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2)
end

for player in ivalues(PlayerNumber) do
	-- Load the Character
	t[#t+1] = Def.Model {
			Condition=GAMESTATE:IsPlayerEnabled(player),
			Meshes=GAMESTATE:GetCharacter(player):GetModelPath(),
			Materials=GAMESTATE:GetCharacter(player):GetModelPath(),
			Bones=GAMESTATE:GetCharacter(player):GetDanceAnimationPath(),
			InitCommand=function(self)
				self:cullmode("CullMode_None")
				DebugMessages.ModelLoad()
			-- position time
			if BothPlayersEnabled() then
				-- reminder that x position is inverted because we inverted the Y axis
				-- to make the character face towards the screen.
				self:x( (player == PLAYER_1 and 8) or -8 )
			end

			ModelBeat = GAMESTATE:GetSongBeat();
			if ThemePrefs.Get("DediModelBPM") then
				self:queuecommand("UpdateRate")
			end
			end,

			-- Update Model animation speed depending on song's BPM.
			-- To match SM's way of animation speeds.
			UpdateRateCommand=function(self)
			if now<=ModelBeat then
				self:rate(0)
				if DebugMode and MassiveLog then
					Trace("Animation Paused!!!")
				end
			else
				self:rate(0.5*GAMESTATE:GetSongBPS())
				if DebugMode and MassiveLog then
					Trace("New Model Rate: ".. 0.5*GAMESTATE:GetSongBPS() .." - Current BPS: ".. GAMESTATE:GetSongBPS())
					Trace( now.. " - ".. ModelBeat )
					Trace( self:GetDefaultAnimation() )
				end
			end
			ModelBeat = GAMESTATE:GetSongBeat();
			self:sleep(Frm)
			self:queuecommand("UpdateRate")
			end,
		};
end

-- Some song info before we start
t[#t+1] = Def.ActorFrame{
	Condition=ThemePrefs.Get("DediSongData");

	InitCommand=cmd(z,-5;x,0;y,-10;rotationy,180;diffusealpha,0;sleep,0.3;decelerate,0.2;diffusealpha,1);

		LoadActor( THEME:GetPathG("","BGElements/CircleInner") )..{
			OnCommand=cmd(diffusealpha,0.3;spin;effectmagnitude,0,0,24;zoom,0.08;z,-10);
		};
	
		Def.Quad{
		OnCommand=cmd(zoomto,40,6;y,1;diffuse,0,0.5,0.5,1;fadeleft,1;faderight,1);
		};

		Def.Sprite {
			InitCommand=cmd(diffusealpha,1);
			BeginCommand=cmd(LoadFromCurrentSongBackground);
			OnCommand=function(self)
				self:scaletoclipped(648/30,480/30)
				:croptop(0.37):cropbottom(0.25)
				:fadeleft(0.2):faderight(0.2)
				:diffuse(0.7,0.7,0.7,1)
			end;
		};
	
		LoadFont("Common Normal")..{
		Text=GAMESTATE:GetCurrentSong():GetDisplayArtist();
		InitCommand=cmd(zoom,0.07;shadowlengthy,0.2);
		};
	
		LoadFont("Common Normal")..{
		Text=GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
		InitCommand=cmd(shadowlengthy,0.2;y,2;zoom,0.05);
		};

	OnCommand=cmd(queuecommand,"UpdateToSleep");
	UpdateToSleepCommand=function(self)
	if now<(start-4) then
		self:queuecommand("UpdateToSleep")
		self:sleep(Frm)
	else
		self:sleep(Frm)
		self:queuecommand("FadeAway")
	end
	end,
	FadeAwayCommand=cmd(accelerate,0.2;diffusealpha,0);
};

-- some utilities
local function ResetRotation(self)
	self:rotationy(180):rotationx(0):rotationz(0)
end

-- The cameras
t.InitialTweenMessageCommand=function(self)
	self:addz(-40):decelerate(3):addz(40)
end
t.Camera1MessageCommand=function(self)
	ResetRotation(self)
	self:rotationy(45):rotationx(20):rotationz(-30)
end
t.Camera2MessageCommand=function(self)
	ResetRotation(self)
	self:rotationy(140):rotationz(10):rotationx(-10)
end
t.Camera3MessageCommand=function(self)
	ResetRotation(self)
	self:rotationy(210):rotationx(25)
end

return t;