local t = Def.ActorFrame{
    OnCommand=function(self)
        if not FILEMAN:DoesFileExist("Save/ThemePrefs.ini") then
            Trace("ThemePrefs doesn't exist; creating file...")
            SCREENMAN:SystemMessage("ThemePrefs doesn't exist; creating file...")
            ThemePrefs.ForceSave()
        end
    ThemePrefs.Save()
    DIVA:ResetRandomSong()
end
}

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(Center);
	BeginCommand=cmd(diffusealpha,0;sleep,.3;decelerate,0.2;diffusealpha,1);
	OnCommand=cmd(sleep,3;accelerate,0.2;diffusealpha,0);

	LoadActor( THEME:GetPathG("","ThemeLogo") )..{
		InitCommand=cmd(shadowlengthy,2;zoom,0.7);
	};	

	LoadFont("Common Normal")..{
		Text="Version ".. PDSRPInfo["Version"],
		InitCommand=cmd(shadowlengthy,2;x,200;horizalign,right;y,60;zoom,0.8;strokecolor,Color.Black);
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("Message"),
		InitCommand=cmd(zoom,0.5;y,150;wrapwidthpixels,900;diffuse,Color.Black;strokecolor,Color.White);
	};
};

return t;