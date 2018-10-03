-- how does installed song??? let's find out

local SitesList = {
	"stepmaniaonline.net",
	"zenius-i-vanisher.com/v5.2/",
}

local t = Def.ActorFrame{
	
	LoadFont("Common Normal")..{
		Text=Screen.String("BodyHeader");
		InitCommand=function(self)
			self:xy(SCREEN_LEFT+24,SCREEN_TOP+13):halign(0):zoom(0.7)
		end;
	};

	Def.ActorFrame{
	OnCommand=function(self)
		self:diffusealpha(0):addx(-100):decelerate(0.2):diffusealpha(1):addx(100);
	end;
		LoadFont("Common Normal")..{ Text=Screen.String("NoSongsFound");
			InitCommand=function(self)
				self:xy(SCREEN_LEFT+24,SCREEN_TOP+60):halign(0):zoom(0.8):strokecolor(Color.Black);
			end;
		};
		LoadFont("Common Normal")..{ Text=Screen.String("OverviewBegin");
			InitCommand=function(self)
				self:xy(SCREEN_LEFT+24,SCREEN_TOP+75):halign(0):zoom(0.6):strokecolor(Color.Black);
			end;
		};

	};

	Def.ActorFrame{
	OnCommand=function(self)
	 	self:xy(SCREEN_LEFT+70,SCREEN_CENTER_Y-130):diffusealpha(0):addx(-100)
	 	:decelerate(0.2):diffusealpha(1):addx(100);
	end;

		LoadFont("Common Normal")..{
		Text=Screen.String("Tutorial1");
		InitCommand=function(self)
			self:xy(-40,0):align(0,0):zoom(0.6):wrapwidthpixels(SCREEN_WIDTH/1.5):strokecolor(Color.Black)
		end;
		};

		LoadFont("Common Normal")..{
		InitCommand=function(self)
			self:x(-30):y(60):horizalign(left):zoom(0.6):wrapwidthpixels(SCREEN_WIDTH/1.5):strokecolor(Color.Black):vertalign(top)
		end;
		OnCommand=function(self)
		local ArrangeList = ''
		for i=1,#SitesList do
			ArrangeList = ArrangeList .. SitesList[i].."\n"
		end
		self:settext(ArrangeList)
		end,
		};

		LoadFont("Common Normal")..{
		Text=Screen.String("Tutorial2");
		InitCommand=function(self)
			self:x(-40):y(110):horizalign(left):zoom(0.6):wrapwidthpixels(SCREEN_WIDTH/1.5):strokecolor(Color.Black):vertalign(top)
		end;
		};
	};

	-- Video examples
	-- FOLDER EXAMPLE
	LoadActor( THEME:GetPathG("","InstallSongs_Tutorial/folder_example") )..{
		InitCommand=function(self)
			self:shadowlengthy(3):zoom(0.2):x(SCREEN_RIGHT-30):horizalign(right):vertalign(bottom):y(SCREEN_BOTTOM-50)
		end;
		OnCommand=function(self)
			self:diffusealpha(0):addx(100):decelerate(0.2):diffusealpha(1):addx(-100)
		end;
	};

	LoadActor( THEME:GetPathG("","InstallSongs_Tutorial/ZipShown") )..{
		InitCommand=function(self)
			self:shadowlengthy(3):zoom(0.5):x(SCREEN_RIGHT-100):vertalign(bottom):y(SCREEN_CENTER_Y-70)
		end;
		OnCommand=function(self)
			self:diffusealpha(0):addx(100):decelerate(0.2):diffusealpha(1):addx(-100)
		end;
	};

	Def.Quad{
		InitCommand=function(self)
			self:shadowlengthy(3):rotationz(45):zoom(20):x(SCREEN_RIGHT-100):horizalign(right):vertalign(bottom):y(SCREEN_CENTER_Y-35)
		end;
		OnCommand=function(self)
			self:diffusealpha(0):addx(100):decelerate(0.2):diffusealpha(1):addx(-100):bob():effectmagnitude(0,5,0)
		end;
	};

	LoadActor( THEME:GetPathG("","InstallSongs_Tutorial/ZipExtracted") )..{
		InitCommand=function(self)
			self:shadowlengthy(3):zoom(0.4):x(SCREEN_RIGHT-100):vertalign(bottom):y(SCREEN_CENTER_Y+35)
		end;
		OnCommand=function(self)
			self:diffusealpha(0):addx(100):decelerate(0.2):diffusealpha(1):addx(-100)
		end;
	};

	Def.Quad{
		InitCommand=function(self)
			self:shadowlengthy(3):rotationz(45):zoom(20):x(SCREEN_RIGHT-100):horizalign(right):vertalign(bottom):y(SCREEN_CENTER_Y+80)
		end;
		OnCommand=function(self)
			self:diffusealpha(0):addx(100):decelerate(0.2):diffusealpha(1):addx(-100):bob():effectmagnitude(0,5,0)
		end;
	};

	-- SMZIP EXAMPLE
	LoadActor( THEME:GetPathG("","InstallSongs_Tutorial/SMIcon") )..{
		InitCommand=function(self)
			self:shadowlengthy(3):zoom(0.25):x(WideScale(SCREEN_RIGHT-220,SCREEN_RIGHT-240)):horizalign(right):vertalign(bottom):y(SCREEN_CENTER_Y+10)
		end;
		OnCommand=function(self)
			self:diffusealpha(0):addx(100):decelerate(0.2):diffusealpha(1):addx(-100)
		end;
	};

	LoadFont("Common Normal")..{
		Text=".SMZIP";
		InitCommand=function(self)
			self:shadowlengthy(3):zoom(0.85):x(WideScale(SCREEN_RIGHT-250,SCREEN_RIGHT-270)):vertalign(bottom):y(SCREEN_CENTER_Y+30):strokecolor(Color.Black)
		end;
		OnCommand=function(self)
			self:diffusealpha(0):addx(100):decelerate(0.2):diffusealpha(1):addx(-100)
		end;
	};

	Def.Quad{
		InitCommand=function(self)
			self:shadowlengthy(3):rotationz(45):zoom(20):x(WideScale(SCREEN_RIGHT-250,SCREEN_RIGHT-270)):horizalign(right):vertalign(bottom):y(SCREEN_CENTER_Y+70)
		end;
		OnCommand=function(self)
			self:diffusealpha(0):addx(100):decelerate(0.2):diffusealpha(1):addx(-100):bob():effectmagnitude(0,5,0)
		end;
	};

	LoadActor( THEME:GetPathG("","InstallSongs_Tutorial/smzip_example") )..{
		InitCommand=function(self)
			self:shadowlengthy(3):zoom(0.2):x(WideScale(SCREEN_RIGHT-180,SCREEN_RIGHT-200)):horizalign(right):vertalign(bottom):y(SCREEN_BOTTOM-50)
		end;
		OnCommand=function(self)
			self:diffusealpha(0):addx(100):decelerate(0.2):diffusealpha(1):addx(-100)
		end;
	};
	
};

return t;