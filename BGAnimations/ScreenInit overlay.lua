local t = Def.ActorFrame{
    OnCommand=function(self)
        if not FILEMAN:DoesFileExist("Save/ThemePrefs.ini") then
            Trace("ThemePrefs doesn't exist; creating file...")
            SCREENMAN:SystemMessage("ThemePrefs doesn't exist; creating file...")
            ThemePrefs.ForceSave()
        end
    ThemePrefs.Save()
    Diva_ResetRandomSong()
end
}

t[#t+1] = LoadActor( THEME:GetPathG("","Light_BottomMenuBar") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;horizalign,right;zoom,2;SetTextureFiltering,false;y,SCREEN_BOTTOM;vertalign,bottom);
};

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,Color.Black;linear,2;diffusealpha,0.6;sleep,2.5;accelerate,0.2;diffusealpha,0);
}

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_RIGHT-80;y,SCREEN_BOTTOM-100);
	OnCommand=cmd(sleep,4.2;accelerate,0.5;diffusealpha,0);

	LoadFont("Common Normal")..{
		Text="Stepping Revision Project\nVersion ".. PDSRPInfo["Version"],
		InitCommand=cmd(horizalign,right;y,-40;zoom,0.5;diffusealpha,0;shadowlengthy,2);
		OnCommand=cmd(sleep,1;decelerate,0.2;diffusealpha,1);
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};

	LoadActor( THEME:GetPathG("","White_ThemeLogo") )..{
		InitCommand=cmd(horizalign,right;zoom,0.4;diffusealpha,0;addx,300;shadowlengthy,2);
		OnCommand=cmd(sleep,.3;decelerate,0.8;diffusealpha,1;addx,-300);
		OffCommand=cmd(accelerate,0.2;glow,0,0,0,0;diffusealpha,0);
	};

};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(Center);
	OnCommand=cmd(diffusealpha,0;sleep,.3;decelerate,0.2;diffusealpha,1;sleep,4;accelerate,0.2;zoom,0);

	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=240, Height=70 } )..{
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("Message"),
		InitCommand=cmd(zoom,0.5;wrapwidthpixels,500);
	};

}

return t;