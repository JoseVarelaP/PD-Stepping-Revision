-- Diva Rooom - CharacterSelection
-- Load the characters, put them in a table so we can select.
-- Allowed input on screen
local MenuIndex = 1

local ChoicesList = {
    { function() SCREENMAN:AddNewScreenToTop("DivaRoom overlay/CharChooser", "SM_GoToNextScreen") end,"Character Chooser" },
    { function() SCREENMAN:AddNewScreenToTop("DivaRoom overlay/LocaChooser", "SM_GoToNextScreen") end,"Switch Location" },
    { function()
        GAMESTATE:SetCharacter(PLAYER_1, getenv("DivaRoom_CharLoad"):GetCharacterID())
        ThemePrefs.Set("CurrentStageLocation", getenv("DivaRoom_LocaLoad") )
        setenv( "DivaRoomNextScreen", "ScreenSelectMusic" )
        SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
    end,"Use as Gameplay Character\n(This will start the game as player 1!)" },
};

local BTInput = {
    ["MenuUp"] = function() MenuIndex = MenuIndex - 1 end,
    ["MenuDown"] = function() MenuIndex = MenuIndex + 1 end,
    ["Back"] = function()
        SCREENMAN:GetTopScreen():SetPrevScreenName("DivaRoom"):Cancel()
        return
    end,
    ["Start"] = function()
        ChoicesList[MenuIndex][1]()
    end,
};

-- Begin by setting up a ActorFrame which will handle everything.
-- And also the subsequent ones that will be filled up later.
local AllObjects = Def.ActorFrame{};
local UI = Def.ActorFrame{};

local function CheckValueOffsets()
    if MenuIndex > #ChoicesList then MenuIndex = 1 end
    if MenuIndex < 1 then MenuIndex = #ChoicesList end
end;

-- Input handler, manages all the Input data that will be recieved by the player.
local function InputHandler(event)
    -- Safe check to input nothing if any value happens to be not a player.
    -- ( AI, or engine input )
    if not event.PlayerNumber then return end

    -- Input that occurs at the moment the button is pressed.
    if ToEnumShortString(event.type) == "FirstPress" then
        if BTInput[event.GameButton] then BTInput[event.GameButton]() end
    end

    -- Input that loops if the same button that was pressed is still held.
    -- Usually I have to loop the same commands from FirstPress to do this
    -- and honestly it's messy.
    if ToEnumShortString(event.type) == "Repeat" then
        if BTInput[event.GameButton] then BTInput[event.GameButton]() end
    end
    CheckValueOffsets()
    MESSAGEMAN:Broadcast("UpAllVal")
    if CHList and CHList:GetChild("MenuScroller") then
        CHList:GetChild("MenuScroller"):SetDestinationItem( MenuIndex-1 );
    end
end

local Controller = Def.ActorFrame{
	OnCommand=function(self) MESSAGEMAN:Broadcast("UpAllVal")
	SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end;
};

-- Add Controller to the input
AllObjects[#AllObjects+1] = Controller;

CHList = Def.ActorFrame{
    OnCommand=function(self)
        self:Center();
        CHList = self;
    end;
};

local ItSp = 70;

local function LoadCharacterList()
    local t = Def.ActorFrame{};
    for index,cval in ipairs(ChoicesList) do
        local Result = Def.ActorFrame{
            Def.BitmapText{ Font="renner/20px",
                OnCommand=function(self)
                    self:strokecolor( Color.Black )
                    :halign(0):xy(-150,-10):zoom(0.8)
                    :settext( cval[2] )
                end;
            };
        };
        t[#t+1] = Result
    end
    return t;
end;

CHList[#CHList+1] = Def.Quad{
    OnCommand=function(self)
        self:zoomto(SCREEN_WIDTH,500):fadetop(0.2):fadebottom(0.2):diffuse(Color.Black):diffusealpha(0.7)
    end;
};

CHList[#CHList+1] = Def.ActorScroller{
    Name = 'MenuScroller';
    NumItemsToDraw=7;
    OnCommand=function(self)
    self:y(7):SetFastCatchup(true):SetSecondsPerItem(0.3):SetWrap(false)
    self:addx(-SCREEN_WIDTH):decelerate(0.3):addx(SCREEN_WIDTH)
    end;
    TransformFunction=function(self, offset, itemIndex, numItems)
        self:visible(true);
        self:y(math.floor( offset*70 ))
        self:decelerate(0.2)
        :diffusealpha(
            (offset == 0 and 1) or 
            (offset < -1 or offset > 1) and 0.4 or 0.7
        )
        :x(
            (offset < -1 or offset > 1) and math.sqrt(900) or 1
        )
    end;
    children = LoadCharacterList();
};

-- Load the usual border
UI[#UI+1] = LoadActor("../Borders.lua");

AllObjects[#AllObjects+1] = CHList;
AllObjects[#AllObjects+1] = UI;

return AllObjects;