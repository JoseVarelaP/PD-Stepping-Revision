-- Main menu replacement

--[[
    The original main menu (ScreenTitleMenu) is honestly a mess, and can be improved by
    creating a lua variant that allows for all kinds of customization options.
]]

-- Quick function to make NextScreen shorter
local function NScreen(screenname)
    return SCREENMAN:GetTopScreen():SetNextScreenName( screenname ):StartTransitioningScreen("SM_GoToNextScreen")
end

-- Begin by the actorframe
local t = Def.ActorFrame{};
local MenuIndex = 1;

local MenuChoices = {
    {
        "Game Start",
        function(event)
            GAMESTATE:JoinPlayer(event)
            NScreen( "ScreenSelectStyle" )
        end,
        "Desc"
    },
    {
        "QuickPlay",
        function(event)
            GAMESTATE:JoinPlayer(event)
            GAMESTATE:SetCurrentStyle("single")
            NScreen( "ScreenSelectMusic" )
        end,
        "Desc"
    },
    {
        "Options",
        function() NScreen( "ScreenOptionsService" ) end,
        "Desc"
    },
    {
        "DivaRoom",
        function(event)
            GAMESTATE:JoinPlayer(event)
            NScreen( "DivaRoom_SelectCharacter" )
        end,
        "Desc"
    },
    {
        "Exit",
        function() NScreen( "ScreenExit" ) end,
        "Desc"
    },
};

local BTInput = {
    -- This will control the menu
    ["MenuDown"] = function() MenuIndex = MenuIndex + 1 end,
    ["MenuUp"] = function() MenuIndex = MenuIndex - 1 end,
    ["Start"] = function(event)
        MenuChoices[MenuIndex][2](event)
    end
};

local function CheckValueOffsets()
    if MenuIndex > #MenuChoices then MenuIndex = #MenuChoices return end
    if MenuIndex < 1 then MenuIndex = 1 return end
    MESSAGEMAN:Broadcast("MenuUpAllVal")
end

-- Actorframe that holds the items that the ActorScroller will handle.
local function MainMenuChoices()
    local t=Def.ActorFrame{};

    for index,mch in ipairs( MenuChoices ) do
        t[#t+1] = Def.ActorFrame{
            OnCommand=function(self)
                self:xy( 15*index, SCREEN_CENTER_Y-180+(60*index) ):zoom(0.3)
                :addx( -SCREEN_WIDTH ):decelerate(0.5):addx( SCREEN_WIDTH )
            end;
            Def.Sprite{
                Texture=THEME:GetPathG("","MenuScrollers/Base");
                OnCommand=function(self) self:halign(0) end;
            };
            Def.Sprite{
                Texture=THEME:GetPathG("","MenuScrollers/Bright");
                OnCommand=function(self) self:halign(0) end;
                MenuUpAllValMessageCommand=function(self)
                    self:stopeffect()
                    self:diffuseshift( MenuIndex == index and true or false )
                    :effectcolor1(Color.White):effectcolor2(0,0,0,0)
                    self:diffusealpha( MenuIndex == index and 1 or 0 )
                end;
            };
            Def.BitmapText{
                Font="handel gothic/20px",
                Text=THEME:GetString("ScreenTitleMenu",mch[1]);
                OnCommand=function(self)
                    self:halign(0):diffuse( Color.Black )
                    :x(300):zoom(2.5)
                end;
                MenuUpAllValMessageCommand=function(self)
                    self:stoptweening()
                    if MenuIndex == index then
                        self:decelerate(0.4)
                    end
                    self:x( MenuIndex == index and 350 or 300)
                end;
            };
        };
    end
        
    return t;
end

local function InputHandler(event)
    -- Safe check to input nothing if any value happens to be not a player.
    -- ( AI, or engine input )
    if not event.PlayerNumber then return end

    -- Input that occurs at the moment the button is pressed.
    if ToEnumShortString(event.type) == "FirstPress" then
        if BTInput[event.GameButton] then BTInput[event.GameButton](event.PlayerNumber) end
    end

    -- Input that loops if the same button that was pressed is still held.
    -- Usually I have to loop the same commands from FirstPress to do this
    -- and honestly it's messy.
    if ToEnumShortString(event.type) == "Repeat" then
        if BTInput[event.GameButton] then BTInput[event.GameButton](event.PlayerNumber) end
    end
    CheckValueOffsets()
end

local Controller = Def.ActorFrame{
    OnCommand=function(self)
    for player in ivalues(PlayerNumber) do
        GAMESTATE:UnjoinPlayer(player)
    end
    MESSAGEMAN:Broadcast("MenuUpAllVal")
	SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end;
};

local Scroller = Def.ActorFrame{
    OnCommand=function(self)
        Scroller = self;
    end
};

t[#t+1] = MainMenuChoices()

t[#t+1] = Controller;
t[#t+1] = Scroller;

return t;
