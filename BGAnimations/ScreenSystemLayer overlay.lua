local t = Def.ActorFrame {}
	-- Aux
t[#t+1] = LoadActor(THEME:GetPathB("ScreenSystemLayer","aux"));
	-- Credits
t[#t+1] = Def.ActorFrame { };
	-- Text
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:Center()
	end;
	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=SCREEN_WIDTH/1.5, Height=50 } )..{
	InitCommand=function(self)
		self:diffuse(1,0,0,0)
	end;
	OnCommand=function(self)
		self:finishtweening():zoom(0):zoom(1):diffusealpha(1)
	end;
	OffCommand=function(self)
		self:sleep(3):linear(0.5):diffusealpha(0)
	end;
	};

	Def.BitmapText{
		Font="Common Normal";
		Name="Text";
		InitCommand=function(self)
			self:maxwidth(850):shadowlength(1):diffusealpha(0)
		end;
		OnCommand=function(self)
			self:finishtweening():zoom(0):zoom(0.5):diffusealpha(1)
		end;
		OffCommand=function(self)
			self:sleep(3):linear(0.5):diffusealpha(0)
		end;
	};
	SystemMessageMessageCommand = function(self, params)
		self:GetChild("Text"):settext( params.Message );
		self:playcommand( "On" );
		if params.NoAnimate then
			self:finishtweening();
		end
		self:playcommand( "Off" );
	end;
	HideSystemMessageMessageCommand = function(self)
		self:finishtweening()
	end;
};

return t;
