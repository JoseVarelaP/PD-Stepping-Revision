local function JustASinglePlayer(pn)
	if pn == PLAYER_1 then return GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) end
	if pn == PLAYER_2 then return GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) end
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

local function InvertSongBase()
	WhatToLoad = "Color_WheelSong"
	if DIVA:BothPlayersEnabled() then WhatToLoad = "2PColor_WheelSong" end
	return WhatToLoad
end

local t = Def.ActorFrame {};

	t[#t+1] = Def.ActorFrame{

		Def.ActorFrame{
		
			LoadActor("SelectMusic/WheelHighlight")..{
			InitCommand=cmd(horizalign,left;zoom,0.5;shadowlength,3);
			SetMessageCommand=function(self,params)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber());
			if steps then
				self:diffuse( CustomDifficultyToColor( steps:GetDifficulty() ) )
				DiffuseColorForBothPlayers(self)
			end
			end,
			};
	
			LoadActor("SelectMusic/Base_WheelSong")..{
			OnCommand=cmd(horizalign,left;zoom,0.5);
			};
	
			LoadActor("SelectMusic/"..InvertSongBase())..{
			InitCommand=cmd(horizalign,left;zoom,0.5);
			OnCommand=function(self)
			if JustASinglePlayer(PLAYER_2) then
				self:zoomx(-0.5):addx(4)
				self:horizalign(right)
			end
			end,
			SetMessageCommand=function(self,params)
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
	
			LoadActor("SelectMusic/Star_WheelSong")..{
			InitCommand=cmd(horizalign,left;zoom,0.6;y,-2;x,-15;shadowlengthy,2);
			OnCommand=function(self)
			if JustASinglePlayer(PLAYER_2) then
				self:horizalign(right)
			end
			end,
			SetMessageCommand=function(self,params)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber());
			if steps then
				self:diffuse( CustomDifficultyToColor( steps:GetDifficulty() ) )
				DiffuseColorForBothPlayers(self)
			end
			end,
			};
	
			LoadFont("renner/20px") ..{
			OnCommand=cmd(x,110;y,-14;horizalign,left;shadowlength,1;strokecolor,Color.Black;maxwidth,430);
			SetMessageCommand=function(self,params)
			self:settext("")
			local song = params.Song;
				if song then
					self:settext( song:GetDisplayMainTitle() );
				end;
			end;
			};
	
			LoadFont("proto sans/20px") ..{
			OnCommand=cmd(x,500;y,-30;zoom,0.8;horizalign,right;shadowlength,1;strokecolor,Color.Blue);
			SetMessageCommand=function(self,params)
			self:settext("No Genre")
			local song = params.Song;
				if song and string.len(song:GetGenre()) > 1 then
					self:settext( song:GetGenre() );
				end
			end;
			};

			LoadFont("renner/20px") ..{
			OnCommand=cmd(x,530;y,-30;zoom,0.8;shadowlength,1;strokecolor,Color.Blue);
			SetMessageCommand=function(self,params)
			local song = params.Song;
				if song and PROFILEMAN:IsSongNew(song) then
					self:settext("NEW!")
					self:diffuse(Color.Red)
					self:strokecolor( Color.Orange )
				else
					self:settext("")
				end;
			end;
			};

			Def.ActorFrame{
			SetMessageCommand=function(self,params)
			local song = params.Song;
			self:visible(false)
			if song and song:IsLong() or song and song:IsMarathon() then
				self:visible(true)
			end
			end;

				LoadActor("SelectMusic/WheelNotify/SongDuration")..{
				OnCommand=cmd(horizalign,left;zoom,1;y,16;x,150;shadowlengthy,2);
				SetMessageCommand=function(self,params)
				local song = params.Song;
				if song and song:IsLong() then
					self:diffuse(Color.Orange)
				end
				if song and song:IsMarathon() then
					self:diffuse(Color.Red)
				end
				end,
				};
	
				LoadFont("unsteady oversteer/20px") ..{
				OnCommand=cmd(x,170;y,6;zoom,1.2;strokecolor,Color.Black);
				SetMessageCommand=function(self,params)
				local song = params.Song;
				if song and song:IsLong() then
					self:strokecolor( ColorDarkTone(Color.Orange) )
					self:settext( "2" )
				end
				if song and song:IsMarathon() then
					self:strokecolor( ColorDarkTone(Color.Red) )
					self:settext( "3" )
				end
				end,
				};

				LoadFont("renner/20px") ..{
				Text="Stages";
				OnCommand=cmd(x,210;y,18;zoom,0.8;strokecolor,Color.Black);
				SetMessageCommand=function(self,params)
				local song = params.Song;
				if song and song:IsLong() then self:strokecolor( ColorDarkTone(Color.Orange) )end
				if song and song:IsMarathon() then self:strokecolor( ColorDarkTone(Color.Red) )end
				end,
				};

			};

			Def.ActorFrame{
			SetMessageCommand=function(self,params)
			local song = params.Song;
			self:visible(false)
			if song then
				local bpms = song:GetDisplayBpms()
				if bpms[1] ~= bpms[2] then
					self:visible(true)
				end
			end
			end;

				LoadActor("SelectMusic/WheelNotify/BPMChanges")..{
				OnCommand=cmd(horizalign,left;zoom,1;y,16;x,105;shadowlengthy,2);
				SetMessageCommand=function(self,params)
				local song = params.Song;
				if song and song:IsLong() then self:diffuse(Color.Orange) end
				if song and song:IsMarathon() then self:diffuse(Color.Red) end
				end,
				};

				Def.BitmapText{
				Font="unsteady oversteer/20px",
				OnCommand=cmd(zoom,0.6;strokecolor,color("0,0,0,1");wrapwidthpixels,500;x,128;vertspacing,-8;y,12);
				SetMessageCommand=function(self,params)
				local song = params.Song;
				val = " "
					if song then
						local bpms = song:GetDisplayBpms()
						val = string.format("%i \n %i",bpms[1],bpms[2])
					end
					self:settext(val)
				end;
				},

			};

		};

	};

