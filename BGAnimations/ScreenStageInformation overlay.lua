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

t[#t+1] = Def.Sprite {
		InitCommand=cmd(diffusealpha,1;horizalign,left;vertalign,bottom;x,SCREEN_LEFT+10;y,SCREEN_BOTTOM-38);
		CurrentSongChangedMessageCommand=function(self)
		self:stoptweening()
		self:linear(0.05):diffusealpha(0)
		:queuecommand("UpdateBackground")
		end,
		UpdateBackgroundCommand=function(self)
		if GAMESTATE:GetCurrentSong() then
			self:LoadFromCurrentSongBackground():diffusealpha(1)
			self:setsize(170/2,170/2)
		end
		end,
		OnCommand=function(self)
			self:shadowlength(10):diffusealpha(0):linear(0.5):diffusealpha(1)
			self:setsize(170/2,170/2)
		end;
	};

return t;