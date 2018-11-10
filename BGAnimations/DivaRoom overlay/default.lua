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
        self:Center():fov(90):rotationy(180):z( WideScale(300,400) ):addy(10);
    end;
    UpAllValMessageCommand=function(self)
        self:stoptweening():decelerate(0.1)
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

-- local function LoadCharacterHome()
--     if ThemePrefs.Get( GAMESTATE:GetMasterPlayerNumber():Get().."" )
-- end

-- Input handler, manages all the Input data that will be recieved by the player.
local function InputHandler(event)
    -- Safe check to input nothing if any value happens to be not a player.
    -- ( AI, or engine input )
    if not event.PlayerNumber then return end

    -- Input that occurs at the moment the button is pressed.
    if ToEnumShortString(event.type) == "FirstPress" then
        if event.GameButton == "Start" then
            -- Load the main menu if the button is pressed.
            SCREENMAN:GetTopScreen():SetNextScreenName("DivaRoom")
            SCREENMAN:AddNewScreenToTop("DivaRoom overlay/CharChooser", "SM_GoToNextScreen")
        end
        if event.GameButton == "Back" then
        end
        if InputListing[event.GameButton] then
            InputListing[event.GameButton]()
        end
    end
    CheckValues()
    MESSAGEMAN:Broadcast("UpAllVal")
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
    --SCREENMAN:SystemMessage( tostring( LocCfg ) )
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
    Bones=LoadedCharacter:GetDanceAnimationPath();
    OnCommand=function(self) self:cullmode("CullMode_None") end,
};

UI[#UI+1] = LoadActor("../Borders.lua");

AllObjects[#AllObjects+1] = LocationSce;
AllObjects[#AllObjects+1] = UI;

return AllObjects;