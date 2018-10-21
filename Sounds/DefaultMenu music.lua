local WhatToPlay = THEME:GetPathS("","Menu music (loop).ogg")

if not getenv("DIVA_RandomSong") then
	DIVA:ResetRandomSong()
end

if getenv("DIVA_RandomSong") and ThemePrefs.Get("EnableRandomSongPlay") then
	WhatToPlay = getenv("DIVA_RandomSong"):GetMusicPath()
end

return WhatToPlay