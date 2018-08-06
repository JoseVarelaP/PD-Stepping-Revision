-- This will control the lyrics that show up in gameplay.

-- You might have noticed this "Side" on the function.
-- This is because when playing a lyric file, you might notice how it's able
-- to lightup text as it goes on. This is how it's done. By using 2 sides,
-- the Back and the Front, the front being the lighter variant that will show up.
-- But for the theme, we don't need that.

function Actor:LyricCommand(side)
	-- Let's obtain what data is being played right now..
	self:settext( Var "LyricText" )
	-- And now set that above the overlay.
	self:draworder(102)

	-- Once we do that, we need to stop tweening on whatever
	-- text was previously loaded, to avoid delays.
	self:stoptweening()

	-- Let's now check the zoom of the text.
	-- This is to prevent the text from clipping out of the screen area.
	local Zoom = SCREEN_WIDTH / (self:GetZoomedWidth()+1)
	if( Zoom > 1 ) then
		Zoom = 1
	end
	self:zoomx( Zoom )

	-- Lyric colors come on this format.
	-- [Colour]0x######
	local lyricColor = Var "LyricColor"
	-- Let's the color (if there's any) and apply it to the layer!
	self:diffuse( { lyricColor[1],lyricColor[2],lyricColor[3],lyricColor[4] } )
	-- Same with the Border color, but darker so it doesn't end up looking like
	-- a mess or something like that. So let's divide whatever it got by 4.
	self:strokecolor( { lyricColor[1]/4,lyricColor[2]/4,lyricColor[3]/4,lyricColor[4] } )

	-- And here goes your standard animation to play the string.
	self:x(-10)
	self:cropright(0)
	self:cropleft(0)
	self:diffusealpha(0)
	-- LyricDuration will depend on the length between the current
	-- lyric segment being played and the next one, so keep that in mind.
	self:linear( Var "LyricDuration" * 0.1 )
	self:diffusealpha(1)
	self:x(0)
	self:sleep( Var "LyricDuration" * 0.8 )
	self:linear( Var "LyricDuration" * 0.1 )
	self:x(-10)
	self:diffusealpha(0)
	return self
end