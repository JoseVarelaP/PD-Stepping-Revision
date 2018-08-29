local t = Def.ActorFrame{
	OnCommand=cmd(fov,90);
}

-- Load the character BEFORE doing anything.
-- This is because calling the command directly 
-- before loading it first will make a mesh of 
-- loading everything with other characters.
local CharacterToLoad = CHARMAN:GetRandomCharacter();
if ThemePrefs.Get("MainCharacterOnHome") then
	CharacterToLoad = CHARMAN:GetCharacter(ThemePrefs.Get("MainCharacterOnHome"));
end
local Sec_CharacterToLoad = CHARMAN:GetRandomCharacter();
local Thr_CharacterToLoad = CHARMAN:GetRandomCharacter();
local Fou_CharacterToLoad = CHARMAN:GetRandomCharacter();
local Fif_CharacterToLoad = CHARMAN:GetRandomCharacter();


local function GenerateModel(CharacterToGrab, MaxToGet, zpos, xpos, cullmode, rate)
	local t = Def.Model {
			Condition=ThemePrefs.Get("AllowMultipleModels") and ThemePrefs.Get("ModelsInRoom") > MaxToGet;
			Meshes=CharacterToGrab:GetModelPath(),
			Materials=CharacterToGrab:GetModelPath(),
			Bones=CharacterToGrab:GetWarmUpAnimationPath(),
			OnCommand=function(self)
				self:rate(rate):cullmode(cullmode):z(zpos):x(xpos)
			end,
		};

	return t;
end

local FuturaToLoad = ( 
		ThemePrefs.Get("CurrentStageLighting") == "Auto" and 
			((Hour() < 6 or Hour() > 19) and "Night" or "Day")
		) or ThemePrefs.Get("CurrentStageLighting")

-- t[#t+1] = Def.ActorFrame{
-- 	InitCommand=cmd(Center;rotationy,180;spin;z,WideScale(300,400);addy,10;effectmagnitude,0,10,0);
-- 	OnCommand=cmd(addy,20;addx,100;addz,-40;decelerate,3;addx,-100;addz,40;addy,-20);

-- 		Def.ActorFrame{
-- 		OnCommand=cmd(wag;effectmagnitude,0,0,2;effectperiod,5);

-- 			Def.ActorFrame{
-- 			OnCommand=cmd(wag;effectmagnitude,2,0,0;effectperiod,3);
			
-- 				Def.Model {
-- 					-- In case the Locations are killing perfomance, then
-- 					-- disable it completely when going to None.
-- 					Condition=ThemePrefs.Get("CurrentStageLocation") ~= "None";
-- 					Meshes=DIVA:GetPathLocation("",ThemePrefs.Get("CurrentStageLocation").."/model.txt");
-- 					Materials=DIVA:GetPathLocation("",ThemePrefs.Get("CurrentStageLocation").."/"..FuturaToLoad.."_material.txt");
-- 					Bones=DIVA:GetPathLocation("",ThemePrefs.Get("CurrentStageLocation").."/model.txt");
-- 					OnCommand=function(self)
-- 						self:cullmode("CullMode_None")
-- 					end,
-- 				};
		
-- 				GenerateModel(Sec_CharacterToLoad, 1, 26, 51, "CullMode_None", 0.7);
-- 				GenerateModel(Thr_CharacterToLoad, 2, -25, -81, "CullMode_None", 0.7);
-- 				GenerateModel(Fou_CharacterToLoad, 3, -28, 90, "CullMode_None", 0.7);
-- 				GenerateModel(Fif_CharacterToLoad, 4, 25, -15, "CullMode_None", 0.7);
				
-- 				Def.Model {
-- 					Condition=ThemePrefs.Get("ShowCharactersOnHome");
-- 					Meshes=CharacterToLoad:GetModelPath(),
-- 					Materials=CharacterToLoad:GetModelPath(),
-- 					Bones=CharacterToLoad:GetWarmUpAnimationPath(),
-- 					OnCommand=function(self)
-- 						self:rate(0.7):cullmode("CullMode_None")
-- 					end,
-- 				};

-- 			};
-- 		};

-- };

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/CircleInner") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;diffusealpha,0.3;spin;effectmagnitude,0,0,24;zoom,1.2);
};

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;);	
};

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,color("#00B6EA");fadebottom,1);
};

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/DotTileBG") )..{
	OnCommand=cmd(x,SCREEN_RIGHT+100;horizalign,right;vertalign,top;diffusealpha,0.2;zoom,2;cropleft,0.05;rotationz,5;fadeleft,1);
};

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/DotCircle") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_BOTTOM;diffusealpha,0.5;spin;effectmagnitude,0,0,10);
};

