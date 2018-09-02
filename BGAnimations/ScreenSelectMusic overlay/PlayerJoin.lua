local t = Def.ActorFrame{};

local player = ...

t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(Center;diffusealpha,0;zoom,0);
		PlayerJoinedMessageCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,1;zoom,0.8;sleep,1;accelerate,0.2;diffusealpha,0;zoom,0);

		LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=500, Height=60 } )..{
		Condition=not GAMESTATE:IsPlayerEnabled(player);
		};		

		LoadFont("Common Normal")..{
			Condition=not GAMESTATE:IsPlayerEnabled(player);
			InitCommand=cmd(zoom,0.8;wrapwidthpixels,600);
			PlayerJoinedMessageCommand=function(self)
			self:settextf( THEME:GetString("ScreenSelectMusic","PlayerJoin"), PROFILEMAN:GetProfile(player):GetDisplayName() )
			end,
		};
};

return t;