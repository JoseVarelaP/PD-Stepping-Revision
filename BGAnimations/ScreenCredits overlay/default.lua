-- To add a section to the credits, use the following:
-- local theme_credits= {
-- 	name= "Theme Credits", -- the name of your section
-- 	"Me", -- The people you want to list in your section.
-- 	"Myself",
-- 	"My other self",
--  {logo= "pro_dude", name= "Pro self"}, -- Someone who has a logo image.
--     -- This logo image would be "Graphics/CreditsLogo pro_dude.png".
-- }
-- StepManiaCredits.AddSection(theme_credits)
--
-- If you want to add your section after an existing section, use the following:
-- StepManiaCredits.AddSection(theme_credits, 7)
--
-- Or position can be the name of a section to insert after:
-- StepManiaCredits.AddSection(theme_credits, "Special Thanks")
--
-- Or if you want to add your section before a section:
-- StepManiaCredits.AddSection(theme_credits, "Special Thanks", true)

-- StepManiaCredits is defined in _fallback/Scripts/04 CreditsHelpers.lua.

local line_on = cmd(y,-3;vertalign,top;wrapwidthpixels,WideScale(400,520);horizalign,left;zoom,WideScale(0.5,0.6);strokecolor,color("#444444");shadowcolor,color("#444444");shadowlength,1)
local section_on = cmd(wrapwidthpixels,WideScale(400,520);horizalign,left;zoom,WideScale(0.6,0.8);diffuse,color("#88DDFF");strokecolor,color("#446688");shadowcolor,color("#446688");shadowlength,1)
local subsection_on = cmd(wrapwidthpixels,WideScale(400,520);horizalign,left;zoom,WideScale(0.5,0.7);diffuse,color("#88DDFF");strokecolor,color("#446688");shadowcolor,color("#446688");shadowlength,1)
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
	OnCommand = cmd(scrollwithpadding,item_padding_start,18);
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
	InitCommand=cmd(zwrite,true;blend,"BlendMode_NoEffect";zoomto,350,100;CenterX;y,SCREEN_CENTER_Y;horizalign,left);
	OnCommand=cmd(sleep,1;queuecommand,"Dissapear");
	DissapearCommand=cmd(visible,false);
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_CENTER_X-70;CenterY);
	OnCommand=cmd(sleep,TimeBeforeFade;accelerate,1;diffusealpha,0);

	LoadFont("Common Normal")..{
		Text=ProductFamily().." "..ProductVersion(),
		InitCommand=cmd(horizalign,right;x,-40;y,-20;zoom,0.5;diffusealpha,0;shadowlengthy,2);
		OnCommand=cmd(sleep,1;decelerate,0.2;diffusealpha,1);
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};

	LoadActor( "_arrow" )..{
		InitCommand=cmd(ztest,1;zoom,0.4;diffusealpha,0;addx,200;shadowlengthy,2);
		OnCommand=cmd(sleep,.3;decelerate,0.8;diffusealpha,1;addx,-210;wag;effectmagnitude,0,0,6);
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};

	LoadActor( "_text" )..{
		InitCommand=cmd(ztest,1;horizalign,right;zoom,0.4;diffusealpha,0;addx,200;shadowlengthy,2);
		OnCommand=cmd(sleep,.3;decelerate,0.8;diffusealpha,1;addx,-200);
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};

};

t[#t+1] = Def.Quad{
	InitCommand=cmd(Center;zoomto,0,0;sleep,0.2;decelerate,0.8;zoomto,2,350;fadetop,0.5;fadebottom,0.5);
	OnCommand=cmd(sleep,TimeBeforeFade;accelerate,1;diffusealpha,0);
	OffCommand=cmd(stoptweening;accelerate,0.2;diffusealpha,0);
};

t[#t+1] = Def.Quad{
	InitCommand=cmd(zwrite,true;blend,"BlendMode_NoEffect";CenterY;x,SCREEN_CENTER_X-28;zoomto,2,0;sleep,2.2;zoomto,28,SCREEN_HEIGHT);
};

t[#t+1] = Def.Quad{
	OnCommand=cmd(zwrite,true;blend,"BlendMode_NoEffect";zoomto,350,350;CenterX;y,SCREEN_CENTER_Y-150;horizalign,left;vertalign,bottom);
};

t[#t+1] = Def.Quad{
	OnCommand=cmd(zwrite,true;blend,"BlendMode_NoEffect";zoomto,350,350;CenterX;y,SCREEN_CENTER_Y+150;horizalign,left;vertalign,top);
};

t[#t+1] = Def.ActorFrame{
	OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	creditScroller..{
		InitCommand=cmd(ztest,true;CenterX;addx,10;y,SCREEN_BOTTOM-64),
	}
};

return t;