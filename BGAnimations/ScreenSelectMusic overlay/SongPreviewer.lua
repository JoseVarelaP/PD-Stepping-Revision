local t = Def.ActorFrame{};

local function JustASinglePlayer(pn)
	if pn == PLAYER_1 then return GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) end
	if pn == PLAYER_2 then return GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) end
end

local function InvertSongBase()
	WhatToLoad = "Color_WheelSong"
	if DIVA:BothPlayersEnabled() then WhatToLoad = "2PColor_WheelSong" end
	return WhatToLoad
end

local function DiffuseColorForBothPlayers(self)
	if DIVA:BothPlayersEnabled() then
		if GAMESTATE:GetCurrentSteps(PLAYER_1) then
			self:diffuseleftedge( CustomDifficultyToColor( GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() ) )
		end
		if GAMESTATE:GetCurrentSteps(PLAYER_2) then
			self:diffuserightedge( CustomDifficultyToColor( GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() ) )
		end
	end
end

t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("_switch","up")) .. {
		SelectMenuOpenedMessageCommand=function(self)
			self:stop():play()
		end;
	};

	Def.ActorFrame {
		OnCommand=function(self)
			self:CenterY():x(WideScale(SCREEN_LEFT+180,SCREEN_LEFT+230)):diffusealpha(0):zoom(0)
		end;
		StartSelectingStepsMessageCommand=function(self)
			self:stoptweening():decelerate(0.2):diffusealpha(1):zoom(0.6)
		end;
		PreviousSongMessageCommand=function(self)
			self:playcommand("Close")
		end;
		NextSongMessageCommand=function(self)
			self:playcommand("Close")
		end;
		StepsChosenMessageCommand=function(self)
			self:playcommand("Close")
		end;
		PlayerJoinedMessageCommand=function(self)
			self:playcommand("Close")
		end;
		CancelMessageCommand=function(self)
			self:playcommand("Close")
		end;
		CloseCommand=function(self)
			self:stoptweening():queuemessage("ReturnWheel"):accelerate(0.2):diffusealpha(0):zoom(0.5)
		end;

		LoadActor( THEME:GetPathG("","SelectMusic/SummarySelection") )..{
		OnCommand=function(self)
			self:y(35):zoom(1.2)
		end;
		};

		LoadFont("Common Bold")..{
			OnCommand=function(self)
				self:diffuse(0,0,0,1)
			end;
			StartSelectingStepsMessageCommand=function(self) self:settext( GAMESTATE:GetCurrentSong():GetDisplayMainTitle() ) end,
			InitCommand=function(self)
				self:maxwidth(300):zoom(1.2):wrapwidthpixels(500):horizalign(left):x(-260):vertspacing(8):vertalign(top):y(-75)
			end;
		};
		LoadFont("Common Bold")..{
			OnCommand=function(self)
				self:diffuse(0,0,0,1)
			end;
			StartSelectingStepsMessageCommand=function(self) self:settext( GAMESTATE:GetCurrentSong():GetDisplaySubTitle() ) end,
			InitCommand=function(self)
				self:maxwidth(300):zoom(0.8):wrapwidthpixels(500):horizalign(left):x(-260):vertspacing(8):vertalign(top):y(-50)
			end;
		};
		LoadFont("Common Bold")..{
			OnCommand=function(self)
				self:diffuse(0,0,0,1)
			end;
			StartSelectingStepsMessageCommand=function(self) 
			local song = GAMESTATE:GetCurrentSong()
				self:settext( SecondsToMMSS(GAMESTATE:GetCurrentSong():MusicLengthSeconds()) )
				self:diffuse( 
						(song:IsLong() and Color.Orange) or
						(song:IsMarathon() and Color.Red) or
						color("0,0,0,1")
					)
			end,
			InitCommand=function(self)
				self:zoom(0.8):wrapwidthpixels(500):horizalign(right):x(260):vertspacing(8):vertalign(top):y(-50)
			end;
		};

		Def.BitmapText{
			Font="Common Bold",
			InitCommand=function(self)
				self:diffuse(0,0,0,1)
			end;
			OnCommand=function(self)
				self:zoom(0.8):wrapwidthpixels(500):horizalign(right):x(260):vertspacing(8):vertalign(top):y(-70)
			end;
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
			OnCommand=function(self)
				self:diffuse(0,0,0,1)
			end;
			StartSelectingStepsMessageCommand=function(self)
				self:settext( GAMESTATE:GetCurrentSong():GetDisplayArtist() )
				self:y(-50)
				if DIVA:HasSubtitles(GAMESTATE:GetCurrentSong()) then
					self:y(-30)
				end
			end,
			InitCommand=function(self)
				self:zoom(0.8):wrapwidthpixels(500):horizalign(left):x(-260):vertspacing(8):vertalign(top):y(-50)
			end;
		};

		Def.StepsDisplayList{
			Name="StepsDisplayListColored";
			OnCommand=function(self)
				self:zoom(0.8):x(0):y(60)
			end;
			StartSelectingStepsMessageCommand=function(self)
				self:decelerate(0.2):y(20):zoom(1.6)
			end;
			TwoPartConfirmCanceledMessageCommand=function(self)
				self:decelerate(0.2):y(40):zoom(1.5)
			end;
			PlayerJoinedMessageCommand=function(self)
				self:queuecommand("Set")
			end;

			CursorP1=Def.ActorFrame{
				Def.Quad{
				OnCommand=function(self)
					self:zoomto(270,22):y(-1):horizalign(left):x(-140):fadeleft(0.4):faderight(0.4):diffusealpha(0)
				end;
				StartSelectingStepsMessageCommand=function(self)
					self:decelerate(0.2):diffuse(( GAMESTATE:IsPlayerEnabled(PLAYER_1) and Color.Blue) or 0,0,0,0)
				end;
				TwoPartConfirmCanceledMessageCommand=function(self)
					self:decelerate(0.2):diffusealpha(0)
				end;
				PlayerJoinedMessageCommand=function(self,param)
				self:visible(true)
				end,
				};
				LoadActor(THEME:GetPathG('SelectMusic/DifficultyList', 'cursor p1'))..{
					Name='CursorP1';
					InitCommand=function(self)
						self:x(-140):y(-1):player(PLAYER_1):zoom(1.5)
					end;
					PlayerJoinedMessageCommand=function(self)
						self:x(-140):y(-1):player(PLAYER_1):zoom(1.5)
					end;
					ChangeCommand=function(self,param)
					self:stoptweening():bounceend(0.15)
					end,
					StartSelectingStepsMessageCommand=function(self)
						self:bounce():effectoffset(0.2):effectmagnitude(-10,0,0):effectperiod(1):effectclock("bgm")
					end;
					TwoPartConfirmCanceledMessageCommand=function(self)
						self:stopeffect()
					end;
				};
			};
			CursorP1Frame=Def.ActorFrame{
				Name='CursorP1Frame';
				ChangeCommand=function(self)
					self:stoptweening():bounceend(0.15)
				end;
			};
			CursorP2=Def.ActorFrame{
				Def.Quad{
					OnCommand=function(self)
						self:zoomto(270,22):y(-1):horizalign(right):x(140):fadeleft(0.4):faderight(0.4):diffusealpha(0)
					end;
					StartSelectingStepsMessageCommand=function(self)
						self:decelerate(0.2):diffuse(( GAMESTATE:IsPlayerEnabled(PLAYER_2) and Color.Orange) or 0,0,0,0)
					end;
					TwoPartConfirmCanceledMessageCommand=function(self)
						self:decelerate(0.2):diffusealpha(0)
					end;
				};
				LoadActor(THEME:GetPathG('SelectMusic/DifficultyList', 'cursor p2'))..{
					Name='CursorP2';
					InitCommand=function(self)
						self:x(140):y(-1):player(PLAYER_2):zoom(1.5):rotationz(180)
					end;
					PlayerJoinedMessageCommand=function(self)
						self:x(140):y(-1):player(PLAYER_2):zoom(1.5):rotationz(180)
					end;
					ChangeCommand=function(self)
						self:stoptweening():bounceend(0.15)
					end;
					StartSelectingStepsMessageCommand=function(self)
						self:bounce():effectoffset(0.2):effectmagnitude(10,0,0):effectperiod(1):effectclock("bgm")
					end;
					TwoPartConfirmCanceledMessageCommand=function(self)
						self:stopeffect()
					end;
				};
			};
			CursorP2Frame=Def.ActorFrame {
				Name='CursorP2Frame';
				ChangeCommand=function(self)
					self:stoptweening():bounceend(0.15)
				end;
			};
		};
	};
};

