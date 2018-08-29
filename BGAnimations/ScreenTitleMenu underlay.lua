local t = Def.ActorFrame{
	OnCommand=function(self)
	if ThemePrefs.Get("EnableRandomSongPlay") then
		GAMESTATE:SetPreferredSong(DIVA_RandomSong)
		MESSAGEMAN:Broadcast("ShowBackground")
	end
	end,
}

t[#t+1] = LoadFont("Common Normal")..{
	Text="Project by "..PDSRPInfo["Author"].." - 2018\nOriginal Work (C) ".. PDSRPInfo["OriginalWork"][1] .." / (C) ".. PDSRPInfo["OriginalWork"][2];
	InitCommand=cmd(shadowlengthy,1;x,SCREEN_RIGHT-100;horizalign,right;y,SCREEN_BOTTOM-70;zoom,0.4;diffusealpha,0);
	OnCommand=cmd(sleep,.3;decelerate,0.2;diffusealpha,0.5);
	OffCommand=cmd(accelerate,0.2;diffusealpha,0);
};

if ThemePrefs.Get("EnableRandomSongPlay") then

	local FadeIn = cmd(sleep,.3;decelerate,0.2;diffusealpha,0.5);
	local GlobalItems = cmd(horizalign,right;zoom,0.6;shadowlengthy,1);

	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(diffusealpha,0);
		OnCommand=cmd(zoom,0.8;x,SCREEN_RIGHT-100;y,SCREEN_BOTTOM-120;sleep,.3;decelerate,0.2;diffusealpha,0.5);
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);

		LoadFont("Common Normal")..{
		Text=DIVA_RandomSong:GetDisplayMainTitle();
		InitCommand=GlobalItems;
		OnCommand=function(self)
		local ToMove = -2
		if DIVA:HasSubtitles(DIVA_RandomSong) then
			ToMove = -10
		end
		self:y(ToMove)
		end,
		};
		LoadFont("Common Normal")..{
		Text=DIVA_RandomSong:GetDisplaySubTitle();
		InitCommand=GlobalItems;
		OnCommand=cmd(zoom,0.4;y,2);
		};
		LoadFont("Common Normal")..{
		Text=DIVA_RandomSong:GetDisplayArtist();
		InitCommand=GlobalItems;
		OnCommand=cmd(y,12);
		};
	};
end

t[#t+1] = LoadActor("Borders.lua");

return t;