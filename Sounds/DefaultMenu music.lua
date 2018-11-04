local WhatToPlay = THEME:GetPathS("","Menu music (loop).ogg")

if THEME:GetCurThemeName() == "PD-Stepping-Revision" then
	if not getenv("DIVA_RandomSong") then
		DIVA:ResetRandomSong()
	end

	if ThemePrefs.Get("EnableRandomSongPlay") and getenv("DIVA_RandomSong") then
		WhatToPlay = getenv("DIVA_RandomSong"):GetMusicPath()
	end
end	

return WhatToPlay