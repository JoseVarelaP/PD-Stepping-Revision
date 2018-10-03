local t = Def.ActorFrame{};

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:zoomto(SCREEN_WIDTH,25):diffuse(0,0,0,1):CenterX():vertalign(top):ztest(1)
	end;
};

t[#t+1] = LoadActor( THEME:GetPathG("","TopBarText") )..{
	OnCommand=function(self)
		self:vertalign(top):horizalign(right):x(SCREEN_RIGHT):diffusealpha(0.6):rotationz(-2.6):y(-2):zoom(0.8)
	end;
};

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:zoomto(SCREEN_WIDTH,25):diffuse(0,0,0,1):CenterX():vertalign(bottom):y(SCREEN_BOTTOM)
	end;
};

return t;