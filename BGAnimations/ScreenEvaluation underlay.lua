local t = Def.ActorFrame{};

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():fadetop(0.4):fadebottom(0.4):diffuse(0,1,0,0.3)
	end;
};

return t;