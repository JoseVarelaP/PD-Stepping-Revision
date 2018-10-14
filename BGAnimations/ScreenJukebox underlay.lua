local t = Def.ActorFrame{
	OnCommand=function(self)
	if ThemePrefs.Get("DedicatedCharacterShow") and (DIVA:HasAnyCharacters(PLAYER_1) or DIVA:HasAnyCharacters(PLAYER_2)) then
		if SCREENMAN:GetTopScreen():GetChild("SongBackground") then
			SCREENMAN:GetTopScreen():GetChild("SongBackground"):visible(false)
		end
	end
	end,
};

return t;