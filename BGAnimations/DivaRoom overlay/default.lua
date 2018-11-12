-- Diva Rooom
-- Locals that define position around the play area
local Camera = {
    -- Movement
    x = 0, y = 10, z = WideScale(300,400),
    -- Rotation
    rotx = 0, roty = 180
};

local CameraPresets = {
    {x=0 ,y=10 ,z=0 ,rotx=0 ,roty=0},
    {x=10 ,y=15 ,z=-20 ,rotx=10 ,roty=20},
    {x=-30 ,y=15 ,z=-40 ,rotx=10 ,roty=-40},
    {x=30 ,y=15 ,z=-40 ,rotx=10 ,roty=40},
    {x=0 ,y=8 ,z=0 ,rotx=10 ,roty=140},
}

local CPr = 1;

local InputListing = {
    -- Global buttons that occur before going on a menu.
    ["MenuRight"]   = function() CPr = CPr + 1 end,   
    ["MenuLeft"]   = function() CPr = CPr - 1 end,   
};

local function CheckValues()
    if CPr < 1 then CPr = 1 end
    if CPr > #CameraPresets then CPr = #CameraPresets end
end

-- Begin by setting up a ActorFrame which will handle everything.
-- And also the subsequent ones that will be filled up later.
local AllObjects = Def.ActorFrame{};
local UI = Def.ActorFrame{};
local LocationSce = Def.ActorFrame{
    InitCommand=function(self)
        self:Center():fov(90):rotationy(180):z( WideScale(300,400) ):addy(10):spin():effectmagnitude(0,10,0)
    end;
    UpAllValMessageCommand=function(self)
        if getenv("DivaRoomNextScreen") == "ScreenSelectMusic" then
            GAMESTATE:UnjoinPlayer( PLAYER_2 )
            GAMESTATE:SetCurrentStyle("single")
            SCREENMAN:SetNewScreen( getenv("DivaRoomNextScreen") )
        end
        self:stoptweening():decelerate(0.3)
        if CameraPresets[CPr] then
            self:xyz(
                SCREEN_CENTER_X+(CameraPresets[CPr].x)*-1,
                SCREEN_CENTER_Y+CameraPresets[CPr].y,
                WideScale(300,400)+CameraPresets[CPr].z
            )
            :rotationx( CameraPresets[CPr].rotx )
            :rotationy( 180+CameraPresets[CPr].roty )
        end
    end;
};
local InputMode = "Global";

local StageToShow = ThemePrefs.Get("CurrentStageLocation")

-- Input handler, manages all the Input data that will be recieved by the player.
local function InputHandler(event)
    -- Safe check to input nothing if any value happens to be not a player.
    -- ( AI, or engine input )
    if not event.PlayerNumber then return end

    -- Input that occurs at the moment the button is pressed.
    if ToEnumShortString(event.type) == "FirstPress" then
        if event.GameButton == "Start" then
            -- Load the main menu if the button is pressed.
            SCREENMAN:GetTopScreen():SetNextScreenName( getenv("DivaRoomNextScreen") )
            SCREENMAN:AddNewScreenToTop("DivaRoom overlay/MainMenu", "SM_GoToNextScreen")
        end
        if event.GameButton == "Back" then
            SCREENMAN:GetTopScreen():SetPrevScreenName("ScreenTitleMenu"):Cancel()
        end
        if InputListing[event.GameButton] then
            InputListing[event.GameButton]()
            CheckValues()
            MESSAGEMAN:Broadcast("UpAllVal")
        end
    end
end

local Controller = Def.ActorFrame{
	OnCommand=function(self) MESSAGEMAN:Broadcast("UpAllVal")
	SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end;
};

local LoadedCharacter = getenv( "DivaRoom_CharLoad" )

