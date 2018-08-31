local t = Def.ActorFrame{
	OnCommand=cmd(fov,90);
}

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;);	
};

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,color("#00B6EA");fadebottom,1);
};

local function IsMikuBirthday()
	return DayOfYear() == 242
end

-- Miku's birthday
if IsMikuBirthday() then
	for i=1,5 do
	t[#t+1] = Def.Quad{
		OnCommand=cmd(FullScreen;diffuse,color("#00F6EA");fadebottom,1);
	};
	end
end

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/DotTileBG") )..{
	OnCommand=cmd(x,SCREEN_RIGHT+100;horizalign,right;vertalign,top;diffusealpha,0.2;zoom,2;cropleft,0.05;rotationz,5;fadeleft,1);
};

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/DotCircle") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_BOTTOM;diffusealpha,0.5;spin;effectmagnitude,0,0,10);
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
	OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y-40+(15*i));
	LoadActor( THEME:GetPathG("","BGElements/SmoothLine") )..{
		InitCommand=cmd(diffuse,ColorsToUse[i];z,math.random(-30,150);fadetop,1;wag;effectmagnitude,0,0,5;effectperiod,20;effectoffset,7*i);
		OnCommand=cmd(texcoordvelocity,(0.15/i),0;customtexturerect,0,0,TileXAmm,1;zoom,0.20;zoomx,0.2*TileXAmm;diffusealpha,(300/self:GetZ()));
	};
};
end

if ThemePrefs.Get("ShowRandomSongBackground") then
	t[#t+1] = LoadActor( DIVA_RandomSong:GetBackgroundPath() )..{
		InitCommand=cmd(FullScreen;diffusealpha,0);
		DivaSongChangedMessageCommand=function(self)
		if DIVA_RandomSong:GetBackgroundPath() then
			self:Load( DIVA_RandomSong:GetBackgroundPath() )
			self:scale_or_crop_background()
			self:diffusealpha(0)
		end
		end,
		HideBackgroundMessageCommand=cmd(linear,0.2;diffusealpha,0);
		ShowBackgroundMessageCommand=function(self)
		self:linear(0.2)
		self:diffusealpha(0.4)
		end,
	};
end

t[#t+1] = LoadActor("Borders.lua");

return t;