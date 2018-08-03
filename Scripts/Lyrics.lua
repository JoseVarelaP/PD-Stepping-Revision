function Actor:LyricCommand(side)
	self:settext( Var "LyricText" )
	self:draworder(102)

	self:stoptweening()
	self:shadowlengthx(0)
	self:shadowlengthy(0)
	self:strokecolor(color("#000000"))

	local Zoom = SCREEN_WIDTH / (self:GetZoomedWidth()+1)
	if( Zoom > 1 ) then
		Zoom = 1
	end
	self:zoomx( Zoom )

	local lyricColor = Var "LyricColor"
	self:diffuse( { lyricColor[1],lyricColor[2],lyricColor[3],lyricColor[4] } )

	self:x(-10)
	self:cropright(0)
	self:cropleft(0)
	self:diffusealpha(0)
	self:linear( Var "LyricDuration" * 0.1 )
	self:diffusealpha(1)
	self:x(0)
	self:sleep( Var "LyricDuration" * 0.8 )
	self:linear( Var "LyricDuration" * 0.1 )
	self:x(-10)
	self:diffusealpha(0)
	return self
end