-- Add Controller to the input
AllObjects[#AllObjects+1] = Controller;

local LocCfg = DIVA:GetPathLocation("", getenv("DivaRoom_LocaLoad").."/ModelConfig.cfg" )

local function Load_CharLoc_Material()
    local ToFind = "/main_material.txt"
    local ConfigFile = Config.Load("AbleToChangeLight", LocCfg )
    if tostring(ConfigFile) == "true" then
        ToFind = "/"..DEDICHAR:LightToLoad().."_material.txt"
	end
    return DIVA:GetPathLocation("",getenv("DivaRoom_LocaLoad")..ToFind);
end

-- Load stage into the 3D space.
if getenv("DivaRoom_LocaLoad") ~= "None" then
    LocationSce[#LocationSce+1] = Def.Model {
        Meshes=DIVA:GetPathLocation("",getenv("DivaRoom_LocaLoad").."/model.txt");
        Materials=Load_CharLoc_Material();
        Bones=DIVA:GetPathLocation("",getenv("DivaRoom_LocaLoad").."/model.txt");
        OnCommand=function(self)
            self:cullmode("CullMode_None")
            self:xy(
                Config.Load("StageXOffset", LocCfg, 0),
                Config.Load("StageYOffset", LocCfg, 0)
            )
            self:zoom(
                Config.Load("StageZoom", LocCfg, 1 )
            )
        end,
    };
end;

LocationSce[#LocationSce+1] = Def.Model {
    Meshes=LoadedCharacter:GetModelPath();
    Materials=LoadedCharacter:GetModelPath();
    Bones=LoadedCharacter:GetRestAnimationPath();
    OnCommand=function(self)
        self:cullmode("CullMode_None")

        if string.find(LoadedCharacter:GetDisplayName(), "Baby") then
            self:zoom(0.6)
        end;
    end,
};

UI[#UI+1] = LoadActor("../Borders.lua");

local function Hour12Set()
    local TimeSet = Hour();
    local TypeOfDay = "A.M.";
    if Hour() > 11 then TypeOfDay = "P.M."; end
    if Hour() > 12 then TimeSet = Hour()-12; end
    return {TimeSet, TypeOfDay}
end

local function StringMonth()
    -- Bring it one over from the original, because the function starts from 0
    return THEME:GetString("MonthOfYear",MonthOfYear()+1)
end

UI[#UI+1] = Def.ActorFrame{
    OnCommand=function(self)
        self:zoom(0.3):xy(0,60)
    end;
    LoadActor( THEME:GetPathG("","DivaRoom/DateInfo") )..{
        OnCommand=function(self) self:halign(0) end;
    };
    
    LoadActor( THEME:GetPathG("","DivaRoom/Mask_DateInfo") )..{
        OnCommand=function(self)
            self:halign(0):MaskSource():x(-1):cropright(0.76)
        end;
    };

    Def.Sprite{
        Texture=LoadedCharacter:GetCardPath();
        OnCommand=function(self)
            self:setsize(200,280):x(150):MaskDest():croptop(0.1):cropbottom(0.1)
        end;
    };
    
    Def.BitmapText{
        Font="Common Normal";
        OnCommand=function(self)
            self:halign(0):strokecolor(Color.Black):zoom(2.5)
            :x(280):y(-5)
            :queuecommand("UpdateString")
        end;
        UpdateStringCommand=function(self)
            local Time = string.format( "%02.0f:%02.0f:%02.0f",
                Hour(),Minute(),Second()
            )
            if ThemePrefs.Get("Enable12HourDivaRoom") then
                Time = string.format( "%02.0f:%02.0f:%02.0f %s",
                    Hour12Set()[1],Minute(),Second(),Hour12Set()[2]
                )
            end
            self:settext( Time )
            self:sleep(1):queuecommand("UpdateString")
        end;
    };

    Def.BitmapText{
        Font="Common Normal";
        OnCommand=function(self)
            self:halign(1):strokecolor(Color.Black):zoom(2.5)
            :x(1130):y(-5)
            :queuecommand("UpdateString")
        end;
        UpdateStringCommand=function(self)
            local Time = DayOfMonth().."/"..StringMonth().."/"..Year()
            self:settext( Time )
            self:sleep(1):queuecommand("UpdateString")
        end;
    };
};

UI[#UI+1] = Def.ActorFrame{
    OnCommand=function(self)
        self:xy(SCREEN_LEFT+20,SCREEN_BOTTOM-50)
    end;

    LoadActor( THEME:GetPathG("","DivaRoom/CameraView") )..{
        OnCommand=function(self)
            self:zoom(0.2):halign(0)
        end;
    };

    Def.BitmapText{
        Font="Common Normal",
        OnCommand=function(self)
            self:strokecolor(Color.Black):zoom(0.8):xy(21,6)
        end;
        UpAllValMessageCommand=function(self)
            self:settext( CPr )
        end;
    };
};

UI[#UI+1] = Def.Quad{
    OnCommand=function(self)
        self:FullScreen():diffuse(Color.Black):decelerate(0.2):diffusealpha(0)
    end;
};

AllObjects[#AllObjects+1] = LocationSce;
AllObjects[#AllObjects+1] = UI;

-- To avoid crashing (because of the memory the locations take),
-- collect the garbage from the previous session.
collectgarbage();

return AllObjects;