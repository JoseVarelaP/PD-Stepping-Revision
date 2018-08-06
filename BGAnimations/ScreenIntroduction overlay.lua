-- local ListOfSettingsToLookFor = {
-- 	ThemePrefs.Get("AllowMultipleModels"),
-- 	ThemePrefs.Get("ModelsInRoom"),
-- 	ThemePrefs.Get("CurrentStageLighting"),
-- 	ThemePrefs.Get("CurrentStageLocation"),
-- 	ThemePrefs.Get("DedicatedCharacterShow"),
-- 	ThemePrefs.Get("ShowCharactersOnHome"),
-- 	ThemePrefs.Get("MainCharacterOnHome"),
-- 	ThemePrefs.Get("DediModelBPM"),
-- 	ThemePrefs.Get("DediSongData"),
-- 	ThemePrefs.Get("DediMeasureCamera"),
-- }

-- for i=1,#ListOfSettingsToLookFor do
-- 	if not ThemePrefs.Get("AllowMultipleModels") then
-- 		Trace("Required setting not found, creating...")
-- 		SCREENMAN:SystemMessage("Required setting not found, creating...")
-- 		ThemePrefs.ForceSave()
-- 	end
-- end

local t = Def.ActorFrame{
    OnCommand=function(self)
    	--THEME:RunLuaScripts()
        --ThemePrefs.ForceSave()
	end,
};

t[#t+1] = Def.Quad{ Name="BGQuad"};
t[#t+1] = LoadActor( THEME:GetPathG("","Intro/Jose") )..{ Name="Jose" };
t[#t+1] = Def.ActorFrame{
	Name="Logo";
	LoadActor( THEME:GetPathG("","BGElements/CircleInner") )..{
		OnCommand=cmd(diffusealpha,0.3;spin;effectmagnitude,0,0,32;zoom,1.6);
	};
	LoadActor( THEME:GetPathG("","White_ThemeLogo") );
	LoadFont("Common Normal")..{
		Text="Stepping Revision Project",
		InitCommand=cmd(x,240;horizalign,right;y,110;zoom,1;diffusealpha,1);
	};
	LoadFont("Common Normal")..{
		Text="Version ".. PDSRPInfo["Version"],
		InitCommand=cmd(x,240;horizalign,right;y,130;zoom,0.8;diffusealpha,1);
	};
};

t.OnCommand=function(self)
	-- get everything
	local Jose = self:GetChild("Jose");
	local Logo = self:GetChild("Logo");
	local BGQuad = self:GetChild("BGQuad");

	-- now let's roll
	Jose:Center():diffusealpha(0):sleep(0.5):decelerate(0.2):diffusealpha(1):sleep(1):accelerate(.2):diffusealpha(0)
	Logo:Center():diffuse(0,0,0,0):zoom(0.6):sleep(2.5):decelerate(0.2):diffusealpha(1):sleep(3):accelerate(.2):diffusealpha(0)
	BGQuad:FullScreen():diffuse(Color.Black):decelerate(0.2):diffuse(Color.White):sleep(6.8):accelerate(0.3):diffuse(Color.Black)

	self:sleep(8):queuecommand("SendToNewScreen")
end
t.SendToNewScreenCommand=function(self)
	SCREENMAN:SetNewScreen("ScreenInit")
end

return t;