local t = Def.ActorFrame{
	OnCommand=function(self)
	ThemePrefs.Save()
	-- Lock input so the labels have time to finish
	SCREENMAN:GetTopScreen():lockinput(0.6)
	end,
}

t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-70;y,SCREEN_BOTTOM-150;diffusealpha,0;sleep,0.3;decelerate,0.2;diffusealpha,1);
	OffCommand=cmd(accelerate,0.2;diffusealpha,0);

		LoadActor( THEME:GetPathG("","Title_Explanation") )..{
		OnCommand=cmd(horizalign,right;zoom,1.5);
		GainFocusCommand=cmd(stoptweening;visible,true);
		LoseFocusCommand=cmd(stoptweening;visible,false);
		};

	};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_RIGHT-WideScale(170,240);y,100);
	OnCommand=cmd(diffusealpha,0;sleep,.3;zoom,WideScale(0.5,0.7);decelerate,0.2;diffusealpha,1);
	OffCommand=cmd(sleep,3;accelerate,0.2;diffusealpha,0);

	LoadActor( THEME:GetPathG("","ThemeLogo") )..{
		InitCommand=cmd(shadowlengthy,2;zoom,0.7);
	};	

	LoadFont("Common Normal")..{
		Text="Version ".. PDSRPInfo["Version"],
		InitCommand=cmd(shadowlengthy,2;x,200;horizalign,right;y,60;zoom,0.8;strokecolor,Color.Black);
	};
};

t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_LEFT+20;y,20;decelerate,0.2;diffusealpha,1);
	OffCommand=cmd(accelerate,0.2;diffusealpha,0);

	LoadFont("Common Normal")..{
		Text="Options Menu",
		InitCommand=cmd(horizalign,left;zoom,1;strokecolor,Color.Black;diffusealpha,0);
		OnCommand=cmd(sleep,.3;decelerate,0.2;diffusealpha,1);
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("HeaderText"),
		InitCommand=cmd(horizalign,left;zoom,0.6;y,40;strokecolor,Color.Black;diffusealpha,0);
		OnCommand=cmd(sleep,.3;decelerate,0.2;diffusealpha,1);
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};

};

return t;