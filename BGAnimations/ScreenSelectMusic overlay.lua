-- hi im jose and welcome to jackass

local t = Def.ActorFrame{}

local function HasSubtitles()
	return string.len( GAMESTATE:GetCurrentSong():GetDisplaySubTitle() ) > 1
end

local function PercentScore(pn)
	local SongOrCourse, StepsOrTrail;
		if GAMESTATE:IsCourseMode() then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
		else
			SongOrCourse = GAMESTATE:GetCurrentSong();
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
		end;
		local profile, scorelist;
		local text = "";
		if SongOrCourse and StepsOrTrail then
			local st = StepsOrTrail:GetStepsType();
			local diff = StepsOrTrail:GetDifficulty();
			local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
			local cd = GetCustomDifficulty(st, diff, courseType);
			if PROFILEMAN:IsPersistentProfile(pn) then
				-- player profile
				profile = PROFILEMAN:GetProfile(pn);
			else
				-- machine profile
				profile = PROFILEMAN:GetMachineProfile();
			end;
			scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
			assert(scorelist)
			local scores = scorelist:GetHighScores();
			local topscore = scores[1];
			if topscore then
				text = string.format("%.2f%%", topscore:GetPercentDP()*100.0);
				-- 100% hack
				if text == "100.00%" then
					text = "100%";
				end;
			else
				text = string.format("%.2f%%", 0);
			end;
		else
			text = "";
		end;

	return text;
end

------ ------ ------ ------ ------ ------ ------
------ ------ ------ ------ ------ ------ ------
------ End functionland begin actual mess ------
------ ------ ------ ------ ------ ------ ------
------ ------ ------ ------ ------ ------ ------

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,Color.Black;diffusealpha,0);
	StartSelectingStepsMessageCommand=cmd(decelerate,0.2;diffusealpha,0.8);
	PreviousSongMessageCommand=cmd(playcommand,"Close");
	NextSongMessageCommand=cmd(playcommand,"Close");
	StepsChosenMessageCommand=cmd(playcommand,"Close");
	PlayerJoinedMessageCommand=cmd(playcommand,"Close");
	CancelMessageCommand=cmd(playcommand,"Close");
	CloseCommand=cmd(stoptweening;accelerate,0.2;diffusealpha,0);
};

