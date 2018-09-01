local t = Def.ActorFrame {};

	t[#t+1] = Def.ActorFrame{

		LoadActor("SelectMusic/WheelHighlight")..{
		InitCommand=cmd(horizalign,left;zoom,0.5;shadowlength,3);
		SetMessageCommand=function(self,params)
		self:diffusebottomedge(Color.White)
		self:diffusetopedge(Color.White)
		if DIVA:CalculatePercentageSongs(params.Text) == 1 then
			self:diffusebottomedge( color("#E1A81D") )
			self:diffusetopedge( color("#FFECC7") )
		end
		end,
		};

		LoadActor("SelectMusic/Base_WheelSong")..{
		OnCommand=cmd(horizalign,left;zoom,0.5);
		SetMessageCommand=function(self,params)
		self:diffusebottomedge(Color.White)
		self:diffusetopedge(Color.White)
		if DIVA:CalculatePercentageSongs(params.Text) == 1 then
			self:diffusebottomedge( color("#E1A81D") )
			self:diffusetopedge( color("#FFECC7") )
		end
		end,
		};

		LoadActor("SelectMusic/Color_WheelSong")..{
		OnCommand=cmd(horizalign,left;zoom,0.5);
		SetMessageCommand=function(self,params)
		self:diffusebottomedge(Color.White)
		self:diffusetopedge(Color.White)
		if DIVA:CalculatePercentageSongs(params.Text) == 1 then
			self:diffusebottomedge( color("#E1A81D") )
			self:diffusetopedge( color("#FFECC7") )
		end
		end,
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

if ThemePrefs.Get("ShowPlayedSongsInFolder") then

t[#t+1] = LoadFont("renner/20px") ..{
	Text="This is test";
	InitCommand=cmd(x,500;y,14;horizalign,right;shadowlength,1;zoom,0.8;strokecolor,Color.Black;maxwidth,430);
	SetMessageCommand=function(self,params)
	local BannerTitle = params.Text;
	local songs = SONGMAN:GetSongsInGroup( BannerTitle )
	local TotalNewVal = 0
	for i=1,#songs do
		if not PROFILEMAN:IsSongNew(songs[i]) then
			TotalNewVal = TotalNewVal + 1
		end
	end
	self:settext( TotalNewVal.."/"..#songs.." played (".. FormatPercentScore( (TotalNewVal/#songs) ) ..")" )
	CalculatedAmmountCollapsed = true
	end;
};

end


return t;