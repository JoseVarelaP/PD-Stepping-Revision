local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,0,0,0,0;accelerate,3;diffusealpha,1);
}

return t;