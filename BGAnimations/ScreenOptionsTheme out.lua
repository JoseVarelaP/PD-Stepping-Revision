local t = Def.ActorFrame{
	OnCommand=function(self)
		self:sleep(3):queuecommand("SaveAndReload")
	end;
	SaveAndReloadCommand=function(self)
	ThemePrefs.Save()
	end,
}

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffuse(0,0,0,0):decelerate(0.5):diffusealpha(1)
	end;
}

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:Center()
	end;
	OnCommand=function(self)
		self:diffusealpha(0):sleep(.3):decelerate(0.2):diffusealpha(1)
	end;

	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=240, Height=70 } )..{
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("Message"),
		InitCommand=function(self)
			self:zoom(0.5):strokecolor(Color.Black):wrapwidthpixels(500)
		end;
	};

}

return t;