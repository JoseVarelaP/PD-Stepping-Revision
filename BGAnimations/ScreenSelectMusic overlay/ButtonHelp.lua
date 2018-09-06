local t = Def.ActorFrame{};

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,0,0,0,0);
	SelectMenuOpenedMessageCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,0.5);
	SelectMenuClosedMessageCommand=cmd(stoptweening;accelerate,0.2;diffusealpha,0);
}

t[#t+1] = Def.ActorFrame {
		OnCommand=cmd(Center;diffusealpha,0;zoom,0);
		SelectMenuOpenedMessageCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,1;zoom,0.8);
		SelectMenuClosedMessageCommand=cmd(stoptweening;accelerate,0.2;diffusealpha,0;zoom,0.5);


		LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=400, Height=200 } )..{
		};

		LoadFont("Common Normal")..{
			Text=Screen.String("ButtonHelp");
			InitCommand=cmd(zoom,0.8;wrapwidthpixels,600;strokecolor,Color.Black;horizalign,left;x,-240;vertspacing,8;vertalign,top;y,-80);
			OnCommand=function(self)
			if THEME:GetCurLanguage() == "es" then
				self:zoom(0.7):wrapwidthpixels(650)
			end
			end,
		};
};

return t;