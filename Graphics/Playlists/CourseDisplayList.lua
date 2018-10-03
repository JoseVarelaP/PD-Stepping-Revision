local t = Def.ActorFrame{};

t[#t+1] = LoadActor("PlaylistInfoBG")..{
	OnCommand=function(self)
		self:shadowlengthy(2)
	end;
}

t[#t+1] = Def.CourseContentsList {
	MaxSongs = 8;
  NumItemsToDraw = 80;
  OnCommand=function(self)
  	self:y(-75)
  end;
	ShowCommand=function(self)
		self:linear(0.3):zoomy(1)
	end;
	HideCommand=function(self)
		self:linear(0.3):zoomy(0)
	end;
	SetCommand=function(self)
		self:SetFromGameState();
		self:PositionItems();
		self:SetTransformFromHeight(18);
		self:SetCurrentAndDestinationItem(0);
		self:SetLoop(false);
		--[[
			Masking is not that important because
			we're limiting the ammount of items on the list already...
			but still, it's neccesary. Juuuuust in case.
		]]
		self:SetMask(270,0);
	end;
	CurrentTrailP1ChangedMessageCommand=function(self)
		self:playcommand("Set")
	end;
	CurrentTrailP2ChangedMessageCommand=function(self)
		self:playcommand("Set")
	end;

	Display = Def.ActorFrame {

		LoadFont("unsteady oversteer/20px") .. {
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1);
			InitCommand=function(self)
				self:x(-165):zoom(0.8):shadowlength(0):diffuse(0,0,0,1)
			end;
			SetSongCommand=function(self, params)
				if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
				self:settext( params.Meter );
				self:finishtweening():diffusealpha(0):sleep(0.130*params.Number):decelerate(0.130):diffusealpha(0.4);
			end;
		};

		LoadFont("unsteady oversteer/20px") .. {
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2);
			InitCommand=function(self)
				self:x(145):zoom(0.8):shadowlength(0):diffuse(0,0,0,1)
			end;
			SetSongCommand=function(self, params)
				if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
				self:settext( params.Meter );
				self:finishtweening():diffusealpha(0):sleep(0.130*params.Number):decelerate(0.130):diffusealpha(0.4);
			end;
		};

		Def.TextBanner{
			InitCommand=function(self)
				self:Load("CourseTextBanner"):zoom(0.6):diffuse(Color.Black):halign(0):SetFromString("", "", "", "", "", "")
			end;
			SetSongCommand=function(self, params)
				if params.Song then
					self:SetFromSong( params.Song );
				else
					self:SetFromString( "??????????", "??????????", "", "", "", "" );
				end
				self:finishtweening():x(20):diffusealpha(0):sleep(0.130*params.Number):decelerate(0.130):x(0):diffusealpha(0.4);
			end;
		};
	};
};

return t;
