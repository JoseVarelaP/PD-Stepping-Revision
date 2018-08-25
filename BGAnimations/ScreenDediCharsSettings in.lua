local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,0,0,0,1;decelerate,0.5;diffusealpha,0);
}

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(Center);
	OnCommand=cmd(diffusealpha,1;decelerate,0.2;diffusealpha,0);

	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=240, Height=70 } )..{
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("Message"),
		InitCommand=cmd(zoom,0.5;wrapwidthpixels,500);
	};

}

return t;