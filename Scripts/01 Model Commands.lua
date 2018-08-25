function Diva_GetPathLocation(filepart1,filepart2)
	return "/"..THEME:GetCurrentThemeDirectory().."/Locations/"..filepart1 .. filepart2
end

function Diva_ResetRandomSong()
	if DIVA_RandomSong then
    	if ThemePrefs.Get("EnableRandomSongPlay") then
			if ThemePrefs.Get("FolderToPlayRandomMusic") ~= "All" then
				local Sel = SONGMAN:GetSongsInGroup(ThemePrefs.Get("FolderToPlayRandomMusic"))
				DIVA_RandomSong = Sel[math.random(1,#Sel)]
			else
				DIVA_RandomSong = SONGMAN:GetRandomSong()
			end
		end
    end
end