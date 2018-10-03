-- Jose's Wider interpreter
-- The purpose of this file is to recreate the way
-- ITGPC made Sprites appear wide with many textures, which use sprite manipulation in order to save space. 

local args = ...
local File = args.File
local Width = args.Width
local Height = args.Height

return Def.ActorFrame{
    -- Top
    
    LoadActor(THEME:GetPathG('',''..File))..{
    	 InitCommand=function(self)
    		self:y(-Height/2-14):vertalign(top):setstate(0):pause():horizalign(right):x(-Width/2)
    	end
    },
    
    LoadActor(THEME:GetPathG('',''..File))..{
    	 InitCommand=function(self)
    		self:y(-Height/2-14):vertalign(top):setstate(1):pause():zoomtowidth(Width)
    	end
    },
    
    LoadActor(THEME:GetPathG('',''..File))..{
    	 InitCommand=function(self)
    		self:y(-Height/2-14):vertalign(top):setstate(2):pause():horizalign(left):x(Width/2)
    	end
    },

    -- Middle
    
    LoadActor(THEME:GetPathG('',''..File))..{
    	 InitCommand=function(self)
    		self:zoomtoheight(Height):setstate(3):pause():horizalign(right):x(-Width/2)
    	end
    },
    
    LoadActor(THEME:GetPathG('',''..File))..{
    	 InitCommand=function(self)
    		self:zoomtoheight(Height):setstate(4):pause():zoomtowidth(Width)
    	end
    },
    
    LoadActor(THEME:GetPathG('',''..File))..{
    	 InitCommand=function(self)
    		self:zoomtoheight(Height):setstate(5):pause():horizalign(left):x(Width/2)
    	end
    },

    -- Bottom
    
    LoadActor(THEME:GetPathG('',''..File))..{
    	 InitCommand=function(self)
    		self:y(Height/2+14):vertalign(bottom):setstate(6):pause():horizalign(right):x(-Width/2)
    	end
    },
    
    LoadActor(THEME:GetPathG('',''..File))..{
    	 InitCommand=function(self)
    		self:y(Height/2+14):vertalign(bottom):setstate(7):pause():zoomtowidth(Width)
    	end
    },
    
    LoadActor(THEME:GetPathG('',''..File))..{
    	 InitCommand=function(self)
    		self:y(Height/2+14):vertalign(bottom):setstate(8):pause():horizalign(left):x(Width/2)
    	end
    },
}