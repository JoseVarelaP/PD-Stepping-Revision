return Def.ActorFrame{
	LoadActor("Base")..{ OnCommand=cmd(shadowlengthy,3); };
	LoadFont("Common Normal")..{ Text=string.upper(THEME:GetString("OptionTitles","Sort")), OnCommand=cmd(diffuse,color("#CA11C2");y,-14;zoom,0.6); };
	LoadFont("Common Normal")..{
	OnCommand=cmd(y,12);
	CurrentSongChangedMessageCommand=function(self)
	self:settext( string.upper(THEME:GetString("SortOrder", ToEnumShortString( GAMESTATE:GetSortOrder() ) ) ) )
	end,
	};
}