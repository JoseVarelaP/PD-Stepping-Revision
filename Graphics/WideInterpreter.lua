-- Jose's Wider interpreter
-- The purpose of this file is to recreate the way
-- ITGPC made Sprites appear wide with many textures, which use sprite manipulation in order to save space. 

local args = ...
assert( args.File, "No file was found." )
local File = args.File
local Width = args.Width or 0
local Height = args.Height or 0

-- set all sprites to be paused.
local Spr = LoadActor(THEME:GetPathG('',''..File))..{ InitCommand=function(self) self:animate(false) end };

return Def.ActorFrame{
	-- Top
    Spr..{ OnCommand=function(self) self:setstate(0):y(-Height/2-14):align(1,0):x(-Width/2) end },    
    Spr..{ OnCommand=function(self) self:setstate(1):y(-Height/2-14):align(0.5,0):zoomtowidth(Width) end },    
    Spr..{ OnCommand=function(self) self:setstate(2):y(-Height/2-14):align(0,0):x(Width/2) end },
    -- Middle
    
    Spr..{ OnCommand=function(self) self:setstate(3):zoomtoheight(Height):halign(1):x(-Width/2) end },    
    Spr..{ OnCommand=function(self) self:setstate(4):zoomtoheight(Height):zoomtowidth(Width) end },    
    Spr..{ OnCommand=function(self) self:setstate(5):zoomtoheight(Height):halign(0):x(Width/2) end },
    -- Bottom
    
    Spr..{ OnCommand=function(self) self:setstate(6):y(Height/2+14):align(1,1):x(-Width/2) end },    
    Spr..{ OnCommand=function(self) self:setstate(7):y(Height/2+14):align(0.5,1):zoomtowidth(Width) end },    
	Spr..{ OnCommand=function(self) self:setstate(8):y(Height/2+14):align(0,1):x(Width/2) end },

}