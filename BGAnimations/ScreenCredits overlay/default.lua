local line_on = function(self)
	self:y(-3):vertalign(top):wrapwidthpixels(WideScale(450,520)):horizalign(left):zoom(WideScale(0.5,0.6)):strokecolor(color("#444444")):shadowcolor(color("#444444")):shadowlength(1)
end
local section_on = function(self)
	self:wrapwidthpixels(WideScale(450,520)):horizalign(left):zoom(WideScale(0.6,0.8)):diffuse(color("#88DDFF")):strokecolor(color("#446688")):shadowcolor(color("#446688")):shadowlength(1)
end
local subsection_on = function(self)
	self:wrapwidthpixels(WideScale(450,520)):horizalign(left):zoom(WideScale(0.5,0.7)):diffuse(color("#88DDFF")):strokecolor(color("#446688")):shadowcolor(color("#446688")):shadowlength(1)
end
local item_padding_start = 4;
local line_height= WideScale(22,21)
-- Tell the credits table the line height so it can use it for logo sizing.
StepManiaCredits.SetLineHeight(line_height)

local creditScroller = Def.ActorScroller {
	SecondsPerItem = 0.5;
	NumItemsToDraw = 40;
	TransformFunction = function( self, offset, itemIndex, numItems)
		self:y(line_height*offset)
	end;
	OnCommand = function(self)
		self:scrollwithpadding(item_padding_start,18)
	end;
}

-- Add sections with padding.
for section in ivalues(StepManiaCredits.Get()) do
	StepManiaCredits.AddLineToScroller(creditScroller, section.name, section_on)
	for name in ivalues(section) do
		if name.type == "subsection" then
			StepManiaCredits.AddLineToScroller(creditScroller, name, subsection_on)
		else
			StepManiaCredits.AddLineToScroller(creditScroller, name, line_on)
		end
	end
	StepManiaCredits.AddLineToScroller(creditScroller)
	StepManiaCredits.AddLineToScroller(creditScroller)
end

creditScroller.BeginCommand=function(self)
	SCREENMAN:GetTopScreen():PostScreenMessage( 'SM_MenuTimer', (creditScroller.SecondsPerItem * (#creditScroller + item_padding_start) + 10) );
end;

local t = Def.ActorFrame{}

local TimeBeforeFade = 63

t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:zwrite(true):blend("BlendMode_NoEffect"):zoomto(350,100):CenterX():y(SCREEN_CENTER_Y):horizalign(left)
	end;
	OnCommand=function(self)
		self:sleep(1):queuecommand("Dissapear")
	end;
	DissapearCommand=function(self)
		self:visible(false)
	end;
};

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X-70):CenterY()
	end;
	OnCommand=function(self)
		self:sleep(TimeBeforeFade):accelerate(1):diffusealpha(0)
	end;

	LoadFont("Common Normal")..{
		Text=ProductFamily().." "..ProductVersion(),
		InitCommand=function(self)
			self:horizalign(right):x(-40):y(-20):zoom(0.5):diffusealpha(0):shadowlengthy(2)
		end;
		OnCommand=function(self)
			self:sleep(1):decelerate(0.2):diffusealpha(1)
		end;
		OffCommand=function(self)
			self:accelerate(0.2):diffusealpha(0)
		end;
	};

	LoadActor( "_arrow" )..{
		InitCommand=function(self)
			self:ztest(1):zoom(0.4):diffusealpha(0):addx(200):shadowlengthy(2)
		end;
		OnCommand=function(self)
			self:sleep(.3):decelerate(0.8):diffusealpha(1):addx(-210):wag():effectmagnitude(0,0,6)
		end;
		OffCommand=function(self)
			self:accelerate(0.2):diffusealpha(0)
		end;
	};

	LoadActor( "_text" )..{
		InitCommand=function(self)
			self:ztest(1):horizalign(right):zoom(0.4):diffusealpha(0):addx(200):shadowlengthy(2)
		end;
		OnCommand=function(self)
			self:sleep(.3):decelerate(0.8):diffusealpha(1):addx(-200)
		end;
		OffCommand=function(self)
			self:accelerate(0.2):diffusealpha(0)
		end;
	};

};

t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:Center():zoomto(0,0):sleep(0.2):decelerate(0.8):zoomto(2,350):fadetop(0.5):fadebottom(0.5)
	end;
	OnCommand=function(self)
		self:sleep(TimeBeforeFade):accelerate(1):diffusealpha(0)
	end;
	OffCommand=function(self)
		self:stoptweening():accelerate(0.2):diffusealpha(0)
	end;
};

t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:zwrite(true):blend("BlendMode_NoEffect"):CenterY():x(SCREEN_CENTER_X-28):zoomto(2,0):sleep(2.2):zoomto(28,SCREEN_HEIGHT)
	end;
};

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:zwrite(true):blend("BlendMode_NoEffect"):zoomto(350,350):CenterX():y(SCREEN_CENTER_Y-150):horizalign(left):vertalign(bottom)
	end;
};

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:zwrite(true):blend("BlendMode_NoEffect"):zoomto(350,350):CenterX():y(SCREEN_CENTER_Y+150):horizalign(left):vertalign(top)
	end;
};

t[#t+1] = Def.ActorFrame{
	OffCommand=function(self)
		self:accelerate(0.2):diffusealpha(0)
	end;
	creditScroller..{
		InitCommand=function(self)
			self:ztest(true):CenterX():addx(10):y(SCREEN_BOTTOM-64)
		end,
	}
};

return t;