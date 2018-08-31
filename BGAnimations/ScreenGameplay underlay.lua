local function HasAnyCharacters(pn)
	return GAMESTATE:IsPlayerEnabled(pn) and GAMESTATE:GetCharacter(pn):GetDisplayName() ~= "default" and DIVA:IsSafeToLoad(pn)
end

local t = Def.ActorFrame{
	OnCommand=function(self)
	if ThemePrefs.Get("DedicatedCharacterShow") and (HasAnyCharacters(PLAYER_1) or HasAnyCharacters(PLAYER_2)) then
		if SCREENMAN:GetTopScreen():GetChild("SongBackground") then
			SCREENMAN:GetTopScreen():GetChild("SongBackground"):visible(false)
		end
	end
	end,
};

return t;