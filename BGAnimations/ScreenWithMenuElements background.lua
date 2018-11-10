local t = Def.ActorFrame{
	OnCommand=function(self) self:fov(90) end;
};

t[#t+1] = Def.Quad{
	OnCommand=function(self) self:FullScreen() end;
};

if ThemePrefs.Get("ShowRandomSongBackground") then
	t[#t+1] = Def.Sprite{
		InitCommand=function(self)
			self:FullScreen():diffusealpha(0)
		end;
		DivaSongChangedMessageCommand=function(self)
		if getenv("DIVA_RandomSong"):GetBackgroundPath() then
			self:finishtweening()
			:Load( getenv("DIVA_RandomSong"):GetBackgroundPath() )
			:scale_or_crop_background()
			:linear(0.2)
			:diffusealpha(0.4)
		end
		end,
		HideBackgroundMessageCommand=function(self)
			self:finishtweening():linear(0.2):diffusealpha(0)
		end;
		ShowBackgroundMessageCommand=function(self)
		if getenv("DIVA_RandomSong"):GetBackgroundPath() then
			self:finishtweening():linear(0.2):diffusealpha(0.4)
		end
		end,
	};
end

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffuse(color("#00B6EA")):fadebottom(1)
	end;
};

local function IsMikuBirthday()
	return DayOfYear() == 242
end

-- Miku's birthday
if IsMikuBirthday() then
	t[#t+1] = Def.Quad{
		OnCommand=function(self)
			self:FullScreen():diffuse(color("#00F6EA")):fadetop(1)
		end;
	};
end

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/DotTileBG") )..{
	OnCommand=function(self)
		self:x(SCREEN_RIGHT+100):align(1,0):diffusealpha(0.2):zoom(2)
		:cropleft(0.05):rotationz(5):fadeleft(1)
	end;
};

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/DotCircle") )..{
	OnCommand=function(self)
		self:xy(SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0.5):spin():effectmagnitude(0,0,10)
	end;
};

local TileXAmm = 4

local ColorsToUse = {
	color("#FFFFFF"),
	color("#DE5AC8"),
	color("#FFFF83"),
	color("#3184F1"),
	color("#A8FFD6"),
};

for i=1,5 do
t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:CenterX():y(SCREEN_CENTER_Y-40+(15*i))
	end;
	LoadActor( THEME:GetPathG("","BGElements/SmoothLine") )..{
		InitCommand=function(self)
			self:diffuse(ColorsToUse[i]):z(math.random(-30,150)):fadetop(1):wag():effectmagnitude(0,0,5):effectperiod(20):effectoffset(7*i)
		end;
		OnCommand=function(self)
			self:texcoordvelocity((0.15/i),0):customtexturerect(0,0,TileXAmm,1):zoom(0.20):zoomx(0.2*TileXAmm):diffusealpha((300/self:GetZ()))
		end;
	};
};
end

t[#t+1] = LoadActor("Borders.lua");

return t;