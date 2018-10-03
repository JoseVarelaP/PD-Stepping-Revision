local t = Def.ActorFrame{};
local TotalAmmountWidth = 0


t[#t+1] = LoadFont("dinamight/25px")..{
	Text=DIVA["TotalForCompletion"][1];
	InitCommand=function(self)
		self:horizalign(left):xy(0,15):zoom(1.5):strokecolor(Color.Black)
	end;
};

t[#t+1] = LoadFont("dinamight/25px")..{
	Name="TotalAmmount";
	Text="/"..DIVA["TotalForCompletion"][2];
	InitCommand=function(self)
		self:horizalign(left):xy(30,44):zoom(0.9):strokecolor(Color.Black)
	end;
	OnCommand=function(self)
	TotalAmmountWidth = self:GetWidth();
	end,
};

t[#t+1] = LoadFont("Common Normal")..{
	Text="songs";
	InitCommand=function(self)
		self:horizalign(left):xy(34,46):zoom(0.8):strokecolor(Color.Black)
	end;
	OnCommand=function(self)
	self:addx( TotalAmmountWidth-5 )
	end,
};

return t;