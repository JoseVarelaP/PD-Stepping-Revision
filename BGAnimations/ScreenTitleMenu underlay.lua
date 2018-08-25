local t = Def.ActorFrame{
	OnCommand=function(self)
	if ThemePrefs.Get("EnableRandomSongPlay") then
		GAMESTATE:SetPreferredSong(DIVA_RandomSong)
	end
	end,
}

t[#t+1] = LoadActor( THEME:GetPathG("","Light_BottomMenuBar") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;horizalign,right;zoom,2;SetTextureFiltering,false;y,SCREEN_BOTTOM;vertalign,bottom);
};

t[#t+1] = LoadActor( THEME:GetPathG("","ThemeLogo") )..{
	InitCommand=cmd(shadowlengthy,2;x,SCREEN_RIGHT-100;horizalign,right;y,100;zoom,0.4;diffusealpha,0);
	OnCommand=cmd(sleep,.3;decelerate,0.2;diffusealpha,1);
	OffCommand=cmd(accelerate,0.2;diffusealpha,0);
};

t[#t+1] = LoadFont("Common Normal")..{
	Text="Stepping Revision Project\nVersion ".. PDSRPInfo["Version"],
	InitCommand=cmd(shadowlengthy,2;x,SCREEN_RIGHT-100;horizalign,right;y,60;zoom,0.5;diffusealpha,0);
	OnCommand=cmd(sleep,.3;decelerate,0.2;diffusealpha,1);
	OffCommand=cmd(accelerate,0.2;diffusealpha,0);
};

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
		if string.len(DIVA_RandomSong:GetDisplaySubTitle()) > 1 then
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

return t;