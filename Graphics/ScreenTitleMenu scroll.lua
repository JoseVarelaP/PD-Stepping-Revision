local t = Def.ActorFrame {};

local gc = Var("GameCommand");

t[#t+1] = LoadActor("MenuScrollers/Base")..{
	OnCommand=cmd(horizalign,left;zoom,0.4);
};

t[#t+1] = LoadActor("MenuScrollers/Bright")..{
	OnCommand=cmd(horizalign,left;zoom,0.4);
	GainFocusCommand=function(self)
	self:stoptweening():diffuseshift():diffusealpha(1):effectcolor1(1,1,1,1):effectcolor2(0.8,0.8,0.8,0.5)
	end,
	LoseFocusCommand=cmd(stoptweening;linear,0.1;diffusealpha,0);
};

t[#t+1] = LoadFont("Common Normal")..{
	Text=THEME:GetString( 'ScreenTitleMenu', Var("GameCommand"):GetText() );
	OnCommand=function(self)
	(cmd(horizalign,left;x,42;addx,-300;decelerate,0.2;addx,300;strokecolor,Color.Black))(self);
	self:horizalign(left)
	end,
	GainFocusCommand=cmd(diffuse,1,1,1,1);
	LoseFocusCommand=cmd(stoptweening;linear,0.1;diffuse,0.5,0.5,0.5,1);
};

return t;