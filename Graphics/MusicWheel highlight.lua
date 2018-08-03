local t = Def.ActorFrame {};

	t[#t+1] = Def.ActorFrame{

		LoadActor("MenuScrollers/Bright")..{
		InitCommand=cmd(horizalign,left;zoom,2;fadeleft,1);
		OnCommand=cmd(glowramp;effectclock,"bgm";effectperiod,2;effectcolor1,1,1,1,0.4;effectcolor2,1,1,1,0.7);
		};

	};

return t;