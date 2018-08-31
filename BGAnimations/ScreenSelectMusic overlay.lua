-- hi im jose and welcome to jackass
local CurrentSong = GAMESTATE:GetCurrentSong();


local t = Def.ActorFrame{
	OnCommand=function(self)
	DIVA:ResetRandomSong()
	MESSAGEMAN:Broadcast("HideBackground")
	end,
	CurrentStepsP1ChangedMessageCommand=function(self) MESSAGEMAN:Broadcast("UpdateSteps") end;
	CurrentStepsP2ChangedMessageCommand=function(self) MESSAGEMAN:Broadcast("UpdateSteps") end;
	CurrentSongChangedMessageCommand=cmd(queuemessage,"UpdateSteps");
}

local function BothPlayersEnabled()
	return GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2)
end

local function JustASinglePlayer(pn)
	if pn == PLAYER_1 then return GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) end
	if pn == PLAYER_2 then return GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) end
end

local function DiffuseColorForBothPlayers(self)
	if BothPlayersEnabled() then
		if GAMESTATE:GetCurrentSteps(PLAYER_1) then
			self:diffuseleftedge( CustomDifficultyToColor( GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() ) )
		end
		if GAMESTATE:GetCurrentSteps(PLAYER_2) then
			self:diffuserightedge( CustomDifficultyToColor( GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() ) )
		end
	end
end

local function InvertSongBase()
	WhatToLoad = "Color_WheelSong"
	if BothPlayersEnabled() then WhatToLoad = "2PColor_WheelSong" end
	return WhatToLoad
end

local EntireSongTable = SONGMAN:GetAllSongs();

------ ------ ------ ------ ------ ------ ------
------ ------ ------ ------ ------ ------ ------
------ End functionland begin actual mess ------
------ ------ ------ ------ ------ ------ ------
------ ------ ------ ------ ------ ------ ------


