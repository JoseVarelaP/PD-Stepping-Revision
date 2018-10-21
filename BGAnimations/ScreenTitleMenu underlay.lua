local t = Def.ActorFrame{
	OnCommand=function(self)
	setenv("DIVA_LogoAlreadyShown",false)
	self:queuecommand("UpdateSongStuff")
	end,
	UpdateSongStuffCommand=function(self)
	if ThemePrefs.Get("EnableRandomSongPlay") then
		GAMESTATE:SetPreferredSong( getenv("DIVA_RandomSong") )
		MESSAGEMAN:Broadcast("ShowBackground")
	end
	end;
};

if #SONGMAN:GetAllSongs() > 0 and ThemePrefs.Get("EnableRandomSongPlay") then

	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self)
		self:diffusealpha(0)
		end,
		OnCommand=function(self)
		self:zoom(0.8):xy(SCREEN_LEFT+70,SCREEN_BOTTOM-35):sleep(.3):decelerate(0.2):diffusealpha(1)
		end,
		OffCommand=function(self)
		self:accelerate(0.2):diffusealpha(0)
		end,

		LoadActor( THEME:GetPathG("","TitleMenu/MusicNote"))..{
		OnCommand=function(self)
		self:zoom(0.15):xy(-15,-3)
		end,
		};

		LoadFont("Common Normal")..{
		InitCommand=function(self)
		self:halign(0):diffuse(0,0,0,1):zoom(0.6):shadowlengthy(1)
		end;
		OnCommand=function(self)
		self:strokecolor( Color.White ):y(-2)
		:queuecommand("UpdateInfo")
		end,
		UpdateInfoCommand=function(self)
		if getenv("DIVA_RandomSong") then
			local so = getenv("DIVA_RandomSong")
			self:settext( so:GetDisplayFullTitle() .." - ".. so:GetDisplayArtist() )
		end
		end;
		};
	};
end

return t;