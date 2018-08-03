local t = Def.ActorFrame {};
local gc = Var("GameCommand");

	t[#t+1] = Def.ActorFrame{

		LoadActor("MenuScrollers/Base")..{
		OnCommand=cmd(horizalign,left;zoom,2);
		};

		LoadActor("SelectMusic/ITEM_Song")..{
		OnCommand=cmd(horizalign,left;zoom,1.5;x,6);
		};

		LoadActor("SelectMusic/ITEM_New")..{
		OnCommand=cmd(horizalign,left;zoom,1.5;x,4;y,-8);
		SetMessageCommand=function(self,params)
		local song = params.Song;
		if song then
			if PROFILEMAN:IsSongNew(params.Song) then
				self:visible(true);
				self:ztest(true);
			else
				self:visible(false);
				self:ztest(false);
			end
		end
		end,
		};

		LoadFont("", "handel gothic") ..{
		Text="This is test";
		OnCommand=cmd(x,30;horizalign,left;shadowlength,1);
		GainFocusCommand=cmd(stoptweening;zoom,1.1);
		LoseFocusCommand=cmd(stoptweening;stopeffect;linear,0;zoom,1.0);
		DisabledCommand=cmd(diffuse,0.5,0.5,0.5,1);
		SetMessageCommand=function(self,params)
			local song = params.Song;
			if song then
				self:settext( song:GetDisplayMainTitle() );
			else
				self:settext("")
			end;
		end;
	};

	};
	
return t;