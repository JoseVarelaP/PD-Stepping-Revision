local t = Def.ActorFrame {}
	-- Aux
t[#t+1] = LoadActor(THEME:GetPathB("ScreenSystemLayer","aux"));
	-- Credits
t[#t+1] = Def.ActorFrame { };
	-- Text
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center);
	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=SCREEN_WIDTH/1.5, Height=50 } )..{
	InitCommand=cmd(diffuse,1,0,0,0);
	OnCommand=cmd(finishtweening;zoom,0;zoom,1;diffusealpha,1);
	OffCommand=cmd(sleep,3;linear,0.5;diffusealpha,0;);
	};

	Def.BitmapText{
		Font="Common Normal";
		Name="Text";
		InitCommand=cmd(maxwidth,850;shadowlength,1;diffusealpha,0;);
		OnCommand=cmd(finishtweening;zoom,0;zoom,0.5;diffusealpha,1);
		OffCommand=cmd(sleep,3;linear,0.5;diffusealpha,0;);
	};
	SystemMessageMessageCommand = function(self, params)
		self:GetChild("Text"):settext( params.Message );
		self:playcommand( "On" );
		if params.NoAnimate then
			self:finishtweening();
		end
		self:playcommand( "Off" );
	end;
	HideSystemMessageMessageCommand = cmd(finishtweening);
};

return t;
