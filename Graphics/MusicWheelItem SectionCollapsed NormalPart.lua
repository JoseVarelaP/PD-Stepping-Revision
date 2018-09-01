local t = Def.ActorFrame {};

	t[#t+1] = Def.ActorFrame{

		LoadActor("SelectMusic/WheelHighlight")..{
		InitCommand=cmd(horizalign,left;zoom,0.5;shadowlength,3);
		};

		LoadActor("SelectMusic/Base_WheelSong")..{
		OnCommand=cmd(horizalign,left;zoom,0.5);
		};

		LoadActor("SelectMusic/Color_WheelSong")..{
		OnCommand=cmd(horizalign,left;zoom,0.5);
		};

		LoadFont("Common Normal") ..{
		Text="This is test";
		OnCommand=cmd(x,110;y,-14;horizalign,left;shadowlength,1;strokecolor,Color.Black;maxwidth,430);
		SetMessageCommand=function(self,params)
		local BannerTitle = params.Text;
		self:settext("")
			if BannerTitle then
				self:settext( BannerTitle );
			end;
		end;
	};

	};


return t;