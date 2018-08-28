local t = Def.ActorFrame{}

t[#t+1] = LoadActor( THEME:GetPathG("","Light_BottomMenuBar") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;horizalign,right;zoom,2;SetTextureFiltering,false;;y,SCREEN_BOTTOM;vertalign,bottom);
};

t[#t+1] = Def.Sprite {
	CurrentSongChangedMessageCommand=function(self)
	self:stoptweening()
	self:linear(0.05):diffusealpha(0)
	:queuecommand("UpdateBackground")
	end,
	UpdateBackgroundCommand=function(self)
	if GAMESTATE:GetCurrentSong() then
		self:LoadFromCurrentSongBackground()
		self:scale_or_crop_background()
		self:linear(0.05)
		self:diffusealpha(1)
	end
	end,
	OnCommand=function(self)
		self:scale_or_crop_background()
	end;
};

t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(x,WideScale(SCREEN_RIGHT,SCREEN_RIGHT);y,SCREEN_CENTER_Y;diffusealpha,0;zoom,0.8;sleep,0.3;decelerate,0.2;zoom,1;diffusealpha,1);
	OffCommand=cmd(playcommand,"GoAway");
	CancelMessageCommand=cmd(playcommand,"GoAway");
	GoAwayCommand=cmd(accelerate,0.2;addx,100;diffusealpha,0);

	Def.Sprite {
		InitCommand=cmd(diffusealpha,1;horizalign,left;x,-250);
		BeginCommand=cmd(LoadFromCurrentSongBackground);
		CurrentSongChangedMessageCommand=function(self)
		self:stoptweening()
		self:linear(0.05):diffusealpha(0)
		:queuecommand("UpdateBackground")
		end,
		UpdateBackgroundCommand=function(self)
		if GAMESTATE:GetCurrentSong() then
			self:LoadFromCurrentSongBackground()
			self:setsize(400/2,400/2):rotationz(-10):x(-270):decelerate(0.3):x(-250):rotationz(-5):diffusealpha(1)
		end
		end,
		OnCommand=function(self)
			self:shadowlength(10):diffusealpha(0):linear(0.5):diffusealpha(1)
			self:setsize(400/2,400/2)
		end;
	};

}

return t;