local t = Def.ActorFrame{}

t[#t+1] = LoadActor( THEME:GetPathG("","Light_BottomMenuBar") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;horizalign,right;zoom,2;SetTextureFiltering,false;y,SCREEN_BOTTOM;vertalign,bottom);
};

t[#t+1] = Def.Quad{
	InitCommand=cmd(zwrite,true;blend,"BlendMode_NoEffect";zoomto,350,100;CenterX;y,SCREEN_CENTER_Y;horizalign,left);
	OnCommand=cmd(sleep,1;queuecommand,"Dissapear");
	DissapearCommand=cmd(visible,false);
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_CENTER_X-20;CenterY);
	OnCommand=cmd(sleep,25;accelerate,1;diffusealpha,0);

	LoadFont("Common Normal")..{
		Text="Version ".. PDSRPInfo["Version"],
		InitCommand=cmd(horizalign,right;y,35;x,-70;zoom,0.5;diffusealpha,0;shadowlengthy,2;strokecolor,Color.Black);
		OnCommand=cmd(sleep,1;decelerate,0.2;diffusealpha,1);
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};

	LoadActor( THEME:GetPathG("","ThemeLogo") )..{
		InitCommand=cmd(ztest,1;horizalign,right;zoom,0.4;diffusealpha,0;addx,200;shadowlengthy,2);
		OnCommand=cmd(sleep,.3;decelerate,0.8;diffusealpha,1;addx,-200);
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};

};

t[#t+1] = Def.Quad{
	InitCommand=cmd(Center;zoomto,2,0;sleep,0.2;decelerate,0.8;zoomto,2,350;fadetop,0.5;fadebottom,0.5);
	OnCommand=cmd(sleep,24;accelerate,1;diffusealpha,0);
	OffCommand=cmd(stoptweening;accelerate,0.2;diffusealpha,0);
};

local line_height= 20
local item_padding_start = 12;

t[#t+1] = Def.Quad{
	OnCommand=cmd(zwrite,true;blend,"BlendMode_NoEffect";zoomto,350,350;CenterX;y,SCREEN_CENTER_Y-150;horizalign,left;vertalign,bottom);
};

t[#t+1] = Def.Quad{
	OnCommand=cmd(zwrite,true;blend,"BlendMode_NoEffect";zoomto,350,350;CenterX;y,SCREEN_CENTER_Y+150;horizalign,left;vertalign,top);
};

t[#t+1] = Def.ActorScroller {
	SecondsPerItem = 0.5;
	NumItemsToDraw = 40;
	TransformFunction = function( self, offset, itemIndex, numItems)
		self:y(line_height*offset)
	end;
	OnCommand = cmd(ztest,1;scrollwithpadding,item_padding_start,15;Center);
	BeginCommand= function(self)
		SCREENMAN:GetTopScreen():PostScreenMessage( 'SM_MenuTimer', (26) );
	end,
	OffCommand=cmd(accelerate,0.2;diffusealpha,0);

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
 	GenerateNormal("Jared Gaming Discord");
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