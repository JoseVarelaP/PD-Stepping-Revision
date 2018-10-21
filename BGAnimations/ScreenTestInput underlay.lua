return Def.ActorFrame {
	Def.DeviceList {
		Font="Common Normal",
		InitCommand=function(self)
			self:xy(SCREEN_LEFT+20,SCREEN_TOP+80):zoom(0.8):halign(0)
		end;
	};

	Def.InputList {
		Font="Common Normal",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X-250,SCREEN_CENTER_Y):zoom(0.7):halign(0)
		end;
	};
};
