local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffuse(0,0,0,1):decelerate(0.5):diffusealpha(0)
	end;
}

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:Center()
	end;
	OnCommand=function(self)
		self:diffusealpha(1):decelerate(0.2):diffusealpha(0)
	end;

	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=240, Height=70 } )..{
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("Message"),
		InitCommand=function(self)
			self:zoom(0.5):wrapwidthpixels(500)
		end;
	};

}

return t;