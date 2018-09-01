local t = Def.ActorFrame{};

	t[#t+1] = Def.ActorFrame{

		LoadActor("SelectMusic/WheelHighlight")..{
		InitCommand=cmd(horizalign,left;zoom,0.5;shadowlength,3);
		SetMessageCommand=function(self,params)
		local steps = GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() )
		self:diffusebottomedge(Color.White)
		self:diffusetopedge(Color.White)
		self:diffuse(Color.White)
		if steps then
			self:diffuse( CustomDifficultyToColor( steps:GetDifficulty() ) )
		end
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
		local steps = GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() )
		self:diffusebottomedge(Color.White)
		self:diffusetopedge(Color.White)
		self:diffuse(Color.White)
		if steps then
			self:diffuse( CustomDifficultyToColor( steps:GetDifficulty() ) )
		end
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
		self:settext("")
		local BannerTitle = params.Text;
			if BannerTitle then
				self:settext( BannerTitle );
			end;
		end;
		};

		LoadFont("renner/20px") ..{
		Text="This is test";
		OnCommand=cmd(x,500;y,14;horizalign,right;shadowlength,1;zoom,0.8;strokecolor,Color.Black;maxwidth,430);
		SetMessageCommand=function(self,params)
		local BannerTitle = params.Text;
		self:settext("")
		local songs = SONGMAN:GetSongsInGroup( BannerTitle )
		local TotalNewVal = 0
		for i=1,#songs do
			local function TotalNew()
				if not PROFILEMAN:IsSongNew(songs[i]) then
					TotalNewVal = TotalNewVal + 1
				end
				if TotalNewVal > #songs then
					TotalNewVal = #songs
				end
				return TotalNewVal
			end
			local function PercetageTotal()
				return FormatPercentScore( (TotalNewVal/#songs) )
			end
			self:settext( TotalNew().."/"..#songs.." played (".. PercetageTotal() ..")" )
		end
		end;
		};

	};


return t;