local t = Def.ActorFrame{};

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,Color.Black;sleep,2);
}

t[#t+1] = Def.Sprite {
	CurrentSongChangedMessageCommand=function(self)
	self:stoptweening()
	self:linear(0.05):diffusealpha(0)
	self:LoadFromCurrentSongBackground()
	:queuecommand("UpdateBackground")
	end,
	UpdateBackgroundCommand=function(self)
	if GAMESTATE:GetCurrentSong() then
		self:LoadFromCurrentSongBackground()
		self:scale_or_crop_background()
		self:diffusealpha(0)
		self:sleep(1)
		self:decelerate(0.2)
		self:diffuse(0.7,0.7,0.7,1)
	end
	end,
	OnCommand=function(self)
		self:scale_or_crop_background()
		self:diffusealpha(0)
		self:sleep(1)
		self:decelerate(0.2)
		self:diffuse(0.7,0.7,0.7,1)
	end;
};

t[#t+1] = Def.Quad{
	OnCommand=cmd(diffuse,Color.Black;y,SCREEN_BOTTOM-30;horizalign,left;vertalign,bottom;zoomto,500,100;faderight,1);
}

return t;