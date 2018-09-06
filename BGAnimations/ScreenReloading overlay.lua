local t = Def.ActorFrame{
	InitCommand=function(self)
	ThemePrefs.Save()
	DIVA:ResetRandomSong()
	end,
	OnCommand=cmd(sleep,0.5;queuecommand,"SaveAndReload");
	SaveAndReloadCommand=function(self)
	SCREENMAN:SetNewScreen("ScreenTitleMenu")
	end,
}

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,0,0,0,1);
}

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(Center);

	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=140, Height=40 } )..{
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("Message"),
		InitCommand=cmd(zoom,0.5;strokecolor,Color.Black;wrapwidthpixels,500);
	};

}

return t;