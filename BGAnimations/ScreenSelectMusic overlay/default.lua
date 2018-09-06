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
	CurrentSongChangedMessageCommand=cmd(queuemessage,"UpdateSteps");
}

-- Previewer. It's the difficulty list preview you see when you press
-- Enter on a song.
t[#t+1] = LoadActor("SongPreviewer");

-- Course display
if GAMESTATE:IsCourseMode() then
t[#t+1] = LoadActor( THEME:GetPathG("","Playlists/CourseDisplayList.lua") )..{
	OnCommand=cmd(x,SCREEN_RIGHT-230;CenterY);
};
end

-- Message for the new player that joined.
for player in ivalues(PlayerNumber) do
	t[#t+1] = LoadActor("PlayerJoin.lua", player);
end

t[#t+1] = LoadActor( THEME:GetPathG("","SelectMusic/DiffBase") )..{
	OnCommand=cmd(vertalign,top;horizalign,right;xy,SCREEN_RIGHT,30;zoom,0.6;shadowlengthy,3);	
};

t[#t+1] = LoadActor( THEME:GetPathG("","SelectMusic/SortDisplay") )..{
	InitCommand=cmd(vertalign,top;horizalign,right;xy,SCREEN_CENTER_X+60,110;zoom,0.6);
	OnCommand=cmd(diffusealpha,0;addx,10;decelerate,0.2;diffusealpha,1;addx,-10);
};

if ThemePrefs.Get("DedicatedCharacterShow") then
	t[#t+1] = LoadActor( THEME:GetPathG("","SelectMusic/CharacterShow") )..{
		InitCommand=cmd(vertalign,bottom;horizalign,right;xy,SCREEN_RIGHT-250,SCREEN_BOTTOM-90;zoom,0.8;);	
		OnCommand=cmd(diffusealpha,0;addx,10;decelerate,0.2;diffusealpha,1;addx,-10);
	};
end

t[#t+1] = LoadActor( THEME:GetPathG("","SelectMusic/ScoreDisplay") )..{
	InitCommand=cmd(vertalign,bottom;horizalign,right;xy,SCREEN_RIGHT-90,SCREEN_BOTTOM-90;zoom,0.8;);	
	OnCommand=cmd(diffusealpha,0;addx,10;decelerate,0.2;diffusealpha,1;addx,-10);
};

t[#t+1] = LoadActor( THEME:GetPathG("","SelectMusic/TotalToComplete") )..{
	InitCommand=cmd(vertalign,bottom;horizalign,left;xy,SCREEN_LEFT+10,SCREEN_BOTTOM-70;zoom,0.7;);	
	OnCommand=cmd(diffusealpha,0;addx,-10;decelerate,0.2;diffusealpha,1;addx,10);
};

-- Button Help
t[#t+1] = LoadActor("ButtonHelp");

t[#t+1] = LoadActor("../Borders.lua");

t[#t+1] = LoadFont("Common Normal")..{
	Text=Screen.String("HeaderText");
	InitCommand=cmd(vertalign,top;horizalign,left;xy,30,6;zoom,0.8);
};

t[#t+1] = LoadFont("Common Normal")..{
	Text="Stuck? Press the &SELECT; button for a button guide.";
	InitCommand=cmd(vertalign,bottom;horizalign,left;xy,10,SCREEN_BOTTOM-8;zoom,0.6;maxwidth,SCREEN_WIDTH*1.6);
	PreviousSongMessageCommand=cmd(playcommand,"RegularTextFade");
	NextSongMessageCommand=cmd(playcommand,"RegularTextFade");
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
	self:accelerate(0.2):diffusealpha(1):settext( "Stuck? Press the &SELECT; button for a button guide." )
	end,
};

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,Color.Black;diffusealpha,0);
	OffCommand=cmd(linear,0.2;diffusealpha,1);
};
return t;