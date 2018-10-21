local t = Def.ActorFrame{
	OnCommand=function(self)
	ThemePrefs.Save()
	-- Lock input so the labels have time to finish
	SCREENMAN:GetTopScreen():lockinput(0.6)
	end,
}

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:x(SCREEN_RIGHT-70):y(SCREEN_BOTTOM-150):diffusealpha(0):sleep(0.3):decelerate(0.2):diffusealpha(1)
	end;
	OffCommand=function(self)
		self:accelerate(0.2):diffusealpha(0)
	end;

		LoadActor( THEME:GetPathG("","Title_Explanation") )..{
		OnCommand=function(self)
			self:horizalign(right):zoom(1.5)
		end;
		GainFocusCommand=function(self)
			self:stoptweening():visible(true)
		end;
		LoseFocusCommand=function(self)
			self:stoptweening():visible(false)
		end;
		};

	};

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:x(SCREEN_RIGHT-WideScale(170,240)):y(100)
	end;
	OnCommand=function(self)
	self:zoom( WideScale(0.5,0.7) )
	if not getenv("DIVA_LogoAlreadyShown") then
	self:diffusealpha(0)
	self:sleep(.3):decelerate(0.2):diffusealpha(1)
	setenv("DIVA_LogoAlreadyShown",true)
	end
	end,
	OffCommand=function(self)
		self:sleep(1):accelerate(0.2):diffusealpha(0)
	end;

	LoadActor( THEME:GetPathG("","ThemeLogo") )..{
		InitCommand=function(self)
			self:shadowlengthy(2):zoom(0.7)
		end;
	};	

	LoadFont("Common Normal")..{
		Text="Version ".. PDSRPInfo["Version"],
		InitCommand=function(self)
			self:shadowlengthy(2):x(200):horizalign(right):y(60):zoom(0.8):strokecolor(Color.Black)
		end;
	};
};

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:x(SCREEN_LEFT+20):y(20):decelerate(0.2):diffusealpha(1)
	end;
	OffCommand=function(self)
		self:accelerate(0.2):diffusealpha(0)
	end;

	LoadFont("Common Normal")..{
		Text="Options Menu",
		InitCommand=function(self)
			self:horizalign(left):zoom(1):strokecolor(Color.Black):diffusealpha(0)
		end;
		OnCommand=function(self)
			self:sleep(.3):decelerate(0.2):diffusealpha(1)
		end;
		OffCommand=function(self)
			self:accelerate(0.2):diffusealpha(0)
		end;
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("HeaderText"),
		InitCommand=function(self)
			self:horizalign(left):zoom(0.6):y(40):strokecolor(Color.Black):diffusealpha(0)
		end;
		OnCommand=function(self)
			self:sleep(.3):decelerate(0.2):diffusealpha(1)
		end;
		OffCommand=function(self)
			self:accelerate(0.2):diffusealpha(0)
		end;
	};

};

return t;