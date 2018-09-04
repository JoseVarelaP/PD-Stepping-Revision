local GradeP1 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetGrade()
local GradeP2 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetGrade()

local function failed(pn, g)
	return g == "Grade_Failed"
end

local Stats_FrameState = 0

if (GAMESTATE:IsHumanPlayer(PLAYER_1) and failed(GradeP1) and not GAMESTATE:IsHumanPlayer(PLAYER_2)) then
	Stats_FrameState = 1
	
--< ----------------------------------------------> --
-- if (only P2) and (P2 failed)	
--< ----------------------------------------------> --
elseif (GAMESTATE:IsHumanPlayer(PLAYER_2) and failed(GradeP2) and not GAMESTATE:IsHumanPlayer(PLAYER_1)) then
	Stats_FrameState = 1

--< ----------------------------------------------> --
-- if (both P1 and P2) and (both P1 and P2 failed)	
--< ----------------------------------------------> --
elseif (GAMESTATE:IsHumanPlayer(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_2) and failed(GradeP1) and failed(GradeP2) ) then
	Stats_FrameState = 1
end

local t = Def.ActorFrame{}

t[#t+1] = LoadActor( THEME:GetPathG("","Evaluation/Header") )..{
	OnCommand=cmd(shadowlengthy,3;horizalign,left;vertalign,top;zoom,1.2;x,SCREEN_LEFT-300;y,12);
	};

t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y-145);
	LoadActor( THEME:GetPathG("","Evaluation/StatusBG") )..{
	OnCommand=cmd(shadowlengthy,3;zoom,1.2);
	};
};

t[#t+1] = Def.Sprite {
	InitCommand=cmd(diffusealpha,1;horizalign,left;x,SCREEN_LEFT+100;y,SCREEN_CENTER_Y+20;diffusealpha,0);
	BeginCommand=cmd(queuecommand,"UpdateBackground");
	UpdateBackgroundCommand=function(self)
	self:finishtweening()
	self:visible(false)
 	if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():GetBackgroundPath() then
		self:finishtweening()
 		self:visible(true)
 		self:LoadBackground(GAMESTATE:GetCurrentSong():GetBackgroundPath())
		self:setsize(450/2,400/2)
		:rotationz(-10):x(SCREEN_LEFT+80):decelerate(0.3):x(SCREEN_LEFT+100):rotationz(-5):diffusealpha(1)
 	end
	end,
	OnCommand=function(self)
		self:shadowlength(10):diffusealpha(0):linear(0.5):diffusealpha(1)
		self:setsize(450/2,400/2)
	end;
};


local Players = GAMESTATE:GetHumanPlayers()

local function NoteScore(pn,n)
	return STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores(n)
end

local function NotePercentage(pn,n)
	return FormatPercentScore(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPercentageOfTaps(n))
end

local ValuesToFind = {
	'TapNoteScore_W1',
	'TapNoteScore_W2',
	'TapNoteScore_W3',
	'TapNoteScore_W4',
	'TapNoteScore_W5',
	'TapNoteScore_Miss',
}

local spacing = {1,2,3,4,5,6}

for player in ivalues(Players) do
	t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
	self:x( SCREEN_RIGHT-50 )
	:y( SCREEN_CENTER_Y+20 )
	end;

		LoadActor( THEME:GetPathG("","Evaluation/ScoreInfoBG") )..{
			InitCommand=cmd(horizalign,right;zoom,1.3;shadowlengthy,3);
		};

		Def.BitmapText{
			Text=string.format("% 4d", STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetScore() ),
			Font="dinamight/25px",
			InitCommand=cmd(strokecolor,color("#2B3D44"));
			OnCommand=function(self)
			self:horizalign(right):x( -30 ):y( 105 ):zoom(0.9)
			end,
		};
	
		Def.BitmapText{
			Text="SCORE",
			Font="dinamight/25px",
			InitCommand=cmd(strokecolor,color("#2B3D44"));
			OnCommand=function(self)
			self:horizalign(left):x( -370 ):y( 105 ):zoom(0.9)
			end,
		};

	};

	for NVal in ivalues(spacing) do
		t[#t+1] = Def.BitmapText{
		Text=string.format("% 4d", NoteScore(player,ValuesToFind[NVal]) ).." /",
		Font="dinamight/25px",
		InitCommand=cmd(strokecolor,color("#2B3D44"));
		OnCommand=function(self)
		self:x( (player == PLAYER_1 and SCREEN_CENTER_X+260) or SCREEN_CENTER_X+130 ):y( SCREEN_CENTER_Y-(129-20)+(22.9*NVal) )
		:horizalign(right):zoom(0.7)
		end,
		};

		t[#t+1] = Def.BitmapText{
		Text=NotePercentage(player,ValuesToFind[NVal]),
		Font="dinamight/25px",
		InitCommand=cmd(strokecolor,color("#2B3D44"));
		OnCommand=function(self)
		self:x( (player == PLAYER_1 and SCREEN_CENTER_X+355) or SCREEN_CENTER_X+130 ):y( SCREEN_CENTER_Y-(129-20)+(22.9*NVal) )
		:horizalign(right):zoom(0.7):cropright(0.6)
		end,
		};

		t[#t+1] = Def.BitmapText{
		Text=string.sub(NotePercentage(player,ValuesToFind[NVal]), 3),
		Font="dinamight/25px",
		InitCommand=cmd(strokecolor,color("#2B3D44"));
		OnCommand=function(self)
		self:x( (player == PLAYER_1 and SCREEN_CENTER_X+350) or SCREEN_CENTER_X+130 ):y( SCREEN_CENTER_Y-(129-21)+(22.9*NVal) )
		:horizalign(right):zoom(0.6)
		end,
		};

		t[#t+1] = Def.BitmapText{
		Text=":",
		Font="dinamight/25px",
		InitCommand=cmd(strokecolor,color("#2B3D44"));
		OnCommand=function(self)
		self:x( (player == PLAYER_1 and SCREEN_CENTER_X+160) or SCREEN_CENTER_X+130 ):y( SCREEN_CENTER_Y-(129-20)+(22.9*NVal) )
		:horizalign(right):zoom(.7)
		end,
		};

		t[#t+1] = LoadActor( THEME:GetPathG("","Evaluation/SideJudgment") )..{
		OnCommand=function(self)
		self:pause():horizalign(left):setstate(spacing[NVal]-1)
		:x( (player == PLAYER_1 and SCREEN_CENTER_X+80) or SCREEN_CENTER_X+130 ):y( SCREEN_CENTER_Y-(129-20)+(22.9*NVal) )
		:horizalign(right):zoom(1)
		end,
		};
	end
end
return t;