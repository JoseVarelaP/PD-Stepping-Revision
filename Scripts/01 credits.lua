PDSRPInfo = {
	Version = "0.5.6-s",
}

function GenerateHeader(texttomake)
	local t = Def.ActorFrame{
		LoadFont("Common Bold")..{
 			Text=texttomake;
 			InitCommand=function(self)
 				self:wrapwidthpixels(WideScale(400,500))
 			end;
 			OnCommand=function(self)
 				self:x(10):zoom(0.8):horizalign(left):strokecolor(color("0,0.5,0.8,1"))
 			end;
 			OffCommand=function(self)
 				self:accelerate(0.2):diffusealpha(0)
 			end;
 		};
 	};

 	return t;
end

function GenerateNormal(texttomake)
	local t = Def.ActorFrame{
		LoadFont("Common Normal")..{
 			Text=texttomake;
 			InitCommand=function(self)
 				self:wrapwidthpixels(WideScale(400,500))
 			end;
 			OnCommand=function(self)
 				self:zoom(0.6):x(10):horizalign(left):strokecolor(color("0,0,0,1"))
 			end;
 			OffCommand=function(self)
 				self:accelerate(0.2):diffusealpha(0)
 			end;
 		};
 	};

 	return t;
end

function GenerateExtra(texttomake)
	local t = Def.ActorFrame{
		LoadFont("Common Normal")..{
 			Text=texttomake;
 			InitCommand=function(self)
 				self:wrapwidthpixels(WideScale(400,500))
 			end;
 			OnCommand=function(self)
 				self:zoom(0.5):x(10):horizalign(left):diffuse(0.5,0.5,0.5,1):strokecolor(color("0,0,0,0.7"))
 			end;
 			OffCommand=function(self)
 				self:accelerate(0.2):diffusealpha(0)
 			end;
 		};
 	};

 	return t;
end

function Blank()
	return Def.ActorFrame{}
end