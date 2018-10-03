local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffuse(0,0,0,0):accelerate(0.2):diffusealpha(1)
	end;
}

return t;