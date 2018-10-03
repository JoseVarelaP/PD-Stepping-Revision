return Def.ActorFrame{
	
	LoadActor("Base")..{
		 OnCommand=function(self)
			self:shadowlengthy(3)
		end
	};
	
	LoadFont("Common Normal")..{
		 Text=string.upper(THEME:GetString("OptionTitles","Sort")), OnCommand=function(self)
			self:diffuse(color("#CA11C2")):y(-14):zoom(0.6)
		end
	};
	LoadFont("Common Normal")..{
	OnCommand=function(self)
		self:y(12)
	end;
	CurrentSongChangedMessageCommand=function(self)
	self:settext( string.upper(THEME:GetString("SortOrder", ToEnumShortString( GAMESTATE:GetSortOrder() ) ) ) )
	end,
	};
}