t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("_switch","up")) .. {
		SelectMenuOpenedMessageCommand=cmd(stop;play);
	};

	Def.ActorFrame {
		OnCommand=cmd(Center;diffusealpha,0;zoom,0);
		StartSelectingStepsMessageCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,1;zoom,0.8);
		PreviousSongMessageCommand=cmd(playcommand,"Close");
		NextSongMessageCommand=cmd(playcommand,"Close");
		StepsChosenMessageCommand=cmd(playcommand,"Close");
		PlayerJoinedMessageCommand=cmd(playcommand,"Close");
		CancelMessageCommand=cmd(playcommand,"Close");
		CloseCommand=cmd(stoptweening;accelerate,0.2;diffusealpha,0;zoom,0.5);

		LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=640, Height=480 } )..{
		};

		Def.Sprite {
			InitCommand=cmd(diffusealpha,1);
			BeginCommand=cmd(LoadFromCurrentSongBackground);
			StartSelectingStepsMessageCommand=function(self)
			self:LoadFromCurrentSongBackground()
			end,
			OnCommand=function(self)
				self:diffusealpha(0):scaletoclipped(648,480):linear(0.5):diffusealpha(0.5)
			end;
		};
		
		LoadFont("Common Bold")..{
			Text="I will update",
			StartSelectingStepsMessageCommand=function(self) self:settext( GAMESTATE:GetCurrentSong():GetDisplayMainTitle() ) end,
			InitCommand=cmd(maxwidth,300;shadowlengthy,3;zoom,1.2;wrapwidthpixels,500;horizalign,left;x,-260;vertspacing,8;vertalign,top;y,-75);
		};
		LoadFont("Common Bold")..{
			Text="I will update",
			StartSelectingStepsMessageCommand=function(self) self:settext( GAMESTATE:GetCurrentSong():GetDisplaySubTitle() ) end,
			InitCommand=cmd(maxwidth,300;shadowlengthy,3;zoom,0.8;wrapwidthpixels,500;horizalign,left;x,-260;vertspacing,8;vertalign,top;y,-50);
		};
		LoadFont("Common Bold")..{
			Text="I will update",
			StartSelectingStepsMessageCommand=function(self) 
			local song = GAMESTATE:GetCurrentSong()
				self:settext( SecondsToMMSS(GAMESTATE:GetCurrentSong():MusicLengthSeconds()) )
				self:diffuse( 
						(song:IsLong() and Color.Orange) or
						(song:IsMarathon() and Color.Red) or
						Color.White
					)
			end,
			InitCommand=cmd(shadowlengthy,3;zoom,0.8;wrapwidthpixels,500;horizalign,right;x,260;vertspacing,8;vertalign,top;y,-50);
		};

		Def.BitmapText{
			Font="Common Bold",
			OnCommand=cmd(shadowlengthy,3;zoom,0.8;wrapwidthpixels,500;horizalign,right;x,260;vertspacing,8;vertalign,top;y,-70);
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
			StartSelectingStepsMessageCommand=function(self)
				self:settext( GAMESTATE:GetCurrentSong():GetDisplayArtist() )
				self:y(-50)
				if HasSubtitles() then
					self:y(-30)
				end
			end,
			InitCommand=cmd(shadowlengthy,3;zoom,0.8;wrapwidthpixels,500;horizalign,left;x,-260;vertspacing,8;vertalign,top;y,-50);
		};

		Def.ActorFrame{
			OnCommand=cmd(zoom,1.5;y,-200;x,-300);
			StartSelectingStepsMessageCommand=function(self)
			self:visible(false)
			if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():HasBGChanges() then
				self:visible(true)
			end
			end,
			LoadActor( THEME:GetPathG("","SelectMusic/ICON_ContainsBGChanges") )..{
				OnCommand=cmd(horizalign,right);
			};
			LoadFont("Common Normal")..{
				Text=Screen.String("ContBGAnims");
				InitCommand=cmd(horizalign,left;x,10;zoom,0.5;shadowlengthy,2);
			};
		};

		Def.ActorFrame{
			OnCommand=cmd(zoom,1.5;y,-220;x,-300);
			StartSelectingStepsMessageCommand=function(self)
			self:visible(false)
			if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():HasAttacks() then
				self:visible(true)
			end
			end,
			LoadActor( THEME:GetPathG("","SelectMusic/ICON_ContainsAttacks") )..{
				OnCommand=cmd(horizalign,right);
			};
			LoadFont("Common Normal")..{
				Text=Screen.String("ContAttacks");
				InitCommand=cmd(horizalign,left;x,10;zoom,0.5;shadowlengthy,2);
			};
		};

		Def.ActorFrame{
			OnCommand=cmd(zoom,1.5;y,-180;x,-300);
			StartSelectingStepsMessageCommand=function(self)
			self:visible(false)
			if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():HasAttacks() then
				self:visible(true)
			end
			end,
			LoadActor( THEME:GetPathG("","SelectMusic/ICON_ContainsLyrics") )..{
				OnCommand=cmd(horizalign,right);
			};
			LoadFont("Common Normal")..{
				Text=Screen.String("ContLyrics");
				InitCommand=cmd(horizalign,left;x,10;zoom,0.5;shadowlengthy,2);
			};
		};

		Def.StepsDisplayList{
			Name="StepsDisplayListColored";
			OnCommand=cmd(zoom,0.8;x,0;y,100);
			StartSelectingStepsMessageCommand=cmd(decelerate,0.2;y,50;zoom,1.2);
			TwoPartConfirmCanceledMessageCommand=cmd(decelerate,0.2;y,80;zoom,1);
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

		LoadFont("Common Normal")..{
			Text=Screen.String("Inst_DiffSel");
			InitCommand=cmd(zoom,0.6;vertalign,bottom;y,220;vertspacing,8;shadowlengthy,1);
			TwoPartConfirmCanceledMessageCommand=function(self)
			self:zoom(0.65):diffuse(0,1,1,1):decelerate(0.2):zoom(0.6):diffuse(Color.White)
			self:settext( THEME:GetString("ScreenSelectMusic","Inst_DiffSel") )
			end,
			StartSelectingStepsMessageCommand=function(self)
			self:zoom(0.65):diffuse(0,1,1,1):decelerate(0.2):zoom(0.6):diffuse(Color.White)
			self:settext( THEME:GetString("ScreenSelectMusic","Inst_Decided") )
			end,
		};

		LoadFont("Common Normal")..{
			Text=Screen.String("Tip_ButtonHelp");
			InitCommand=cmd(zoom,0.6;y,270;diffusealpha,0);
			StartSelectingStepsMessageCommand=cmd(stoptweening;accelerate,0.2;zoom,0.5;diffusealpha,0);
			TwoPartConfirmCanceledMessageCommand=function(self)
			self:zoom(0.65):diffuse(0,1,1,1):decelerate(0.2):zoom(0.6):diffuse(Color.White)
			end,
		};
	};
};

