local revert_sync_changes= THEME:GetString("ScreenSyncOverlay", "revert_sync_changes")
local change_bpm= THEME:GetString("ScreenSyncOverlay", "change_bpm")
local change_song_offset= THEME:GetString("ScreenSyncOverlay", "change_song_offset")
local change_machine_offset= THEME:GetString("ScreenSyncOverlay", "change_machine_offset")
local hold_alt= THEME:GetString("ScreenSyncOverlay", "hold_alt")

local text= {
	{SCREEN_WIDTH/9.8 ,revert_sync_changes.."\nF4"},
	{SCREEN_WIDTH/4.05 ,change_bpm.."\nF9/F10"},
	{SCREEN_WIDTH/2.35 ,change_song_offset.."\nF11/F12"},
	{SCREEN_WIDTH/1.56 ,change_machine_offset.."\nShift + F11/F12"},
	{SCREEN_WIDTH/1.17 ,hold_alt},
};

local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	LoadActor( THEME:GetPathG("","WideInterpreter"), { File="Global/TextBox", Width=SCREEN_WIDTH/1.2, Height=40 } )..{
		InitCommand=function(self)
			self:diffusealpha(0):Center():y(SCREEN_BOTTOM-40):zoom(0)
		end;
		ShowCommand= function(self)
			self:stoptweening():decelerate(.2):zoom(1):diffusealpha(1)
				:sleep(4):accelerate(.2):diffusealpha(0)
				:zoom(0.8)
		end,
		HideCommand= function(self)
			self:finishtweening()
		end,
	};
	Def.BitmapText{
		Name= "Status", Font= "ScreenSyncOverlay status",
		InitCommand= function(self)
			ActorUtil.LoadAllCommands(self, "ScreenSyncOverlay")
			self:playcommand("On"):vertalign(bottom)
		end,
		SetStatusCommand= function(self, param)
			self:settext(param.text):zoom(0.8)
		end,
	},
	Def.BitmapText{
		Name= "Adjustments", Font= "ScreenSyncOverlay adjustments",
		InitCommand= function(self)
			ActorUtil.LoadAllCommands(self, "ScreenSyncOverlay")
			self:playcommand("On")
		end,
		SetAdjustmentsCommand= function(self, param)
			self:visible(param.visible):settext(param.text)
		end,
	},
};

for i=1,#text do
	t[#t+1] = Def.BitmapText{
		Name= "help_text", Font= "Common Normal", InitCommand= function(self)
			self:diffuse(1, 1, 1, 0):strokecolor(Color.Black)
				:shadowlengthy(2):settext(text[i][2])
				:wrapwidthpixels(WideScale(200,350))
				:xy(text[i][1], SCREEN_BOTTOM-42):zoom(0.48)
		end,
		ShowCommand= function(self)
			self:settext(text[i][2]):stoptweening():linear(.3):diffusealpha(1)
				:sleep(3.6):linear(.3):diffusealpha(0)
		end,
		HideCommand= function(self)
			self:finishtweening()
		end,
	};
end

return t;
