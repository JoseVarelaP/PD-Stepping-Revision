local t = Def.ActorFrame{};

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,Color.Black;diffusealpha,0;sleep,.5;accelerate,0.2;diffusealpha,1);
}

if ThemePrefs.Get("CurrentStageLocation") ~= "None" then
	if not WarningShown then
	
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,0;sleep,.3;decelerate,0.2;diffusealpha,1;sleep,7;accelerate,0.2;zoom,0);
	
		LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=240, Height=70 } )..{
		};
	
		LoadFont("Common Normal")..{
			Text="If you have any 3D noteskin enabled right now, you might experience a lot of culling problems. I'm trying to fix this issue as much as I can.\n\nI hope you understand.\nJose_Varela",
			InitCommand=cmd(zoom,0.5;wrapwidthpixels,500);
		};
	
	}
	
	WarningShown = true
	end
end

return t;