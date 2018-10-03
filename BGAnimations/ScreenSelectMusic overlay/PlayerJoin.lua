local t = Def.ActorFrame{};

local player = ...

t[#t+1] = Def.ActorFrame{
		InitCommand=function(self)
			self:Center():diffusealpha(0):zoom(0)
		end;
		PlayerJoinedMessageCommand=function(self)
			self:stoptweening():decelerate(0.2):diffusealpha(1):zoom(0.8):sleep(1):accelerate(0.2):diffusealpha(0):zoom(0)
		end;

		LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=500, Height=60 } )..{
		Condition=not GAMESTATE:IsPlayerEnabled(player);
		};		

		LoadFont("Common Normal")..{
			Condition=not GAMESTATE:IsPlayerEnabled(player);
			InitCommand=function(self)
				self:zoom(0.8):wrapwidthpixels(600)
			end;
			PlayerJoinedMessageCommand=function(self)
			self:settextf( THEME:GetString("ScreenSelectMusic","PlayerJoin"), PROFILEMAN:GetProfile(player):GetDisplayName() )
			end,
		};
};

return t;