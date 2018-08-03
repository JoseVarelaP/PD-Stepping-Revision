local GradeP1 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetGrade()
local GradeP2 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetGrade()

local function failed(g)
	if g == "Grade_Failed" then
		return true;
	else
		return false;
	end
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

-- Load the character BEFORE doing anything.
-- This is because calling the command will make a mesh of 
-- loading everything with other characters.
local CharacterToLoad = CHARMAN:GetRandomCharacter();

t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(fov,90;);
	Def.Model {
		Meshes=CharacterToLoad:GetModelPath(),
		Materials=CharacterToLoad:GetModelPath(),
		-- For this, we'll change the location to a bone being used,
		-- by using a function to call it.
		-- Let's setup the Rest animation for now.
		Bones=CharacterToLoad:GetRestAnimationPath(),
		OnCommand=function(self)
			-- Set their y rotation to our view.
			-- And also apply a z that will get the model closer to the camera.
			-- Now that we've setup the rest animation, we'll need to also setup the Y position
			-- back to a lower one.
			self:Center():rotationy(200):zoom(20):addy(270):z(200)
			:x(SCREEN_RIGHT-330)
			-- lets pause the animation
			:rate(0.35):cullmode("CullMode_None")
		end,
	};
};

t[#t+1] = LoadActor( THEME:GetPathG("","Light_BottomMenuBar") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;horizalign,right;zoom,2;SetTextureFiltering,false;;y,SCREEN_BOTTOM;vertalign,bottom);
};

t[#t+1] = LoadActor( THEME:GetPathG("","Light_TopMenuBar") )..{
	OnCommand=cmd(x,SCREEN_LEFT;horizalign,left;zoom,2;SetTextureFiltering,false;vertalign,top);
};

t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/TuneIcon") )..{
	OnCommand=cmd(x,SCREEN_LEFT+10;y,10;horizalign,left;zoom,2;SetTextureFiltering,false;vertalign,top);
};

t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-30;y,SCREEN_BOTTOM-100);
	LoadActor( THEME:GetPathG("","Evaluation/BGStatus") )..{
	OnCommand=cmd(horizalign,right;zoom,2);
	};
	LoadActor( THEME:GetPathG("","Evaluation/Status") )..{
	InitCommand=cmd(horizalign,right;zoom,2;y,5;pause);
	OnCommand=function(self)
		self:setstate(Stats_FrameState)
	end,
	};
};

-- Info start
	t[#t+1] = LoadFont("Common Normal")..{
	InitCommand=cmd(strokecolor,Color.Black);
	OnCommand=cmd(zoom,0.7;horizalign,left;x,SCREEN_CENTER_X+90;y,23;playcommand,"Update");
	UpdateCommand=function(self) self:settext( (GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():GetDisplayMainTitle()) or "" ) end,
	};

t[#t+1] = LoadFont("Common Normal")..{
	Text="Track Results";
	InitCommand=cmd(strokecolor,Color.Black);
	OnCommand=cmd(zoom,1;horizalign,left;x,SCREEN_LEFT+40;y,21);
	};

t[#t+1] = Def.ActorFrame{
	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Evaluation/InfoBarBG", Width=300, Height=15 } )..{
		OnCommand=cmd(x,SCREEN_LEFT+250;y,SCREEN_CENTER_Y-160);
	};
	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Evaluation/InfoBarBG", Width=300, Height=15 } )..{
		OnCommand=cmd(x,SCREEN_LEFT+250;y,SCREEN_CENTER_Y-113);
	};

	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Evaluation/InfoBarBG", Width=300, Height=160 } )..{
		OnCommand=cmd(x,SCREEN_LEFT+250;y,SCREEN_CENTER_Y+5);
	};

	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Evaluation/InfoBarBG", Width=300, Height=20 } )..{
		OnCommand=cmd(x,SCREEN_LEFT+250;y,SCREEN_CENTER_Y+128);
	};
}


local Players = GAMESTATE:GetHumanPlayers()

local function NoteScore(pn,n)
	return STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores(n)
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
	-- t[#t+1] = Def.BitmapText{
	-- 	Text=string.format("% 4d", STATSMAN:GetCurStageStats():GetPlayerStageStats(player):MaxCombo() ),
	-- 	Font="Common Normal",
	-- 	OnCommand=function(self)
	-- 	self:x( (player == PLAYER_1 and SCREEN_CENTER_X-160) or SCREEN_CENTER_X+160 ):y( SCREEN_CENTER_Y+105 )
	-- 	:diffuse(Color.Black):zoom(0.6)
	-- 	end,
	-- };

	t[#t+1] = Def.BitmapText{
		Text=string.format("% 4d", STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetScore() ),
		Font="Common Normal",
		OnCommand=function(self)
		self:horizalign(right)
		self:x( (player == PLAYER_1 and SCREEN_CENTER_X-50) or SCREEN_CENTER_X+160 ):y( SCREEN_CENTER_Y+128 )
		:zoom(1.2)
		end,
	};

	t[#t+1] = Def.BitmapText{
		Text="SCORE",
		Font="Common Normal",
		OnCommand=function(self)
		self:horizalign(left)
		self:x( (player == PLAYER_1 and SCREEN_CENTER_X-320) or SCREEN_CENTER_X+160 ):y( SCREEN_CENTER_Y+128 )
		:zoom(1.2)
		end,
	};

	for NVal in ivalues(spacing) do
		t[#t+1] = Def.BitmapText{
		Text=string.format("% 4d", NoteScore(player,ValuesToFind[NVal]) ),
		Font="Common Normal",
		OnCommand=function(self)
		self:x( (player == PLAYER_1 and SCREEN_CENTER_X-60) or SCREEN_CENTER_X+130 ):y( SCREEN_CENTER_Y-100+(30*NVal) )
		:horizalign(right):zoom(1)
		end,
		};

		t[#t+1] = Def.BitmapText{
		Text=":",
		Font="Common Normal",
		OnCommand=function(self)
		self:x( (player == PLAYER_1 and SCREEN_CENTER_X-180) or SCREEN_CENTER_X+130 ):y( SCREEN_CENTER_Y-100-2+(30*NVal) )
		:horizalign(right):zoom(1)
		end,
		};

		t[#t+1] = LoadActor( THEME:GetPathG("","Evaluation/SideJudgment") )..{
		OnCommand=function(self)
		self:pause():horizalign(left):setstate(spacing[NVal]-1)
		:x( (player == PLAYER_1 and SCREEN_CENTER_X-240) or SCREEN_CENTER_X+130 ):y( SCREEN_CENTER_Y-100+(30*NVal) )
		:horizalign(right):zoom(1)
		end,
		};
	end
end
return t;