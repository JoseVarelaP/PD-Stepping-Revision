local t = Def.ActorFrame{};

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

	-- Reload the theme!
	--[[
		But why though?
		This is because of the Random Song Play feature.
		If the theme is loaded once, the game won't run the entirety
		of the SongFolder command correctly, and it would spit out 
		a bunch of errors to ThemePrefs. The solution is to reload the
		theme again, while already loaded, so the script loads with the
		now available data.
	]]
	if not AlreadyReloaded then
		AlreadyReloaded = true
		THEME:SetTheme("DV-Stepping-Revision")
	end

	if not DIVA_RandomSong then
		DIVA_RandomSong = SONGMAN:GetRandomSong()
	end

	Diva_ResetRandomSong()


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