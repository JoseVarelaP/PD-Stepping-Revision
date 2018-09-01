PDSRPInfo = {
	Version = "0.5.1-a",
	Author = "Jose_Varela",
	Graphics = {
		"Jose_Varela",
		"Akira Sora",
	},
	SpecialT ={
		"UKSRT Discord",
		"StepMania Online Discord",
		"Jared Gaming Discord",
		"Tesseract (Suggestions)",
		"KcHecKa (Suggestions)",
		"ElliotBG (Feedback)",
		"Moru Zenhiro (Feedback)",
		"StepMania Themming Community",
	},
	Modelling = {
		"Jose_Varela",
	},

	OriginalWork = {
		"SEGA",
		"Crypton Future Media, Inc.",
	},
}

function GenerateHeader(texttomake)
	local t = Def.ActorFrame{
		LoadFont("Common Bold")..{
 			Text=texttomake;
 			InitCommand=cmd(wrapwidthpixels,WideScale(400,500));
 			OnCommand=cmd(x,10;zoom,0.8;horizalign,left;strokecolor,color("0,0.5,0.8,1"));
 			OffCommand=cmd(accelerate,0.2;diffusealpha,0);
 		};
 	};

 	return t;
end

function GenerateNormal(texttomake)
	local t = Def.ActorFrame{
		LoadFont("Common Normal")..{
 			Text=texttomake;
 			InitCommand=cmd(wrapwidthpixels,WideScale(400,500));
 			OnCommand=cmd(zoom,0.6;x,10;horizalign,left;strokecolor,color("0,0,0,1"));
 			OffCommand=cmd(accelerate,0.2;diffusealpha,0);
 		};
 	};

 	return t;
end

function GenerateExtra(texttomake)
	local t = Def.ActorFrame{
		LoadFont("Common Normal")..{
 			Text=texttomake;
 			InitCommand=cmd(wrapwidthpixels,WideScale(400,500));
 			OnCommand=cmd(zoom,0.5;x,10;horizalign,left;diffuse,0.5,0.5,0.5,1;strokecolor,color("0,0,0,0.7"));
 			OffCommand=cmd(accelerate,0.2;diffusealpha,0);
 		};
 	};

 	return t;
end

function Blank()
	return Def.ActorFrame{}
end