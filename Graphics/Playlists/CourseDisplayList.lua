local t = Def.ActorFrame{};

t[#t+1] = LoadActor("PlaylistInfoBG")..{
	OnCommand=cmd(shadowlengthy,2);
}

t[#t+1] = Def.CourseContentsList {
	MaxSongs = 8;
    NumItemsToDraw = 8;
    OnCommand=cmd(y,-75);
	ShowCommand=cmd(linear,0.3;zoomy,1);
	HideCommand=cmd(linear,0.3;zoomy,0);
	SetCommand=function(self)
		self:SetFromGameState();
		self:PositionItems();
		self:SetTransformFromHeight(18);
		self:SetCurrentAndDestinationItem(0);
		self:SetLoop(false);
		self:SetMask(270,0);
	end;
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");

	Display = Def.ActorFrame { 

		LoadFont("DifficultyListRow number") .. {
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1);
			InitCommand=cmd(x,-165;zoom,0.8;shadowlength,0;diffuse,0,0,0,1);
			SetSongCommand=function(self, params)
				if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
				self:settext( params.Meter );
				(cmd(finishtweening;diffusealpha,0;sleep,0.125*params.Number;linear,0.125;diffusealpha,0.4))(self);
			end;
		};

		LoadFont("DifficultyListRow number") .. {
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2);
			InitCommand=cmd(x,145;zoom,0.8;shadowlength,0;diffuse,0,0,0,1);
			SetSongCommand=function(self, params)
				if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
				self:settext( params.Meter );
				(cmd(finishtweening;diffusealpha,0;sleep,0.125*params.Number;linear,0.125;diffusealpha,0.4))(self);
			end;
		};

		Def.TextBanner{
			InitCommand=cmd(Load,"CourseTextBanner";zoom,0.6;diffuse,Color.Black;halign,0;SetFromString,"", "", "", "", "", "");
			SetSongCommand=function(self, params)
				if params.Song then
					self:SetFromSong( params.Song );
				else
					self:SetFromString( "??????????", "??????????", "", "", "", "" );
				end
				(cmd(finishtweening;x,20;diffusealpha,0;sleep,0.125*params.Number;linear,0.125;x,0;diffusealpha,0.4))(self);
			end;
		};
	};
};

return t;