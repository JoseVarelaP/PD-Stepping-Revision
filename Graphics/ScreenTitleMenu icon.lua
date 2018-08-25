local t = Def.ActorFrame {};
local gc = Var("GameCommand");

	t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-70;CenterY;diffusealpha,0;sleep,0.3;decelerate,0.2;diffusealpha,1);
	OffCommand=cmd(accelerate,0.2;diffusealpha,0);

		LoadActor("Title_Explanation")..{
		OnCommand=cmd(horizalign,right;zoom,1.5);
		GainFocusCommand=cmd(stoptweening;visible,true);
		LoseFocusCommand=cmd(stoptweening;visible,false);
		};

		LoadFont("Common Normal") ..{
		Text=THEME:GetString( 'ScreenTitleMenu', Var("GameCommand"):GetText() ).."\n\n"..THEME:GetString( 'TitleExplanations', Var("GameCommand"):GetText() );
		OnCommand=cmd(x,-230;y,-60;zoom,0.6;horizalign,left;wrapwidthpixels,300;vertalign,top);
		GainFocusCommand=cmd(stoptweening;visible,true;diffusealpha,0;sleep,0.1;linear,0.1;diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;visible,false);
		DisabledCommand=cmd(diffuse,0.5,0.5,0.5,1);
	};

	};

return t;