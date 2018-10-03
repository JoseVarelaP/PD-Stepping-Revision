local t = Def.ActorFrame{}

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
		self:x(SCREEN_CENTER_X-20):CenterY()
	end;
	OnCommand=function(self)
		self:sleep(25):accelerate(1):diffusealpha(0)
	end;

	LoadFont("Common Normal")..{
		Text="Version ".. PDSRPInfo["Version"],
		InitCommand=function(self)
			self:horizalign(right):y(35):x(-70):zoom(0.5):diffusealpha(0):shadowlengthy(2):strokecolor(Color.Black)
		end;
		OnCommand=function(self)
			self:sleep(1):decelerate(0.2):diffusealpha(1)
		end;
		OffCommand=function(self)
			self:accelerate(0.2):diffusealpha(0)
		end;
	};

	LoadActor( THEME:GetPathG("","ThemeLogo") )..{
		InitCommand=function(self)
			self:ztest(1):horizalign(right):zoom(WideScale(0.33,0.4)):diffusealpha(0):addx(200):shadowlengthy(2)
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
		self:Center():zoomto(2,0):sleep(0.2):decelerate(0.8):zoomto(2,350):fadetop(0.5):fadebottom(0.5)
	end;
	OnCommand=function(self)
		self:sleep(24):accelerate(1):diffusealpha(0)
	end;
	OffCommand=function(self)
		self:stoptweening():accelerate(0.2):diffusealpha(0)
	end;
};

local line_height= 20
local item_padding_start = 12;

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

t[#t+1] = Def.ActorScroller {
	SecondsPerItem = 0.5;
	NumItemsToDraw = 40;
	TransformFunction = function( self, offset, itemIndex, numItems)
		self:y(line_height*offset)
	end;
	OnCommand = function(self)
		self:ztest(1):scrollwithpadding(item_padding_start,15):Center()
	end;
	BeginCommand= function(self)
		SCREENMAN:GetTopScreen():PostScreenMessage( 'SM_MenuTimer', (26) );
	end,
	OffCommand=function(self)
		self:accelerate(0.2):diffusealpha(0)
	end;

	GenerateHeader("Main Programming");
 	GenerateNormal("Jose_Varela");
 	Blank();
 	GenerateHeader("Graphics");
 	GenerateNormal("Jose_Varela");
 	GenerateNormal("Ploaj");
 	GenerateNormal("Akira Sora");	 	
 	Blank();
 	GenerateHeader("Modelling/Rigging");
 	GenerateNormal("Jose_Varela");
 	GenerateNormal("nampukkk");
 	GenerateNormal("senseitag");
 	Blank();
 	GenerateHeader("Special Thanks");
 	GenerateNormal("UKSRT Discord");
 	GenerateNormal("StepMania Online Discord");
 	GenerateNormal("dbk2 (Code Help)");
 	GenerateNormal("R.O.B-Bot (Suggestions/Feedback)");
 	GenerateNormal("Tesseract (Suggestions)");
 	GenerateNormal("KcHecKa (Suggestions)");
 	GenerateNormal("ElliotBG (Feedback)");
 	GenerateNormal("Moru Zenhiro (Feedback)");
 	GenerateNormal("StepMania Themming Community");
 	Blank(); Blank(); Blank();
 	GenerateExtra("Project Diva: Stepping Revision Project is a Fan work, not meant to hurt its IP in any way.");
 	Blank(); Blank();
 	GenerateExtra("PD:SRP falls on GNU General Public License Version 3. For more information, check the LICENSE file inside the theme folder.");
 	Blank(); Blank();
 	GenerateExtra("Hatsune Miku, Project DIVA, and related assets are copyrighted work of SEGA and Crypton Future Media.")
};


return t;