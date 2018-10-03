local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffuse(0,0,0,0):sleep(0.3):accelerate(0.3):diffusealpha(1)
	end;
}

return t;