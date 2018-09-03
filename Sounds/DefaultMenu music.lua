local WhatToPlay = THEME:GetPathS("","Menu music (loop).ogg")
if not DIVA_RandomSong then
	if #SONGMAN:GetAllSongs() > 0 and ThemePrefs.Get("EnableRandomSongPlay") then
		DIVA_RandomSong = SONGMAN:GetRandomSong()
	end
end

if #SONGMAN:GetAllSongs() > 0 and ThemePrefs.Get("EnableRandomSongPlay") then
	WhatToPlay = DIVA_RandomSong:GetMusicPath()
end

return WhatToPlay