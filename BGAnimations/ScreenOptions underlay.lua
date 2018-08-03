local t = Def.ActorFrame{}

t[#t+1] = LoadActor( THEME:GetPathG("","Light_BottomMenuBar") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;horizalign,right;zoom,2;SetTextureFiltering,false;;y,SCREEN_BOTTOM;vertalign,bottom);
};

t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-70;CenterY;diffusealpha,0;sleep,0.3;decelerate,0.2;diffusealpha,1);
	OffCommand=cmd(accelerate,0.2;diffusealpha,0);

		LoadActor( THEME:GetPathG("","Title_Explanation") )..{
		OnCommand=cmd(horizalign,right;zoom,1.5);
		GainFocusCommand=cmd(stoptweening;visible,true);
		LoseFocusCommand=cmd(stoptweening;visible,false);
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