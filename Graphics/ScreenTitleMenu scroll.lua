local t = Def.ActorFrame {};
local gc = Var("GameCommand");

	t[#t+1] = Def.ActorFrame{

		LoadActor("MenuScrollers/Base")..{
		OnCommand=cmd(horizalign,left;zoom,2);
		};

		LoadActor("MenuScrollers/Dim")..{
		OnCommand=cmd(horizalign,left;zoom,2;faderight,0.1);
		GainFocusCommand=cmd(stoptweening;diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;linear,0.1;diffusealpha,0);
		};

		LoadActor("MenuScrollers/Bright")..{
		OnCommand=cmd(horizalign,left;zoom,2);
		GainFocusCommand=cmd(stoptweening;diffuseshift;diffusealpha,1;effectcolor1,Color.White;effectcolor2,0.8,0.8,0.8,0.5);
		LoseFocusCommand=cmd(stoptweening;linear,0.1;diffusealpha,0);
		};

		LoadFont("", "handel gothic") ..{
		Text=THEME:GetString( 'ScreenTitleMenu', Var("GameCommand"):GetText() );
		OnCommand=cmd(x,30;horizalign,left;strokecolor,Color.Black);
		GainFocusCommand=cmd(stoptweening;decelerate,0.1;zoom,1.1;diffuse,Color.White);
		LoseFocusCommand=cmd(stoptweening;stopeffect;linear,0;zoom,1.0;diffuse,0.5,0.5,0.5,1);
		DisabledCommand=cmd(diffuse,0.5,0.5,0.5,1);
	};

	};

return t;