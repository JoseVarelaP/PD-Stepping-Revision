local t = Def.ActorFrame {};

local gc = Var("GameCommand");

t[#t+1] = LoadActor("MenuScrollers/Base")..{
	OnCommand=function(self)
		self:horizalign(left):zoom(2)
	end;
};

t[#t+1] = LoadActor("MenuScrollers/Dim")..{
	OnCommand=function(self)
		self:horizalign(left):zoom(2):faderight(0.1)
	end;
	GainFocusCommand=function(self)
		self:stoptweening():diffusealpha(1)
	end;
	LoseFocusCommand=function(self)
		self:stoptweening():linear(0.1):diffusealpha(0)
	end;
};

t[#t+1] = LoadActor("MenuScrollers/Bright")..{
	OnCommand=function(self)
		self:horizalign(left):zoom(2)
	end;
	GainFocusCommand=function(self)
	self:stoptweening():diffuseshift():diffusealpha(1):effectcolor1(1,1,1,1):effectcolor2(0.8,0.8,0.8,0.5)
	end,
	LoseFocusCommand=function(self)
		self:stoptweening():linear(0.1):diffusealpha(0)
	end;
};

return t;