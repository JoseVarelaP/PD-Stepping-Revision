local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	 OnCommand=function(self)
		self:FullScreen():diffuse(Color.Black):decelerate(0.5):diffusealpha(0)
	end
};

return t;