local t = Def.ActorFrame{};

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;fadetop,0.4;fadebottom,0.4;diffuse,0,1,0,0.3);
};

return t;