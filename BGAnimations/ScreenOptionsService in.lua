local t = Def.ActorFrame{
	OnCommand=function(self)
	-- Update the stage list
	LOADER:LoadStages()
	LOADER:LoadStageNames()
	end,
}

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffuse(Color.Black):decelerate(0.3):diffusealpha(0)
	end;
}

return t;