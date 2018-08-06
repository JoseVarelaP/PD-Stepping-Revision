local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,0,0,0,0;decelerate,0.4;diffusealpha,0.8);
	OffCommand=cmd(sleep,.8;accelerate,0.2;diffusealpha,0);
	CancelMessageCommand=cmd(sleep,.1;accelerate,0.2;diffusealpha,0);
}

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(Center;zoom,0;decelerate,0.2;zoom,1);
	OffCommand=cmd(addy,-10;decelerate,0.2;addy,10;sleep,0.5;accelerate,0.2;zoom,0);
	CancelMessageCommand=cmd(accelerate,0.2;addy,300);

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