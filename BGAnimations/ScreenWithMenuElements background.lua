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

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(Center;rotationy,180;spin;z,WideScale(300,400);addy,10;effectmagnitude,0,10,0);
	OnCommand=cmd(addy,20;addx,100;addz,-40;decelerate,3;addx,-100;addz,40;addy,-20);

		Def.ActorFrame{
		OnCommand=cmd(wag;effectmagnitude,0,0,2;effectperiod,5);


		Def.Model {
			-- In case the Locations are killing perfomance, then
			-- disable it completely when going to None.
			Condition=ThemePrefs.Get("CurrentStageLocation") ~= "None";
			Meshes=Diva_GetPathLocation("",ThemePrefs.Get("CurrentStageLocation").."/model.txt");
			Materials=Diva_GetPathLocation("",ThemePrefs.Get("CurrentStageLocation").."/"..FuturaToLoad.."_material.txt");
			Bones=Diva_GetPathLocation("",ThemePrefs.Get("CurrentStageLocation").."/model.txt");
			OnCommand=function(self)
				self:cullmode("CullMode_None")
			end,
		};

		GenerateModel(Sec_CharacterToLoad, 1, 26, 51, "CullMode_None", 0.7);
		GenerateModel(Thr_CharacterToLoad, 2, -25, -81, "CullMode_None", 0.7);
		GenerateModel(Fou_CharacterToLoad, 3, -28, 90, "CullMode_None", 0.7);
		GenerateModel(Fif_CharacterToLoad, 4, 25, -15, "CullMode_None", 0.7);
		
		Def.Model {
			Condition=ThemePrefs.Get("ShowCharactersOnHome");
			Meshes=CharacterToLoad:GetModelPath(),
			Materials=CharacterToLoad:GetModelPath(),
			Bones=CharacterToLoad:GetWarmUpAnimationPath(),
			OnCommand=function(self)
				self:rate(0.7):cullmode("CullMode_None")
			end,
		};
	};

};

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/CircleInner") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;diffusealpha,0.3;spin;effectmagnitude,0,0,24;zoom,1.2);
};

t[#t+1] = LoadActor( THEME:GetPathG("","Light_TopMenuBar") )..{
	OnCommand=cmd(x,SCREEN_LEFT;horizalign,left;zoom,2;SetTextureFiltering,false;vertalign,top);
};

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
return t;