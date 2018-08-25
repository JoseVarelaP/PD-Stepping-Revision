local t = Def.ActorFrame {};
local gc = Var("GameCommand");

	t[#t+1] = Def.ActorFrame{

		LoadActor("MenuScrollers/Bright")..{
		OnCommand=cmd(horizalign,left;zoom,2);
		};

		LoadActor("SelectMusic/ITEM_Folder")..{
		OnCommand=cmd(horizalign,left;zoom,1.5;x,4;y,0);
		};

		LoadFont("Common Normal") ..{
		Text="This is test";
		OnCommand=cmd(x,30;horizalign,left;shadowlength,1);
		SetMessageCommand=function(self,params)
			local BannerTitle = params.Text;
			if BannerTitle then
				self:settext( BannerTitle );
			else
				self:settext("")
			end;
		end;
	};

	};


return t;