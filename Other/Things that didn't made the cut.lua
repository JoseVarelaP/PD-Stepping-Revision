-- Things that didn't made the cut

-- Display updater
--[[
t[#t+1] = Def.Quad{
	InitCommand=function(self)
	self:queuecommand("Loop")
	end,
	LoopCommand=function(self)
	if not DWidth then DWidth = DISPLAY:GetDisplayWidth() end
	if not DHeight then DHeight = DISPLAY:GetDisplayHeight() end
	if DWidth ~= DISPLAY:GetDisplayWidth() or DHeight ~= DISPLAY:GetDisplayHeight() then
		-- PREFSMAN:SetPreference("DisplayWidth", DWidth)
		-- PREFSMAN:SetPreference("DisplayHeight", DHeight)
		DWidth = DISPLAY:GetDisplayWidth()
		DHeight = DISPLAY:GetDisplayHeight()
		THEME:ReloadMetrics()
		SCREENMAN:ReloadOverlayScreens()
		SCREENMAN:SystemMessage( DWidth .." / ".. DHeight )
		MESSAGEMAN:Broadcast("UpdateActorPosition")
	end

	--SCREENMAN:SystemMessage( DWidth .." / ".. DHeight )
	self:sleep(1/10)
	self:queuecommand("Loop")
	end,	
};
--]]

--[[
local TimesPaused = 0

local t = Def.ActorFrame{
	OnCommand=cmd(queuecommand,"Update");
	UpdateCommand=function(self)
	self:finishtweening()
	if HOOKS:AppHasFocus() then
		SCREENMAN:GetTopScreen():PauseGame(false)
		self:sleep(1/10)
		self:queuecommand("Update")
	else
		SCREENMAN:GetTopScreen():PauseGame(true)
		TimesPaused = TimesPaused + 1
		self:queuecommand("WaitUntilUnPause")
		lua.ReportScriptError("Times paused: "..TimesPaused)
	end
	end,
	WaitUntilUnPauseCommand=function(self)
	self:finishtweening()
	if HOOKS:AppHasFocus() then
		SCREENMAN:GetTopScreen():PauseGame(false)
		self:sleep(1/10)
		self:queuecommand("Update")
	else
		SCREENMAN:GetTopScreen():PauseGame(true)
	end
	self:sleep(1/10)
	self:queuecommand("WaitUntilUnPause")
	end,
};
--]]