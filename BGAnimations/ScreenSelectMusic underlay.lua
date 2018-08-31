local t = Def.ActorFrame{}

OldSong = GAMESTATE:GetCurrentSong();

t[#t+1] = Def.Sprite {
	CurrentSongChangedMessageCommand=function(self)
 	self:finishtweening()
 	self:sleep(0.1)
 	self:queuecommand("BeginProcess")
 	end,
 	BeginProcessCommand=function(self)
 	self:queuecommand("UpdateBackground")
 	end,
 	UpdateBackgroundCommand=function(self)
		self:finishtweening()
 		if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():GetBackgroundPath() then
 			self:visible(true)
 			self:LoadBackground(GAMESTATE:GetCurrentSong():GetBackgroundPath())
			self:scaletocover(0,0,SCREEN_WIDTH,SCREEN_BOTTOM)
 			self:diffusealpha(1)
 		else
 			self:visible(false)
 		end
 	end,
};

t[#t+1] = Def.Sprite {
	CurrentSongChangedMessageCommand=function(self)
 		self:finishtweening()
 		self:croptop(0)
 		self:fadetop(0)
 		self:cropbottom(0)
 		self:fadebottom(0)
 		self:sleep(0.2):smooth(0.4):fadebottom(0.8):cropbottom(1):sleep(0.1)
 	self:queuecommand("BeginProcess")
 	end,
 	BeginProcessCommand=function(self)
 	self:queuecommand("UpdateBackground")
 	end,
 	UpdateBackgroundCommand=function(self)
		self:finishtweening()
 		if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():GetBackgroundPath() then
			self:finishtweening()
			self:fadetop(0.8)
			self:croptop(1)
 			self:visible(true)
 			self:LoadBackground(GAMESTATE:GetCurrentSong():GetBackgroundPath())
			self:scaletocover(0,0,SCREEN_WIDTH,SCREEN_BOTTOM)
 			self:smooth(0.3)
			self:fadetop(0)
			self:croptop(0)
 			self:diffusealpha(1)
 		else
 			self:visible(false)
 			self:LoadBackground(THEME:GetPathG("","_blank"))
 		end
 	end,
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
 			self:finishtweening():smooth(0.1):diffusealpha(0):sleep(0.1):queuecommand("UpdateBackground")
 		end,
		UpdateBackgroundCommand=function(self)
		self:finishtweening()
 		if GAMESTATE:GetCurrentSong() then
			self:finishtweening()
 			self:visible(true)
 			if GAMESTATE:GetCurrentSong():GetJacketPath() then
 				self:LoadBackground(GAMESTATE:GetCurrentSong():GetJacketPath())
 				self:setsize(400/2,400/2)
 			else
 				self:LoadBackground(GAMESTATE:GetCurrentSong():GetBackgroundPath())
 				self:setsize(450/2,450/2)
 			end
			self:rotationz(-10):x(-270):decelerate(0.3):x(-250):rotationz(-5):diffusealpha(1)
 		else
 			self:visible(false)
 		end
		end,
		OnCommand=function(self)
			self:shadowlength(10):diffusealpha(0):linear(0.5):diffusealpha(1)
			self:setsize(400/2,400/2)
		end;
	};

	LoadFont("Common Normal")..{
		InitCommand=cmd(diffusealpha,1;horizalign,left;x,WideScale(-280,-400);y,40;strokecolor,Color.Black;rotationz,-2;maxwidth,WideScale(260,550));
		CurrentSongChangedMessageCommand=function(self)
 			self:finishtweening():smooth(0.1):diffusealpha(0):sleep(0.1):queuecommand("UpdateBackground")
 		end,
		UpdateBackgroundCommand=function(self)
		self:finishtweening()
		self:settext("")
 		if GAMESTATE:GetCurrentSong() and not GAMESTATE:GetCurrentSong():GetCDImagePath() then
			self:settext( GAMESTATE:GetCurrentSong():GetDisplayMainTitle() )
 		end
 		self:zoom(1.1)
 		self:smooth(0.1)
 		self:diffusealpha(1)
 		self:zoom(1)
		end,
		OnCommand=function(self)
			self:shadowlength(5):diffusealpha(0):linear(0.5):diffusealpha(1)
		end;
	};

	LoadFont("Common Normal")..{
		InitCommand=cmd(diffusealpha,1;horizalign,left;x,WideScale(-280,-400);y,65;strokecolor,Color.Black;rotationz,-2;maxwidth,WideScale(340,550));
		CurrentSongChangedMessageCommand=function(self)
 			self:finishtweening():smooth(0.1):diffusealpha(0):sleep(0.1):queuecommand("UpdateBackground")
 		end,
		UpdateBackgroundCommand=function(self)
		self:finishtweening()
		self:settext("")
		self:y(65)
 		if GAMESTATE:GetCurrentSong() and not GAMESTATE:GetCurrentSong():GetCDImagePath() then
			self:settext( GAMESTATE:GetCurrentSong():GetDisplayArtist() )
			if GAMESTATE:GetCurrentSong():GetDisplaySubTitle() == "" then
 				self:y(60)
 			end
 		end
 		self:zoom(0.85)
 		self:smooth(0.1)
 		self:diffusealpha(1)
 		self:zoom(0.8)
		end,
		OnCommand=function(self)
			self:shadowlength(5):diffusealpha(0):linear(0.5):diffusealpha(1)
		end;
	};

	LoadFont("Common Normal")..{
		InitCommand=cmd(diffusealpha,1;horizalign,left;x,WideScale(-280,-400);y,53;strokecolor,Color.Black;rotationz,-2;maxwidth,WideScale(340,550));
		CurrentSongChangedMessageCommand=function(self)
 			self:finishtweening():smooth(0.1):diffusealpha(0):sleep(0.1):queuecommand("UpdateBackground")
 		end,
		UpdateBackgroundCommand=function(self)
		self:finishtweening()
		self:settext("")
 		if GAMESTATE:GetCurrentSong() and not GAMESTATE:GetCurrentSong():GetCDImagePath() then
			self:settext( GAMESTATE:GetCurrentSong():GetDisplaySubTitle() )
 		end
 		self:zoom(0.65)
 		self:smooth(0.1)
 		self:diffusealpha(1)
 		self:zoom(0.6)
		end,
		OnCommand=function(self)
			self:shadowlength(5):diffusealpha(0):linear(0.5):diffusealpha(1)
		end;
	};

	--[[
		Special cases where the song transparent logo banner is available
		These are hosted on the CDImagePath string found in the .ssc.

		Recommended size is 512x256. If you preffer a higher quality variant,
		Use 1024x512, and make the texture handle doubleres by adding this to the file name.

		MyTextBanner (doubleres).png
	--]]
	Def.Sprite {
		InitCommand=cmd(diffusealpha,1;x,-300;y,50);
		BeginCommand=cmd(LoadFromCurrentSongBackground);
		CurrentSongChangedMessageCommand=function(self)
 			self:finishtweening():smooth(0.1):diffusealpha(0):sleep(0.1):queuecommand("UpdateBackground")
 		end,
		UpdateBackgroundCommand=function(self)
		self:finishtweening()
 		if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():GetCDImagePath() then
			self:finishtweening()
 			self:visible(true)
 			self:LoadBackground(GAMESTATE:GetCurrentSong():GetCDImagePath())
 			self:zoom(0.7)
			self:decelerate(0.2):diffusealpha(1)
			self:zoom(0.6)
 		else
 			self:visible(false)
 		end
		end,
		OnCommand=function(self)
			self:shadowlength(4):diffusealpha(0):zoom(0.7):linear(0.5):diffusealpha(1):zoom(0.6)
		end;
	};

}

return t;