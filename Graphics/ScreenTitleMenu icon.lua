local t = Def.ActorFrame {};
local gc = Var("GameCommand");

	t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-WideScale(10,70);y,SCREEN_BOTTOM-100;diffusealpha,0;sleep,0.3;decelerate,0.2;diffusealpha,1);
	OffCommand=cmd(accelerate,0.2;diffusealpha,0);

		LoadActor("TitleMenu/"..gc:GetText())..{
		InitCommand=cmd(horizalign,right;x,500;y,-100;zoom,1;decelerate,0.2);
		--OnCommand=cmd(x,300);
		GainFocusCommand=cmd(stoptweening;decelerate,0.2;x,300;diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;decelerate,0.2;x,500;diffusealpha,0);
		};

		LoadActor("Title_Explanation")..{
		OnCommand=cmd(horizalign,right;zoom,1.5;zoomy,1.3);
		GainFocusCommand=cmd(stoptweening;decelerate,0.1;diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;decelerate,0.1;diffusealpha,0);
		};

		LoadFont("Common Normal") ..{
		Text=THEME:GetString( 'TitleExplanations', Var("GameCommand"):GetText() );
		OnCommand=cmd(x,-230;y,-40;zoom,0.6;horizalign,left;wrapwidthpixels,300;vertalign,top;diffuse,0,0,0,1);
		GainFocusCommand=cmd(stoptweening;visible,true;diffusealpha,0;sleep,0.1;linear,0.1;diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;visible,false);
		DisabledCommand=cmd(diffuse,0.5,0.5,0.5,1);
	};

	};

return t;