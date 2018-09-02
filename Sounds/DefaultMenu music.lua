local WhatToPlay = THEME:GetPathS("","Menu music (loop).ogg")
if not DIVA_RandomSong then
	if DIVA:AbleToPlayRandomSongs() and ThemePrefs.Get("EnableRandomSongPlay") then
		DIVA_RandomSong = SONGMAN:GetRandomSong()
	end
end

if DIVA:AbleToPlayRandomSongs() and ThemePrefs.Get("EnableRandomSongPlay") then
	WhatToPlay = DIVA_RandomSong:GetMusicPath()
end

return WhatToPlay