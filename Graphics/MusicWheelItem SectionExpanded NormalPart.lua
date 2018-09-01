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

	};

if ThemePrefs.Get("ShowPlayedSongsInFolder") then

t[#t+1] = LoadFont("renner/20px") ..{
	Text="yes";
	InitCommand=cmd(x,500;y,14;horizalign,right;shadowlength,1;zoom,0.8;strokecolor,Color.Black;maxwidth,430);
	SetMessageCommand=function(self,params)
	-- We're picking up the text for the songs via ScreenSelectMusic.
	-- check ScreenSelectMusic overlay to see the table.
	local new_text = SongGroups[params.Text][1].."/"..SongGroups[params.Text][2]
	if self:GetText() ~= new_text then
		self:settext( new_text )
	end
	end;
};

end

return t;