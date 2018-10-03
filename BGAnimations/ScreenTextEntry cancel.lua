return Def.ActorFrame{
	OnCommand=function(self)
		self:queuemessage("Cancel"):sleep(0.4)
	end
}