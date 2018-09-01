-- how does installed song??? let's find out

local SitesList = {
	"stepmaniaonline.net",
	"zenius-i-vanisher.com/v5.2/",
}

local t = Def.ActorFrame{
	
	LoadFont("Common Normal")..{
		Text=Screen.String("BodyHeader");
		InitCommand=cmd(x,SCREEN_LEFT+24;y,SCREEN_TOP+13;horizalign,left;zoom,0.7);
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("NoSongsFound");
		InitCommand=cmd(x,SCREEN_LEFT+24;y,SCREEN_TOP+60;horizalign,left;zoom,0.8;strokecolor,Color.Black);
		OnCommand=cmd(diffusealpha,0;addx,-100;decelerate,0.2;diffusealpha,1;addx,100);
	};
	LoadFont("Common Normal")..{
		Text=Screen.String("OverviewBegin");
		InitCommand=cmd(x,SCREEN_LEFT+24;y,SCREEN_TOP+75;horizalign,left;zoom,0.6;strokecolor,Color.Black);
		OnCommand=cmd(diffusealpha,0;addx,-100;decelerate,0.2;diffusealpha,1;addx,100);
	};

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_LEFT+70;y,SCREEN_CENTER_Y-130;diffusealpha,0;addx,-100;decelerate,0.2;diffusealpha,1;addx,100);

		LoadFont("Common Normal")..{
		Text=Screen.String("Tutorial1");
		InitCommand=cmd(x,-40;y,0;horizalign,left;zoom,0.6;wrapwidthpixels,SCREEN_WIDTH/1.5;strokecolor,Color.Black;vertalign,top);
		};

		LoadFont("Common Normal")..{
		InitCommand=cmd(x,-30;y,60;horizalign,left;zoom,0.6;wrapwidthpixels,SCREEN_WIDTH/1.5;strokecolor,Color.Black;vertalign,top);
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
		InitCommand=cmd(x,-40;y,110;horizalign,left;zoom,0.6;wrapwidthpixels,SCREEN_WIDTH/1.5;strokecolor,Color.Black;vertalign,top);
		};
	};

	-- Video examples
	-- FOLDER EXAMPLE
	LoadActor( THEME:GetPathG("","InstallSongs_Tutorial/folder_example") )..{
		InitCommand=cmd(shadowlengthy,3;zoom,WideScale(0.2,0.3);x,SCREEN_RIGHT-30;horizalign,right;vertalign,bottom;y,SCREEN_BOTTOM-50);
		OnCommand=cmd(diffusealpha,0;addx,100;decelerate,0.2;diffusealpha,1;addx,-100);
	};

	LoadActor( THEME:GetPathG("","InstallSongs_Tutorial/ZipShown") )..{
		InitCommand=cmd(shadowlengthy,3;zoom,0.5;x,SCREEN_RIGHT-100;vertalign,bottom;y,SCREEN_CENTER_Y-70);
		OnCommand=cmd(diffusealpha,0;addx,100;decelerate,0.2;diffusealpha,1;addx,-100);
	};

	Def.Quad{
		InitCommand=cmd(shadowlengthy,3;rotationz,45;zoom,20;x,SCREEN_RIGHT-100;;horizalign,right;vertalign,bottom;y,SCREEN_CENTER_Y-35);
		OnCommand=cmd(diffusealpha,0;addx,100;decelerate,0.2;diffusealpha,1;addx,-100;bob;effectmagnitude,0,5,0);
	};

	LoadActor( THEME:GetPathG("","InstallSongs_Tutorial/ZipExtracted") )..{
		InitCommand=cmd(shadowlengthy,3;zoom,0.4;x,SCREEN_RIGHT-100;vertalign,bottom;y,SCREEN_CENTER_Y+35);
		OnCommand=cmd(diffusealpha,0;addx,100;decelerate,0.2;diffusealpha,1;addx,-100);
	};

	Def.Quad{
		InitCommand=cmd(shadowlengthy,3;rotationz,45;zoom,20;x,SCREEN_RIGHT-100;;horizalign,right;vertalign,bottom;y,SCREEN_CENTER_Y+80);
		OnCommand=cmd(diffusealpha,0;addx,100;decelerate,0.2;diffusealpha,1;addx,-100;bob;effectmagnitude,0,5,0);
	};

	-- SMZIP EXAMPLE
	LoadActor( THEME:GetPathG("","InstallSongs_Tutorial/SMIcon") )..{
		InitCommand=cmd(shadowlengthy,3;zoom,0.25;x,WideScale(SCREEN_RIGHT-220,SCREEN_RIGHT-250);horizalign,right;vertalign,bottom;y,SCREEN_CENTER_Y+10);
		OnCommand=cmd(diffusealpha,0;addx,100;decelerate,0.2;diffusealpha,1;addx,-100);
	};

	LoadFont("Common Normal")..{
		Text=".SMZIP";
		InitCommand=cmd(shadowlengthy,3;zoom,0.85;x,WideScale(SCREEN_RIGHT-250,SCREEN_RIGHT-250);vertalign,bottom;y,SCREEN_CENTER_Y+30;strokecolor,Color.Black);
		OnCommand=cmd(diffusealpha,0;addx,100;decelerate,0.2;diffusealpha,1;addx,-100);
	};

	Def.Quad{
		InitCommand=cmd(shadowlengthy,3;rotationz,45;zoom,20;x,WideScale(SCREEN_RIGHT-250,SCREEN_RIGHT-250);horizalign,right;vertalign,bottom;y,SCREEN_CENTER_Y+70);
		OnCommand=cmd(diffusealpha,0;addx,100;decelerate,0.2;diffusealpha,1;addx,-100;bob;effectmagnitude,0,5,0);
	};

	LoadActor( THEME:GetPathG("","InstallSongs_Tutorial/smzip_example") )..{
		InitCommand=cmd(shadowlengthy,3;zoom,WideScale(0.2,0.3);x,WideScale(SCREEN_RIGHT-180,SCREEN_RIGHT-250);horizalign,right;vertalign,bottom;y,SCREEN_BOTTOM-50);
		OnCommand=cmd(diffusealpha,0;addx,100;decelerate,0.2;diffusealpha,1;addx,-100);
	};
	
};

return t;