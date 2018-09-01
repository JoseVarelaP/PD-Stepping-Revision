local WhatToPlay = THEME:GetPathS("","Menu music (loop).ogg")
if not DIVA_RandomSong then
	DIVA_RandomSong = SONGMAN:GetRandomSong()
end

if DIVA:AbleToPlayRandomSongs() then
	WhatToPlay = DIVA_RandomSong:GetMusicPath()
end

return WhatToPlay