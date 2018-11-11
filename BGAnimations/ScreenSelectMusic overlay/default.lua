local t = Def.ActorFrame{
	InitCommand=function()
	DIVA:UpdateSongGroupListing()
	end,
	OnCommand=function(self)
	DIVA:ResetRandomSong()
	MESSAGEMAN:Broadcast("HideBackground")
	self:queuecommand("LoopPrint")
	end,
	LoopPrintCommand=function(self)
	end,
	CurrentStepsP1ChangedMessageCommand=function(self) MESSAGEMAN:Broadcast("UpdateSteps") end;
	CurrentStepsP2ChangedMessageCommand=function(self) MESSAGEMAN:Broadcast("UpdateSteps") end;
	CurrentSongChangedMessageCommand=function(self)
		self:queuemessage("UpdateSteps")
	end;
}

-- Previewer. It's the difficulty list preview you see when you press
-- Enter on a song.
t[#t+1] = LoadActor("SongPreviewer");

-- Course display
if GAMESTATE:IsCourseMode() then
t[#t+1] = LoadActor( THEME:GetPathG("","Playlists/CourseDisplayList.lua") )..{
	OnCommand=function(self)
		self:x(SCREEN_RIGHT-230):CenterY()
	end;
};
end

-- Message for the new player that joined.
for player in ivalues(PlayerNumber) do
	t[#t+1] = LoadActor("PlayerJoin.lua", player);
end

t[#t+1] = LoadActor( THEME:GetPathG("","SelectMusic/DiffBase") )..{
	OnCommand=function(self)
		self:vertalign(top):horizalign(right):xy(SCREEN_RIGHT,30):zoom(0.6):shadowlengthy(3)
	end;
};

t[#t+1] = LoadActor( THEME:GetPathG("","SelectMusic/SortDisplay") )..{
	InitCommand=function(self)
		self:vertalign(top):horizalign(right):xy(SCREEN_CENTER_X+60,110):zoom(0.6)
	end;
	OnCommand=function(self)
		self:diffusealpha(0):addx(10):decelerate(0.2):diffusealpha(1):addx(-10)
	end;
};

if ThemePrefs.Get("DedicatedCharacterShow") then
	t[#t+1] = LoadActor( THEME:GetPathG("","SelectMusic/CharacterShow") )..{
		InitCommand=function(self)
			self:vertalign(bottom):horizalign(right):xy(SCREEN_RIGHT-250,SCREEN_BOTTOM-90):zoom(0.8)
		end;
		OnCommand=function(self)
			self:diffusealpha(0):addx(10):decelerate(0.2):diffusealpha(1):addx(-10)
		end;
	};
end

t[#t+1] = LoadActor( THEME:GetPathG("","SelectMusic/ScoreDisplay") )..{
	InitCommand=function(self)
		self:vertalign(bottom):horizalign(right):xy(SCREEN_RIGHT-90,SCREEN_BOTTOM-90):zoom(0.8)
	end;
	OnCommand=function(self)
		self:diffusealpha(0):addx(10):decelerate(0.2):diffusealpha(1):addx(-10)
	end;
};

t[#t+1] = LoadActor( THEME:GetPathG("","SelectMusic/TotalToComplete") )..{
	InitCommand=function(self)
		self:vertalign(bottom):horizalign(left):xy(SCREEN_LEFT+10,SCREEN_BOTTOM-70):zoom(0.7)
	end;
	OnCommand=function(self)
		self:diffusealpha(0):addx(-10):decelerate(0.2):diffusealpha(1):addx(10)
	end;
};

-- Button Help
t[#t+1] = LoadActor("ButtonHelp");

t[#t+1] = LoadActor("../Borders.lua");

t[#t+1] = LoadFont("Common Normal")..{
	Text=Screen.String("HeaderText");
	InitCommand=function(self)
		self:vertalign(top):horizalign(left):xy(30,6):zoom(0.8)
	end;
};

t[#t+1] = LoadFont("Common Normal")..{
	Text=THEME:GetString("ScreenSelectMusic","Tip_ButtonHelp");
	InitCommand=function(self)
		self:vertalign(bottom):horizalign(left):xy(10,SCREEN_BOTTOM-8):zoom(0.6):maxwidth(SCREEN_WIDTH*1.6)
	end;
	PreviousSongMessageCommand=function(self)
		self:playcommand("RegularTextFade")
	end;
	NextSongMessageCommand=function(self)
		self:playcommand("RegularTextFade")
	end;
	TwoPartConfirmCanceledMessageCommand=function(self)
	self:decelerate(0.2):diffusealpha(0):queuecommand("UpdateTextInst_DiffSel")
	end,
	UpdateTextInst_DiffSelCommand=function(self)
	self:accelerate(0.2):diffusealpha(1):settext( THEME:GetString("ScreenSelectMusic","Inst_DiffSel") )
	end,
	StartSelectingStepsMessageCommand=function(self)
	AlreadyExited = false
	self:decelerate(0.2):diffusealpha(0):queuecommand("UpdateTextInst_Decided")
	end,
	UpdateTextInst_DecidedCommand=function(self)
	self:accelerate(0.2):diffusealpha(1):settext( THEME:GetString("ScreenSelectMusic","Inst_Decided") )
	end,
	RegularTextFadeCommand=function(self)
	if not AlreadyExited then
		AlreadyExited = true
		self:decelerate(0.2):diffusealpha(0):queuecommand("RegularTextSet")
	end
	end,
	RegularTextSetCommand=function(self)
	self:accelerate(0.2):diffusealpha(1):settext( THEME:GetString("ScreenSelectMusic","Tip_ButtonHelp") )
	end,
};

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffuse(Color.Black):diffusealpha(0)
	end;
	OffCommand=function(self)
		self:linear(0.2):diffusealpha(1)
	end;
};
return t;