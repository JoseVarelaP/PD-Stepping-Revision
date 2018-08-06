local t = Def.ActorFrame{}

-- t[#t+1] = Def.Quad{
-- 	OnCommand=cmd(FullScreen;diffuse,0,0,0,0;decelerate,);
-- }

local function Cont_Position()
	local ASP = PREFSMAN:GetPreference("DisplayAspectRatio")
	if ASP > 1.77 then return SCREEN_WIDTH/4 end
	return SCREEN_WIDTH/5
end

t[#t+1] = Def.ActorFrame{
	BeginCommand=cmd(x,WideScale(140,Cont_Position());zoom,1;diffusealpha,0;decelerate,0.2;diffusealpha,1);
	OffCommand=cmd(addy,-10;decelerate,0.2;addy,10;sleep,0.5;accelerate,0.2;zoom,0);
	CancelMessageCommand=cmd(accelerate,0.1;diffusealpha,0);

	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=430, Height=300 } )..{
	};

	Def.ActorProxy{
	BeginCommand=function(self)
	self:SetTarget( SCREENMAN:GetTopScreen():GetChild("Container") )
	self:zoom(0.7):y(-10)
	end,
	};

}

return t;