-- Score Display
for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.ActorFrame{
		OnCommand=cmd(Center;diffusealpha,0;zoom,0.6);
		NextSongMessageCommand=cmd(playcommand,"Close");
		PreviousSongMessageCommand=cmd(playcommand,"Close");
		StartSelectingStepsMessageCommand=cmd(decelerate,0.2;zoom,0.78;diffusealpha,1);
		StepsChosenMessageCommand=cmd(playcommand,"Close");
		PlayerJoinedMessageCommand=cmd(playcommand,"Close");
		CancelMessageCommand=cmd(playcommand,"Close");
		CloseCommand=cmd(stoptweening;decelerate,0.2;zoom,0.6;diffusealpha,0);

			LoadFont("Common Normal")..{
				InitCommand=cmd(zoom,0.6;maxwidth,400;horizalign,(player == PLAYER_1 and left) or right;vertalign,top;x,(player == PLAYER_1 and -310) or 310;y,-240+86;shadowlengthy,1);
				CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Update");
				UpdateCommand=function(self)
				if GAMESTATE:IsPlayerEnabled(player) then
					self:settextf( THEME:GetString("ScreenSelectMusic","PlayerScore"), PROFILEMAN:GetProfile(player):GetDisplayName() )
				end
				end,
			};
	
			LoadFont("Score_handel gothic")..{
				InitCommand=cmd(zoom,0.8;skewx,-0.2;horizalign,(player == PLAYER_1 and left) or right;vertalign,top;x,(player == PLAYER_1 and -310) or 310;y,-240+100;shadowlengthy,1);
				CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Update");
				UpdateCommand=function(self)
				local TP = SCREENMAN:GetTopScreen()
				self:settext( (player == PLAYER_1 and TP:GetChild("ScoreP1"):GetText()) or TP:GetChild("ScoreP2"):GetText() )
				end,
			};
	
			LoadFont("Common Normal")..{
				InitCommand=cmd(zoom,0.8;skewx,-0.2;horizalign,(player == PLAYER_1 and left) or right;vertalign,top;x,(player == PLAYER_1 and -310) or 310;y,-240+120;shadowlengthy,1);
				CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Update");
				UpdateCommand=function(self)
				self:settext( PercentScore(player) )
				end,
			};
	};
end

-- Button Help
t[#t+1] = Def.ActorFrame {
		OnCommand=cmd(Center;diffusealpha,0;zoom,0);
		SelectMenuOpenedMessageCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,1;zoom,0.8);
		SelectMenuClosedMessageCommand=cmd(stoptweening;accelerate,0.2;diffusealpha,0;zoom,0.5);

		LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=500, Height=200 } )..{
		};		

		LoadFont("Common Normal")..{
			Text=Screen.String("ButtonHelp");
			InitCommand=cmd(zoom,0.8;wrapwidthpixels,600;horizalign,left;x,-240;vertspacing,8;vertalign,top;y,-80);
		};
	};

-- Message for the new player that joined.


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
			InitCommand=cmd(zoom,0.8;wrapwidthpixels,600;);
			PlayerJoinedMessageCommand=function(self)
			self:settextf( THEME:GetString("ScreenSelectMusic","PlayerJoin"), PROFILEMAN:GetProfile(player):GetDisplayName() )
			end,
		};
	};
end

return t;