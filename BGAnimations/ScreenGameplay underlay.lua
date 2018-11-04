local t = Def.ActorFrame{
	OnCommand=function(self)
	if ThemePrefs.Get("DedicatedCharacterShow") and DIVA:AnyoneHasChar() then
		if SCREENMAN:GetTopScreen():GetChild("SongBackground") then
			SCREENMAN:GetTopScreen():GetChild("SongBackground"):visible(false)
		end
	end
	end,
};

return t;