t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("_switch","up")) .. {
		SelectMenuOpenedMessageCommand=cmd(stop;play);
	};

	Def.ActorFrame {
		OnCommand=cmd(CenterY;x,WideScale(SCREEN_LEFT+180,SCREEN_LEFT+230);diffusealpha,0;zoom,0);
		StartSelectingStepsMessageCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,1;zoom,0.6);
		PreviousSongMessageCommand=cmd(playcommand,"Close");
		NextSongMessageCommand=cmd(playcommand,"Close");
		StepsChosenMessageCommand=cmd(playcommand,"Close");
		PlayerJoinedMessageCommand=cmd(playcommand,"Close");
		CancelMessageCommand=cmd(playcommand,"Close");
		CloseCommand=cmd(stoptweening;accelerate,0.2;diffusealpha,0;zoom,0.5);

		LoadActor( THEME:GetPathG("","SelectMusic/SummarySelection") )..{
		OnCommand=cmd(y,35;zoom,1.2);
		};

		LoadFont("Common Bold")..{
			Text="I will update",
			OnCommand=cmd(diffuse,0,0,0,1);
			StartSelectingStepsMessageCommand=function(self) self:settext( GAMESTATE:GetCurrentSong():GetDisplayMainTitle() ) end,
			InitCommand=cmd(maxwidth,300;zoom,1.2;wrapwidthpixels,500;horizalign,left;x,-260;vertspacing,8;vertalign,top;y,-75);
		};
		LoadFont("Common Bold")..{
			Text="I will update",
			OnCommand=cmd(diffuse,0,0,0,1);
			StartSelectingStepsMessageCommand=function(self) self:settext( GAMESTATE:GetCurrentSong():GetDisplaySubTitle() ) end,
			InitCommand=cmd(maxwidth,300;zoom,0.8;wrapwidthpixels,500;horizalign,left;x,-260;vertspacing,8;vertalign,top;y,-50);
		};
		LoadFont("Common Bold")..{
			Text="I will update",
			OnCommand=cmd(diffuse,0,0,0,1);
			StartSelectingStepsMessageCommand=function(self) 
			local song = GAMESTATE:GetCurrentSong()
				self:settext( SecondsToMMSS(GAMESTATE:GetCurrentSong():MusicLengthSeconds()) )
				self:diffuse( 
						(song:IsLong() and Color.Orange) or
						(song:IsMarathon() and Color.Red) or
						color("0,0.3,0,1")
					)
			end,
			InitCommand=cmd(zoom,0.8;wrapwidthpixels,500;horizalign,right;x,260;vertspacing,8;vertalign,top;y,-50);
		};

		Def.BitmapText{
			Font="Common Bold",
			InitCommand=cmd(diffuse,0,0.3,0,1);
			OnCommand=cmd(zoom,0.8;wrapwidthpixels,500;horizalign,right;x,260;vertspacing,8;vertalign,top;y,-70);
			StartSelectingStepsMessageCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local val
				if song then
					local bpms = song:GetDisplayBpms()
					if bpms[1] == bpms[2] then
						val = "BPM "..string.format("%i",bpms[1])
					else
						val = "BPM "..string.format("%i-%i",bpms[1],bpms[2])
					end
				else
					val = " "
				end
				self:settext(val)
			end;
			},

		LoadFont("Common Bold")..{
			Text="I will update",
			OnCommand=cmd(diffuse,0,0.3,0,1);
			StartSelectingStepsMessageCommand=function(self)
				self:settext( GAMESTATE:GetCurrentSong():GetDisplayArtist() )
				self:y(-50)
				if DIVA:HasSubtitles(GAMESTATE:GetCurrentSong()) then
					self:y(-30)
				end
			end,
			InitCommand=cmd(zoom,0.8;wrapwidthpixels,500;horizalign,left;x,-260;vertspacing,8;vertalign,top;y,-50);
		};

		Def.StepsDisplayList{
			Name="StepsDisplayListColored";
			OnCommand=cmd(zoom,0.8;x,0;y,60);
			StartSelectingStepsMessageCommand=cmd(decelerate,0.2;y,20;zoom,1.2);
			TwoPartConfirmCanceledMessageCommand=cmd(decelerate,0.2;y,40;zoom,1);
			PlayerJoinedMessageCommand=cmd(queuecommand,"Set");

			CursorP1=Def.ActorFrame{
				Def.Quad{
				OnCommand=cmd(zoomto,270,22;y,-1;horizalign,left;x,-140;fadeleft,0.4;faderight,0.4;diffusealpha,0);
				StartSelectingStepsMessageCommand=cmd(decelerate,0.2;diffuse,( GAMESTATE:IsPlayerEnabled(PLAYER_1) and Color.Blue) or 0,0,0,0);
				TwoPartConfirmCanceledMessageCommand=cmd(decelerate,0.2;diffusealpha,0);
				PlayerJoinedMessageCommand=function(self,param)
				self:visible(true)
				end,
				};
				LoadActor(THEME:GetPathG('SelectMusic/DifficultyList', 'cursor p1'))..{
					Name='CursorP1';
					InitCommand=cmd(x,-140;y,-1;player,PLAYER_1;zoom,1.5);
					PlayerJoinedMessageCommand=cmd(x,-140;y,-1;player,PLAYER_1;zoom,1.5);
					ChangeCommand=function(self,param)
					self:stoptweening():bounceend(0.15)
					end,
					StartSelectingStepsMessageCommand=cmd(bounce;effectoffset,0.2;effectmagnitude,-10,0,0;effectperiod,1;effectclock,"bgm");
					TwoPartConfirmCanceledMessageCommand=cmd(stopeffect);
				};
			};
			CursorP1Frame=Def.ActorFrame{
				Name='CursorP1Frame';
				ChangeCommand=cmd(stoptweening;bounceend,0.15);
			};
			CursorP2=Def.ActorFrame{
				Def.Quad{
					OnCommand=cmd(zoomto,270,22;y,-1;horizalign,right;x,140;fadeleft,0.4;faderight,0.4;diffusealpha,0);
					StartSelectingStepsMessageCommand=cmd(decelerate,0.2;diffuse,( GAMESTATE:IsPlayerEnabled(PLAYER_2) and Color.Orange) or 0,0,0,0);
					TwoPartConfirmCanceledMessageCommand=cmd(decelerate,0.2;diffusealpha,0);
				};
				LoadActor(THEME:GetPathG('SelectMusic/DifficultyList', 'cursor p2'))..{
					Name='CursorP2';
					InitCommand=cmd(x,140;y,-1;player,PLAYER_2;zoom,1.5;rotationz,180);
					PlayerJoinedMessageCommand=cmd(x,140;y,-1;player,PLAYER_2;zoom,1.5;rotationz,180);
					ChangeCommand=cmd(stoptweening;bounceend,0.15);
					StartSelectingStepsMessageCommand=cmd(bounce;effectoffset,0.2;effectmagnitude,10,0,0;effectperiod,1;effectclock,"bgm");
					TwoPartConfirmCanceledMessageCommand=cmd(stopeffect);
				};
			};
			CursorP2Frame=Def.ActorFrame {
				Name='CursorP2Frame';
				ChangeCommand=cmd(stoptweening;bounceend,0.15);
			};
		};
	};
};

