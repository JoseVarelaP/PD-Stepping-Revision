local t = Def.ActorFrame{}

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

return t;