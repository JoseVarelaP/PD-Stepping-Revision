-- Diva Rooom - CharacterSelection
-- Load the characters, put them in a table so we can select.
local LocationsAvailable = LOADER:LoadStages()
for i=1,#LocationsAvailable do
	if LocationsAvailable[i] == "None" then
		table.remove( LocationsAvailable, i )
	end
end

local RoomSpots = DIVA.LoadSaveDir().."RoomLocations.ini"

-- Allowed input on screen
local BTInput = {
    ["MenuUp"] = function()
        setenv("CharSelIndex",getenv("CharSelIndex") - 1)
    end,
    ["MenuDown"] = function()
        setenv("CharSelIndex",getenv("CharSelIndex") + 1)
    end,
    ["Back"] = function()
        SCREENMAN:GetTopScreen():SetPrevScreenName("DivaRoom/MainMenu"):Cancel()
    end,
    ["Start"] = function()
        -- Set Location and Character based on selection
        setenv( "DivaRoom_LocaLoad", LocationsAvailable[getenv("CharSelIndex")] )
        Config.Save( getenv("DivaRoom_CharLoad"):GetDisplayName(), LocationsAvailable[getenv("CharSelIndex")], RoomSpots )

        -- After this is done, continue by going to the main Diva Room screen.
        SCREENMAN:GetTopScreen():SetNextScreenName("DivaRoom")
        :StartTransitioningScreen("SM_GoToNextScreen")
    end,
};

-- Begin by setting up a ActorFrame which will handle everything.
-- And also the subsequent ones that will be filled up later.
local AllObjects = Def.ActorFrame{};
local UI = Def.ActorFrame{};

local function CheckValueOffsets()
    if getenv("CharSelIndex") > #LocationsAvailable then setenv("CharSelIndex",1) end
    if getenv("CharSelIndex") < 1 then setenv("CharSelIndex",#LocationsAvailable) end
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
    MESSAGEMAN:Broadcast("LocUpAllVal")
    CHList:GetChild("CharacterScroller"):SetDestinationItem(getenv("CharSelIndex")-1);
end

local Controller = Def.ActorFrame{
	OnCommand=function(self) MESSAGEMAN:Broadcast("LocUpAllVal")
	SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end;
};

-- Add Controller to the input
AllObjects[#AllObjects+1] = Controller;

CHList = Def.ActorFrame{
    OnCommand=function(self)
        self:xy( SCREEN_CENTER_X,SCREEN_CENTER_Y )
        CHList = self;
    end;
};

local ItSp = 70;

local function LoadCharacterList()
    local t = Def.ActorFrame{};
    for index,cval in ipairs(LocationsAvailable) do
        local Result =  Def.ActorFrame{

            LoadActor( THEME:GetPathG("","MenuScrollers/SettingBase") )..{
                OnCommand=function(self)
                    self:zoom(0.35)
                end;
            };

            LoadActor( THEME:GetPathG("","MenuScrollers/SettingHighlight") )..{
                OnCommand=function(self)
                    self:zoom(0.35)
                end;
                LocUpAllValMessageCommand=function(self)
                    self:stopeffect():diffusealpha(0)
                    if index == getenv("CharSelIndex") then
                        self:diffuseshift():diffusealpha(1)
                        :effectcolor1(1,1,1,0):effectcolor2(Color.White)
                    end
                end;
            };

            Def.BitmapText{ Font="renner/20px",
                OnCommand=function(self)
                    self:strokecolor( Color.Black )
                    :halign(0):xy(-150,0):zoom(0.8)
                    :settext( cval )
                end;
            };

            Def.BitmapText{ Font="renner/20px",
            Text="Currently Selected",
                OnCommand=function(self)
                    self:strokecolor( Color.Black )
                    :halign(0):xy(80,-2):zoom(0.6)
                    :diffuse( Color.Green )
                    :visible( getenv("DivaRoom_LocaLoad") == cval )
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
    Name = 'CharacterScroller';
    NumItemsToDraw=7;
    OnCommand=function(self)
    self:y(7):SetFastCatchup(true):SetSecondsPerItem(0.1):SetWrap(false)
    :SetDestinationItem( getenv("CharSelIndex")-1 )
    self:addx(-SCREEN_WIDTH):decelerate(0.3):addx(SCREEN_WIDTH)
    end;
    TransformFunction=function(self, offset, itemIndex, numItems)
        self:visible(true);
        self:y(math.floor( offset*70 ))
        self:decelerate(0.2)
        self:zoom(
            (offset == 0 and 1.1) or 
            (offset < -1 or offset > 1) and 0.8 or 1
        )
        :diffusealpha(
            (offset == 0 and 1) or 
            (offset < -1 or offset > 1) and 0.4 or 0.7
        )
    end;
    children = LoadCharacterList();
};

-- Load the usual border
UI[#UI+1] = LoadActor("../Borders.lua");

AllObjects[#AllObjects+1] = CHList;
AllObjects[#AllObjects+1] = UI;

return AllObjects;