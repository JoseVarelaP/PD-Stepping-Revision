local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffuse(0,0,0,0):decelerate(0.4):diffusealpha(0.8)
	end;
	OffCommand=function(self)
		self:sleep(.8):accelerate(0.2):diffusealpha(0)
	end;
	CancelMessageCommand=function(self)
		self:sleep(.1):accelerate(0.2):diffusealpha(0)
	end;
};

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:Center():zoom(0):decelerate(0.2):zoom(1)
	end;
	OffCommand=function(self)
		self:addy(-10):decelerate(0.2):addy(10):sleep(0.5):accelerate(0.2):zoom(0)
	end;
	CancelMessageCommand=function(self)
		self:accelerate(0.2):addy(300)
	end;

	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=300, Height=100 } )..{
	};

	Def.ActorProxy{
	BeginCommand=function(self)
	self:SetTarget( SCREENMAN:GetTopScreen():GetChild("Question") )
	self:zoom(0.7):y(-30)
	end,
	};

	Def.ActorProxy{
	BeginCommand=function(self)
	self:SetTarget( SCREENMAN:GetTopScreen():GetChild("Answer") )
	self:zoom(0.7):y(20)
	end,
	};

}

return t;