t[#t+1] = Def.ActorFrame{
		InitCommand=function(self)
			self:diffusealpha(0):x(WideScale(SCREEN_LEFT-15,SCREEN_LEFT+46)):y(SCREEN_CENTER_Y-100):zoom(0.6)
		end;
		NextSongMessageCommand=function(self)
			self:playcommand("Close")
		end;
		PreviousSongMessageCommand=function(self)
			self:playcommand("Close")
		end;
		StartSelectingStepsMessageCommand=function(self)
			self:decelerate(0.5):y(SCREEN_CENTER_Y-100):diffusealpha(1)
		end;
		StepsChosenMessageCommand=function(self)
			self:playcommand("Close")
		end;
		PlayerJoinedMessageCommand=function(self)
			self:playcommand("Close")
		end;
		CancelMessageCommand=function(self)
			self:playcommand("Close")
		end;
		CloseCommand=function(self)
			self:stoptweening():stopeffect():decelerate(0.03):y(SCREEN_CENTER_Y-100):diffusealpha(0)
		end;

			LoadActor( THEME:GetPathG("","SelectMusic/WheelHighlight"))..{
			InitCommand=function(self)
				self:x(303):zoom(0.5):pulse():effectmagnitude(1,1.02,0):effectclock("bgm"):effectperiod(1):effectoffset(0.2)
			end;
			SetMessageCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() ):GetDifficulty()
				self:diffuse( CustomDifficultyToColor( steps ) )
			end,
			};

			LoadActor( THEME:GetPathG("","SelectMusic/Base_WheelSong"))..{
			OnCommand=function(self)
				self:horizalign(left):zoom(0.5)
			end;
			};
	
			LoadActor( THEME:GetPathG("","SelectMusic/"..InvertSongBase()))..{
			InitCommand=function(self)
				self:horizalign(left):zoom(0.5)
			end;
			OnCommand=function(self)
			if JustASinglePlayer(PLAYER_2) then
				self:zoomx(-0.5):addx(4)
				self:horizalign(right)
			end
			end,
			UpdateStepsMessageCommand=function(self)
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
			InitCommand=function(self)
				self:horizalign(left):zoom(0.6):y(-2):x(-15):shadowlengthy(2)
			end;
			OnCommand=function(self)
			if JustASinglePlayer(PLAYER_2) then
				self:horizalign(right)
			end
			end,
			UpdateStepsMessageCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber());
			if steps then
				self:diffuse( CustomDifficultyToColor( steps:GetDifficulty() ) )
				DiffuseColorForBothPlayers(self)
			end
			end,
			};

			LoadFont("renner/20px") ..{
			Text="This is test";
			OnCommand=function(self)
				self:x(110):y(-14):horizalign(left):shadowlength(1):strokecolor(Color.Black)
			end;
			UpdateStepsMessageCommand=function(self)
			self:settext("")
			local song = GAMESTATE:GetCurrentSong();
				if song then
					self:settext( song:GetDisplayMainTitle() );
				end;
			end;
			};
	
			LoadFont("unsteady oversteer/20px") ..{
			OnCommand=function(self)
				self:x(80):y(0):zoom(1.2):strokecolor(Color.Black)
			end;
			UpdateStepsMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			local steps = GAMESTATE:GetCurrentSteps(PLAYER_1);
			local enabled = GAMESTATE:IsPlayerEnabled(PLAYER_1);
			self:settext("")
			if song and enabled and steps then
				if song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ) then
					self:settext( song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ):GetMeter() );
				end
			end
			end;
			};

			LoadFont("unsteady oversteer/20px") ..{
			OnCommand=function(self)
				self:x(528):y(0):zoom(1.2):strokecolor(Color.Black)
			end;
			UpdateStepsMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			local steps = GAMESTATE:GetCurrentSteps(PLAYER_2);
			local enabled = GAMESTATE:IsPlayerEnabled(PLAYER_2);
			self:settext("")
			if song and enabled and steps then
				if song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ) then
					self:settext( song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ):GetMeter() );
				end
			end
			end;
			};

};

return t;