local t = Def.ActorFrame{
    OnCommand=function(self)
        if not FILEMAN:DoesFileExist("Save/ThemePrefs.ini") then
            Trace("ThemePrefs doesn't exist; creating file...")
            SCREENMAN:SystemMessage("ThemePrefs doesn't exist; creating file...")
            ThemePrefs.ForceSave()
        end
        MESSAGEMAN:Broadcast("HideBackground")
    ThemePrefs.Save()
end
}

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self) self:Center() end;
	BeginCommand=function(self)
		self:diffusealpha(0):sleep(.3):decelerate(0.2):diffusealpha(1)
	end;
	OnCommand=function(self)
		self:sleep(3):accelerate(0.2):diffusealpha(0)
	end;

	LoadActor( THEME:GetPathG("","ThemeLogo") )..{
		InitCommand=function(self) self:shadowlengthy(2):zoom(0.7) end;
	};	

	LoadFont("Common Normal")..{
		Text="Version ".. PDSRPInfo["Version"],
		InitCommand=function(self)
			self:shadowlengthy(2):xy(200,60):halign(1):zoom(0.8):strokecolor(Color.Black);
		end;
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("Message"),
		InitCommand=function(self)
			self:zoom(0.5):y(150):wrapwidthpixels(900):diffuse(Color.Black):strokecolor(Color.White);
		end;
	};
};

t.BeginCommand=function(self)
	SCREENMAN:GetTopScreen():PostScreenMessage( 'SM_BeginFadingOut', (THEME:GetMetric("ScreenInit","TimerSeconds")) );
end;

return t;