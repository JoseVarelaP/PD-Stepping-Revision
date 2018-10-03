local t = Def.ActorFrame {};
local gc = Var("GameCommand");

	t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:x(SCREEN_RIGHT-WideScale(10,70)):y(SCREEN_BOTTOM-100):diffusealpha(0):sleep(0.3):decelerate(0.2):diffusealpha(1)
	end;
	OffCommand=function(self)
		self:accelerate(0.2):diffusealpha(0)
	end;

		-- LoadActor("TitleMenu/"..gc:GetText())..{
		-- InitCommand=cmd(horizalign,right;x,500;y,-100;zoom,1;decelerate,0.2);
		-- --OnCommand=cmd(x,300);
		-- GainFocusCommand=cmd(stoptweening;decelerate,0.2;x,300;diffusealpha,1);
		-- LoseFocusCommand=cmd(stoptweening;decelerate,0.2;x,500;diffusealpha,0);
		-- };

		LoadActor("Title_Explanation")..{
		OnCommand=function(self)
			self:horizalign(right):zoom(1.5):zoomy(1.3)
		end;
		GainFocusCommand=function(self)
			self:stoptweening():decelerate(0.1):diffusealpha(1)
		end;
		LoseFocusCommand=function(self)
			self:stoptweening():decelerate(0.1):diffusealpha(0)
		end;
		};

		LoadFont("Common Normal") ..{
		Text=THEME:GetString( 'TitleExplanations', Var("GameCommand"):GetText() );
		OnCommand=function(self)
			self:x(-230):y(-40):zoom(0.6):horizalign(left):wrapwidthpixels(300):vertalign(top):diffuse(0,0,0,1)
		end;
		GainFocusCommand=function(self)
			self:stoptweening():visible(true):diffusealpha(0):sleep(0.1):linear(0.1):diffusealpha(1)
		end;
		LoseFocusCommand=function(self)
			self:stoptweening():visible(false)
		end;
		DisabledCommand=function(self)
			self:diffuse(0.5,0.5,0.5,1)
		end;
	};

	};

return t;