local t = Def.ActorFrame{};

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffuse(0,0,0,0)
	end;
	SelectMenuOpenedMessageCommand=function(self)
		self:stoptweening():decelerate(0.2):diffusealpha(0.5)
	end;
	SelectMenuClosedMessageCommand=function(self)
		self:stoptweening():accelerate(0.2):diffusealpha(0)
	end;
}

t[#t+1] = Def.ActorFrame {
		OnCommand=function(self)
			self:Center():diffusealpha(0):zoom(0)
		end;
		SelectMenuOpenedMessageCommand=function(self)
			self:stoptweening():decelerate(0.2):diffusealpha(1):zoom(0.8)
		end;
		SelectMenuClosedMessageCommand=function(self)
			self:stoptweening():accelerate(0.2):diffusealpha(0):zoom(0.5)
		end;


		LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=400, Height=200 } )..{
		};

		LoadFont("Common Normal")..{
			Text=Screen.String("ButtonHelp");
			InitCommand=function(self)
				self:zoom(0.8):wrapwidthpixels(600):strokecolor(Color.Black):horizalign(left):x(-240):vertspacing(8):vertalign(top):y(-80)
			end;
			OnCommand=function(self)
			if THEME:GetCurLanguage() == "es" then
				self:zoom(0.7):wrapwidthpixels(650)
			end
			end,
		};
};

return t;