-- -- Score Display
-- for player in ivalues(PlayerNumber) do
-- 	t[#t+1] = Def.ActorFrame{
-- 		OnCommand=cmd(Center;diffusealpha,0;zoom,0.6);
-- 		NextSongMessageCommand=cmd(playcommand,"Close");
-- 		PreviousSongMessageCommand=cmd(playcommand,"Close");
-- 		StartSelectingStepsMessageCommand=cmd(decelerate,0.2;zoom,0.78;diffusealpha,1);
-- 		StepsChosenMessageCommand=cmd(playcommand,"Close");
-- 		PlayerJoinedMessageCommand=cmd(playcommand,"Close");
-- 		CancelMessageCommand=cmd(playcommand,"Close");
-- 		CloseCommand=cmd(stoptweening;decelerate,0.2;zoom,0.6;diffusealpha,0);

-- 			LoadFont("Common Normal")..{
-- 				InitCommand=cmd(zoom,0.6;maxwidth,400;horizalign,(player == PLAYER_1 and left) or right;vertalign,top;x,(player == PLAYER_1 and -310) or 310;y,-240+86;shadowlengthy,1);
-- 				CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Update");
-- 				UpdateCommand=function(self)
-- 				if GAMESTATE:IsPlayerEnabled(player) then
-- 					self:settextf( THEME:GetString("ScreenSelectMusic","PlayerScore"), PROFILEMAN:GetProfile(player):GetDisplayName() )
-- 				end
-- 				end,
-- 			};
	
-- 			LoadFont("Score_handel gothic")..{
-- 				InitCommand=cmd(zoom,0.8;skewx,-0.2;horizalign,(player == PLAYER_1 and left) or right;vertalign,top;x,(player == PLAYER_1 and -310) or 310;y,-240+100;shadowlengthy,1);
-- 				CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Update");
-- 				UpdateCommand=function(self)
-- 				local TP = SCREENMAN:GetTopScreen()
-- 				self:settext( (player == PLAYER_1 and TP:GetChild("ScoreP1"):GetText()) or TP:GetChild("ScoreP2"):GetText() )
-- 				end,
-- 			};
	
-- 			LoadFont("Common Normal")..{
-- 				InitCommand=cmd(zoom,0.8;skewx,-0.2;horizalign,(player == PLAYER_1 and left) or right;vertalign,top;x,(player == PLAYER_1 and -310) or 310;y,-240+120;shadowlengthy,1);
-- 				CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Update");
-- 				UpdateCommand=function(self)
-- 				self:settext( PercentScore(player) )
-- 				end,
-- 			};
-- 	};
-- end


-- -- Button Help
-- t[#t+1] = Def.ActorFrame {
-- 		OnCommand=cmd(Center;diffusealpha,0;zoom,0);
-- 		SelectMenuOpenedMessageCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,1;zoom,0.8);
-- 		SelectMenuClosedMessageCommand=cmd(stoptweening;accelerate,0.2;diffusealpha,0;zoom,0.5);

-- 		LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=500, Height=200 } )..{
-- 		};		

-- 		LoadFont("Common Normal")..{
-- 			Text=Screen.String("ButtonHelp");
-- 			InitCommand=cmd(zoom,0.8;wrapwidthpixels,600;horizalign,left;x,-240;vertspacing,8;vertalign,top;y,-80);
-- 		};
-- 	};

