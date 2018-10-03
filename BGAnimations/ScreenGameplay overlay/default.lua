local t = Def.ActorFrame{};

t[#t+1] = LoadActor("InfoBar")..{
	OnCommand=function(self)
		self:addy(-100):linear(3):addy(100)
	end;
};

t[#t+1] = LoadActor("PercentageBar")..{
	OnCommand=function(self)
		self:addy(100):linear(3):addy(-100)
	end;
};


-- Need to remake this one!

-- t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/TuneIcon") )..{
-- 	OnCommand=cmd(x,SCREEN_LEFT+10;y,7;horizalign,left;zoom,2;SetTextureFiltering,false;vertalign,top);
-- };


t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():linear(1):diffusealpha(0)
	end;
};

return t;