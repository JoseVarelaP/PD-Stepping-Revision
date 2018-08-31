local t = Def.ActorFrame{};
local gc = Var("GameCommand");

	t[#t+1] = Def.ActorFrame{

		LoadActor("SelectMusic/WheelHighlight")..{
		InitCommand=cmd(horizalign,left;zoom,0.5;shadowlength,3);
		SetMessageCommand=function(self,params)
		local steps = GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() )
		if steps then
			self:diffuse( CustomDifficultyToColor( steps:GetDifficulty() ) )
		end
		end,
		};

		LoadActor("SelectMusic/Base_WheelSong")..{
		OnCommand=cmd(horizalign,left;zoom,0.5);
		};

		LoadActor("SelectMusic/Color_WheelSong")..{
		OnCommand=cmd(horizalign,left;zoom,0.5);
		SetMessageCommand=function(self,params)
		local steps = GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() )
		if steps then
			self:diffuse( CustomDifficultyToColor( steps:GetDifficulty() ) )
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


return t;