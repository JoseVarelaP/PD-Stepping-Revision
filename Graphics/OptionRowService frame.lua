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

	};

return t;