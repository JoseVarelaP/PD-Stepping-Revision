return Def.ActorFrame{
	LoadActor("Base")..{ OnCommand=cmd(shadowlengthy,3); };
	LoadFont("Common Normal")..{ Text=THEME:GetString("OptionTitles","Sort"), OnCommand=cmd(diffuse,color("#CA11C2");y,-14;zoom,0.8); };
	LoadFont("Common Normal")..{
	OnCommand=cmd(y,12);
	CurrentSongChangedMessageCommand=function(self)
	self:settext( THEME:GetString("SortOrder", ToEnumShortString( GAMESTATE:GetSortOrder() ) ) )
	end,
	};
}