local TileXAmm = 3

local ColorsToUse = {
	color("#FFFFFF"),
	color("#DE5AC8"),
	color("#FFFF83"),
	color("#3184F1"),
	color("#A8FFD6"),
};

for i=1,5 do
t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y-40+(15*i));
	LoadActor( THEME:GetPathG("","BGElements/SmoothLine") )..{
		InitCommand=cmd(diffuse,ColorsToUse[i];z,math.random(-30,150);fadetop,1;wag;effectmagnitude,0,0,5;effectperiod,20;effectoffset,7*i);
		OnCommand=cmd(texcoordvelocity,(0.15/i),0;customtexturerect,0,0,TileXAmm,1;zoom,0.20;zoomx,0.2*TileXAmm;diffusealpha,(300/self:GetZ()));
	};
};
end

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/CircleOuter") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;zoom,1.2;queuecommand,"Loop");
	LoopCommand=function(self)
	self:diffusealpha(0.2):linear(5)
	:diffusealpha(0.8):decelerate(1)
	:diffusealpha(0.2):sleep(6)
	:queuecommand("Loop")
	end,
};

t[#t+1] = Def.Quad{
	OnCommand=cmd(zoom,1.2;queuecommand,"Loop");
	LoopCommand=function(self)
	self:diffusealpha(0):zoom(0)
	:x( math.random(0,SCREEN_RIGHT) ):y( math.random(0,SCREEN_BOTTOM) )
	:zoomto(0,10):diffuse(0,0.6,0.8,0.5):zoomto(200,10):cropright(1):linear(1):cropright(0)
	:linear(1):zoomto( 450, 60 ):diffusealpha(0):sleep( math.random(1,3) )
	:queuecommand("Loop")
	end,
}

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/CircleOuter") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;zoom,1.2;queuecommand,"Loop");
	LoopCommand=function(self)
	self:diffusealpha(0):zoom(1.2):sleep(5)
	:diffusealpha(1):linear(6)
	:zoom(5):diffusealpha(0.1):sleep(1)
	:queuecommand("Loop")
	end,
};

t[#t+1] = LoadActor( THEME:GetPathG("","BGMenuTile") )..{
	OnCommand=cmd(x,SCREEN_RIGHT-50;zoomx,0.5;zoomy,1.5;horizalign,right;CenterY;diffusealpha,0.5;texcoordvelocity,0,0.25;customtexturerect,0,0,1,2);
};

if ThemePrefs.Get("ShowRandomSongBackground") then
	t[#t+1] = LoadActor( DIVA_RandomSong:GetBackgroundPath() )..{
		InitCommand=cmd(FullScreen;diffusealpha,0);
		DivaSongChangedMessageCommand=function(self)
		if DIVA_RandomSong:GetBackgroundPath() then
			self:Load( DIVA_RandomSong:GetBackgroundPath() )
			self:scale_or_crop_background()
			self:diffusealpha(0)
		end
		end,
		HideBackgroundMessageCommand=cmd(linear,0.2;diffusealpha,0);
		ShowBackgroundMessageCommand=function(self)
		self:linear(0.2)
		self:diffusealpha(0.8)
		if ThemePrefs.Get("CurrentStageLocation") ~= "None" or ThemePrefs.Get("ShowCharactersOnHome") then
			self:diffusealpha(0.2)
		end
		end,
	};
end

t[#t+1] = Def.Quad{
	OnCommand=cmd(zoomto,SCREEN_WIDTH,25;diffuse,0,0,0,0.5;CenterX;vertalign,top);	
};

t[#t+1] = LoadActor( THEME:GetPathG("","TopBarText") )..{
	OnCommand=cmd(vertalign,top;horizalign,right;x,SCREEN_RIGHT;diffusealpha,0.6;rotationz,-2;y,-2;zoom,0.8);	
};

t[#t+1] = Def.Quad{
	OnCommand=cmd(zoomto,SCREEN_WIDTH,25;diffuse,0,0,0,0.5;CenterX;vertalign,bottom;y,SCREEN_BOTTOM);	
};

return t;