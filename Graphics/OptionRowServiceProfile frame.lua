local t = Def.ActorFrame {};

local gc = Var("GameCommand");

t[#t+1] = LoadActor("MenuScrollers/Base")..{
	OnCommand=cmd(horizalign,left;zoom,2);
};

t[#t+1] = LoadActor("MenuScrollers/Dim")..{
	OnCommand=cmd(horizalign,left;zoom,2;faderight,0.1);
	GainFocusCommand=cmd(stoptweening;diffusealpha,1);
	LoseFocusCommand=cmd(stoptweening;linear,0.1;diffusealpha,0);
};

t[#t+1] = LoadActor("MenuScrollers/Bright")..{
	OnCommand=cmd(horizalign,left;zoom,2);
	GainFocusCommand=function(self)
	self:stoptweening():diffuseshift():diffusealpha(1):effectcolor1(1,1,1,1):effectcolor2(0.8,0.8,0.8,0.5)
	end,
	LoseFocusCommand=cmd(stoptweening;linear,0.1;diffusealpha,0);
};

return t;