local t = Def.ActorFrame{
	InitCommand=function(self)
	ThemePrefs.Save()
	DIVA:ResetRandomSong()
	end,
	OnCommand=function(self)
		self:sleep(0.5):queuecommand("SaveAndReload")
	end;
	SaveAndReloadCommand=function(self)
	SCREENMAN:SetNewScreen("ScreenTitleMenu")
	end,
}

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffuse(0,0,0,1)
	end;
}

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:Center()
	end;

	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=140, Height=40 } )..{
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("Message"),
		InitCommand=function(self)
			self:zoom(0.5):strokecolor(Color.Black):wrapwidthpixels(500)
		end;
	};

}

return t;