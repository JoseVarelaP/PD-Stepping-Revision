local t = Def.ActorFrame {};

local DebugMode = false;

local ItemsToTweenColor = {
	-- Name, Color 1, Color 2

	-- Choices that show up when enabling stuff, but send to new menus, will appear green.
	{"Dedicated Character Settings", color("1,1,0,1"), color("0.8,0.8,0,0.5")},

	-- Choices that show up when enabling stuff, will appear purple.
	{"ModelsInRoom", color("0.8,0,0.8,1"), color("0.7,0,0.7,0.5")},
	{"FolderToPlayRandomMusic", color("0.8,0,0.8,1"), color("0.7,0,0.7,0.5")},
	{"ShowRandomSongBackground", color("0.8,0,0.8,1"), color("0.7,0,0.7,0.5")},
	{"CurrentStageLighting", color("0.8,0,0.8,1"), color("0.7,0,0.7,0.5")},

	{"DediModelBPM", color("0.8,0,0.8,1"), color("0.7,0,0.7,0.5")},
	{"DediSongData", color("0.8,0,0.8,1"), color("0.7,0,0.7,0.5")},
	{"DediMeasureCamera", color("0.8,0,0.8,1"), color("0.7,0,0.7,0.5")},

	-- Other menu options
	{"Theme Options", Color.HoloDarkPurple, Color.HoloPurple},
};

local UnlockableOptions = {
	"Dedicated Character Settings",
	"ModelsInRoom",
	"FolderToPlayRandomMusic",
	"ShowRandomSongBackground",
	"CurrentStageLighting",
};

local AbleToSwitch = {
	"ScreenOptionsTheme",
	"ScreenDediCharsSettings",
};

local LabelsToShrink = {
	"FolderToPlayRandomMusic",
	"Theme",
	"DefaultNoteSkin",
	"ShowDancingCharacters",
	"BackgroundFitMode",
};

local CanChangeIcon = {
	"CurrentStageLocation",
	"DedicatedCharacterShow",
	"EnableRandomSongPlay",
	"FolderToPlayRandomMusic",
};

if THEME:GetCurLanguage() == "es" then
	table.insert(LabelsToShrink, "ShowRandomSongBackground")
end

local gc = Var("GameCommand");

t[#t+1] = LoadActor("MenuScrollers/SettingBase")..{
	OnCommand=cmd(horizalign,left;zoom,0.4;shadowlengthy,2);
};

t[#t+1] = LoadActor("MenuScrollers/Bright")..{
	OnCommand=cmd(horizalign,left;zoom,0.4);
	GainFocusCommand=function(self)
	local optrow = self:GetParent():GetParent():GetParent()
	self:stoptweening():diffuseshift():diffusealpha(1):effectcolor1(1,1,1,1):effectcolor2(0.8,0.8,0.8,0.5)
	for i=1,#ItemsToTweenColor do
		if optrow:GetName() == ItemsToTweenColor[i][1] then
			self:Load(THEME:GetPathG("","MenuScrollers/DiffuseBright"))
			self:stoptweening():diffuseshift():diffusealpha(1):effectcolor1(ItemsToTweenColor[i][2]):effectcolor2(ItemsToTweenColor[i][3])
		end
	end
	end,
	LoseFocusCommand=cmd(stoptweening;linear,0.1;diffusealpha,0);
};

t[#t+1] = LoadFont("Common Normal")..{
	OnCommand=function(self)
	(cmd(horizalign,left;x,40;maxwidth,220;y,-2;shadowlengthy,3;shadowcolor,color("0,0,0,0.3");diffuse,0,0,0,1))(self);
	local optrow = self:GetParent():GetParent():GetParent()

	self:settext(THEME:GetString("OptionTitles",optrow:GetName()) ):horizalign(left)

	end,
};


t[#t+1] = LoadActor("MenuScrollers/ChoiceBackLabel")..{
	InitCommand=cmd(horizalign,left;zoom,0.4);
	OnCommand=function(self)
	self:visible(false)
	self:queuecommand("CheckForAnything")
	end,
	CheckForAnythingCommand=function(self)
	local optrow = self:GetParent():GetParent():GetParent()
	
	if optrow:GetNumChoices() > 1 then
		self:visible(true)
	end
	
	end,
};

t.GainFocusCommand=function(self)
end;
t.LoseFocusCommand=function(self)
end;

return t;