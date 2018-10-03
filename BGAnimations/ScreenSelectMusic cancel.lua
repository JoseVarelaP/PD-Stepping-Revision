return Def.ActorFrame{
	OnCommand=function(self)
		self:queuemessage("Cancel"):sleep(1)
	end
}