for player in ivalues(PlayerNumber) do
t[#t+1] = LoadFont("unsteady oversteer/20px") ..{
	OnCommand=cmd(x,((player == PLAYER_1 and 80) or 528);y,-10;zoom,1.2;strokecolor,Color.Black);
	SetMessageCommand=function(self,params)
	local song = params.Song;
	local enabled = GAMESTATE:IsPlayerEnabled(player);
	local steps = GAMESTATE:GetCurrentSteps(player);
	self:settext("")
		if enabled and song and steps then
			if song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ) then
				self:settext( song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ):GetMeter() );
			end
		end
	end;
};
end

t.NextSongMessageCommand=cmd(playcommand,"Close");
t.PreviousSongMessageCommand=cmd(playcommand,"Close");
t.StartSelectingStepsMessageCommand=cmd(queuemessage,"FadeWheel");
t.StepsChosenMessageCommand=cmd(playcommand,"Close");
t.PlayerJoinedMessageCommand=cmd(playcommand,"Close");
t.CancelMessageCommand=cmd(playcommand,"Close");
t.CloseCommand=cmd(queuemessage,"ReturnWheel");
t.SetMessageCommand=function(self,params)
local song = params.Song;
local steps = GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() );
local bothenabled = GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2)
local stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1);
local stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2);
self:stoptweening()
self:zoom(1)
self:diffuse(1,1,1,1)
	if song then
		if bothenabled then
			if stepsP1 and stepsP2 then
				if not song:GetOneSteps(stepsP1:GetStepsType(), stepsP1:GetDifficulty() ) and not song:GetOneSteps(stepsP2:GetStepsType(), stepsP2:GetDifficulty() ) then
					self:stoptweening()
					self:zoom(0.9)
					self:diffuse(0.6,0.6,0.6,1)
				end
			end
		else
			if steps then
				if not song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ) then
					self:stoptweening()
					self:zoom(0.9)
					self:diffuse(0.6,0.6,0.6,1)
				end
			end
		end
	end
end;
	
return t;