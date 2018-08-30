local t = Def.ActorFrame {};

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
	OnCommand=function(self)
	(cmd(horizalign,left;x,100;shadowlengthy,5;shadowcolor,color("0,0,0,0.3");diffuse,0.3,0.3,0.3,1))(self);
	local optrow = self:GetParent():GetParent():GetParent()

	self:settext(THEME:GetString("OptionTitles",optrow:GetName()) ):horizalign(left)

	end,
};

if DebugMode then
	t[#t+1] = LoadFont("Common Normal")..{
	OnCommand=function(self)
	local optrow = self:GetParent():GetParent():GetParent()
	self:settext(optrow:GetName() .." - ".. THEME:GetString("OptionTitles",optrow:GetName()) ):horizalign(left)
	:zoom(0.6):x(102):y(16):diffuse(Color.Black)
	end,
};
end

t.GainFocusCommand=function(self)
self:stoptweening()
self:decelerate(0.1)
self:x(20)
end;
t.LoseFocusCommand=function(self)
self:stoptweening()
self:accelerate(0.1)
self:x(0)
end;

return t;