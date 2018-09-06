local t = Def.ActorFrame{
	OnCommand=cmd(sleep,3;queuecommand,"SaveAndReload");
	SaveAndReloadCommand=function(self)
	ThemePrefs.Save()
	end,
}

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,0,0,0,0;decelerate,0.5;diffusealpha,1);
}

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(Center);
	OnCommand=cmd(diffusealpha,0;sleep,.3;decelerate,0.2;diffusealpha,1);

	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=240, Height=70 } )..{
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("Message"),
		InitCommand=cmd(zoom,0.5;strokecolor,Color.Black;wrapwidthpixels,500);
	};

}

return t;