-- Message for the new player that joined.
local InfoPreview = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(diffusealpha,0;x,WideScale(SCREEN_LEFT-15,SCREEN_LEFT+46);y,SCREEN_CENTER_Y-100;zoom,0.6);
		NextSongMessageCommand=cmd(playcommand,"Close");
		PreviousSongMessageCommand=cmd(playcommand,"Close");
		StartSelectingStepsMessageCommand=cmd(decelerate,0.5;y,SCREEN_CENTER_Y-100;diffusealpha,1);
		StepsChosenMessageCommand=cmd(playcommand,"Close");
		PlayerJoinedMessageCommand=cmd(playcommand,"Close");
		CancelMessageCommand=cmd(playcommand,"Close");
		CloseCommand=cmd(stoptweening;stopeffect;decelerate,0.03;y,SCREEN_CENTER_Y-100;diffusealpha,0);

			LoadActor( THEME:GetPathG("","SelectMusic/WheelHighlight"))..{
			InitCommand=cmd(x,303;zoom,0.5;pulse;effectmagnitude,1,1.02,0;effectclock,"bgm";effectperiod,1;effectoffset,0.2);
			SetMessageCommand=function(self,params)
				local steps = GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() ):GetDifficulty()
				self:diffuse( CustomDifficultyToColor( steps ) )
			end,
			};

			LoadActor( THEME:GetPathG("","SelectMusic/Base_WheelSong"))..{
			OnCommand=cmd(horizalign,left;zoom,0.5);
			};
	
			LoadActor( THEME:GetPathG("","SelectMusic/"..InvertSongBase()))..{
			InitCommand=cmd(horizalign,left;zoom,0.5);
			OnCommand=function(self)
			if JustASinglePlayer(PLAYER_2) then
				self:zoomx(-0.5):addx(4)
				self:horizalign(right)
			end
			end,
			UpdateStepsMessageCommand=function(self,params)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber());
			if steps then
				self:diffuse( CustomDifficultyToColor( steps:GetDifficulty() ) )
				DiffuseColorForBothPlayers(self)
			end
			end,
			PlayerJoinedMessageCommand=function(self)
			self:Load( THEME:GetPathG("","SelectMusic/"..InvertSongBase()) )
			end,
			};
	
			LoadActor( THEME:GetPathG("","SelectMusic/Star_WheelSong"))..{
			InitCommand=cmd(horizalign,left;zoom,0.6;y,-2;x,-15;shadowlengthy,2);
			OnCommand=function(self)
			if JustASinglePlayer(PLAYER_2) then
				self:horizalign(right)
			end
			end,
			UpdateStepsMessageCommand=function(self,params)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber());
			if steps then
				self:diffuse( CustomDifficultyToColor( steps:GetDifficulty() ) )
				DiffuseColorForBothPlayers(self)
			end
			end,
			};

			LoadFont("renner/20px") ..{
			Text="This is test";
			OnCommand=cmd(x,110;y,-14;horizalign,left;shadowlength,1;strokecolor,Color.Black);
			UpdateStepsMessageCommand=function(self,params)
			self:settext("")
			local song = GAMESTATE:GetCurrentSong();
				if song then
					self:settext( song:GetDisplayMainTitle() );
				end;
			end;
			};
	
			LoadFont("unsteady oversteer/20px") ..{
			OnCommand=cmd(x,80;y,-10;zoom,1.2;strokecolor,Color.Black);
			UpdateStepsMessageCommand=function(self,params)
			local song = GAMESTATE:GetCurrentSong();
			local steps = GAMESTATE:GetCurrentSteps(PLAYER_1);
			local enabled = GAMESTATE:GetCurrentSteps(PLAYER_1);
			if song and enabled then
				if steps then
					if song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ) then
						self:settext( song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ):GetMeter() );
					else
						self:settext( " " )
					end
				end
			else
				self:settext("")
			end
			end;
			};

			LoadFont("unsteady oversteer/20px") ..{
			OnCommand=cmd(x,528;y,-10;zoom,1.2;strokecolor,Color.Black);
			UpdateStepsMessageCommand=function(self,params)
			local song = GAMESTATE:GetCurrentSong();
			local steps = GAMESTATE:GetCurrentSteps(PLAYER_2);
			local enabled = GAMESTATE:GetCurrentSteps(PLAYER_2);
			if song and enabled then
				if steps then
					if song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ) then
						self:settext( song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ):GetMeter() );
					else
						self:settext( " " )
					end
				end
			else
				self:settext("")
			end
			end;
			};

	};

for player in ivalues(PlayerNumber) do

	local function WhichIsMissing()
		if not GAMESTATE:IsPlayerEnabled(PLAYER_1) then return PLAYER_1 end
		if not GAMESTATE:IsPlayerEnabled(PLAYER_2) then return PLAYER_2 end
	end

	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(Center;diffusealpha,0;zoom,0);
		PlayerJoinedMessageCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,1;zoom,0.8;sleep,1;accelerate,0.2;diffusealpha,0;zoom,0);

		LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=500, Height=60 } )..{
		Condition=not GAMESTATE:IsPlayerEnabled(player);
		};		

		LoadFont("Common Normal")..{
			Condition=not GAMESTATE:IsPlayerEnabled(player);
			InitCommand=cmd(zoom,0.8;wrapwidthpixels,600);
			PlayerJoinedMessageCommand=function(self)
			self:settextf( THEME:GetString("ScreenSelectMusic","PlayerJoin"), PROFILEMAN:GetProfile(player):GetDisplayName() )
			end,
		};
	};
end

t[#t+1] = Def.Quad{
	OnCommand=cmd(zoomto,SCREEN_WIDTH,25;diffuse,Color.Black;CenterX;vertalign,top);	
};

t[#t+1] = LoadActor( THEME:GetPathG("","TopBarText") )..{
	OnCommand=cmd(vertalign,top;horizalign,right;x,SCREEN_RIGHT;diffusealpha,0.6;rotationz,-2.6;y,-2;zoom,0.8);	
};

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

t[#t+1] = LoadFont("Common Normal")..{
	Text=Screen.String("HeaderText");
	InitCommand=cmd(vertalign,top;horizalign,left;xy,30,6;zoom,0.8);
};

t[#t+1] = LoadFont("Common Normal")..{
	Text=Screen.String("HeaderText");
	InitCommand=cmd(vertalign,top;horizalign,left;xy,30,6;zoom,0.8);
};


t[#t+1] = Def.Quad{
	OnCommand=cmd(zoomto,SCREEN_WIDTH,25;diffuse,Color.Black;CenterX;vertalign,bottom;y,SCREEN_BOTTOM);	
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