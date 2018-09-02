local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{ OnCommand=cmd(FullScreen;diffuse,Color.Black;decelerate,0.5;diffusealpha,0); };

return t;