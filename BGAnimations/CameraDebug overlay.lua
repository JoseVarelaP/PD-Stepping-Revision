-- Location Viewer

-- Locals that define position around the play area
local Camera = {
    -- Movement
    x = 0, y = 10, z = WideScale(300,400),
    -- Rotation
    rotx = 0, roty = 180, rotz = 0,
};

local MoveMargin = 8;

local CamInput = {
    ["Move"] = {
        ["MenuRight"]   = function() Camera.x = Camera.x - MoveMargin end,
        ["MenuLeft"]    = function() Camera.x = Camera.x + MoveMargin end,
        ["MenuUp"]      = function() Camera.z = Camera.z + MoveMargin end,
        ["MenuDown"]    = function() Camera.z = Camera.z - MoveMargin end,
        ["EffectUp"]    = function() Camera.y = Camera.y + MoveMargin end,
        ["EffectDown"]  = function() Camera.y = Camera.y - MoveMargin end,
    };
    ["Rotate"] = {
        ["MenuRight"]   = function() Camera.roty = Camera.roty - MoveMargin end,
        ["MenuLeft"]    = function() Camera.roty = Camera.roty + MoveMargin end,
        ["MenuUp"]      = function() Camera.rotx = Camera.rotx + MoveMargin end,
        ["MenuDown"]    = function() Camera.rotx = Camera.rotx - MoveMargin end,
        ["EffectUp"]    = function() Camera.rotz = Camera.rotz + MoveMargin end,
        ["EffectDown"]  = function() Camera.rotz = Camera.rotz - MoveMargin end,
    };
};

-- Begin by setting up a ActorFrame which will handle everything.
-- And also the subsequent ones that will be filled up later.
local AllObjects = Def.ActorFrame{};
local UI = Def.ActorFrame{};
local LocationSce = Def.ActorFrame{
    InitCommand=function(self)
        self:Center():fov(90):rotationy(180):z( WideScale(300,400) ):addy(10);
    end;
    UpAllValMessageCommand=function(self)
        self:stoptweening():decelerate(0.4)
        self:xyz( SCREEN_CENTER_X+Camera.x, SCREEN_CENTER_Y+Camera.y, Camera.z )
        --self:vanishpoint( Camera.x,Camera.y )
        :rotationx( Camera.rotx ):rotationy( Camera.roty ):rotationz( Camera.rotz )
    end;
};
local InputMode = "Move";

local StageToShow = ThemePrefs.Get("CurrentStageLocation")

-- Input handler, manages all the Input data that will be recieved by the player.
local function InputHandler(event)
    -- Safe check to input nothing if any value happens to be not a player.
    -- ( AI, or engine input )
    if not event.PlayerNumber then return end

    -- Input that occurs at the moment the button is pressed.
    if ToEnumShortString(event.type) == "FirstPress" then
        if event.GameButton == "Start" then
            if InputMode == "Move" then InputMode = "Rotate" return end
            if InputMode == "Rotate" then InputMode = "Move" return end
        end
        if event.GameButton == "Back" then
            SCREENMAN:GetTopScreen():SetPrevScreenName("ScreenTitleMenu"):Cancel()
            return
        end
        if CamInput[InputMode][event.GameButton] then
            CamInput[InputMode][event.GameButton]()
        end
    end

    -- Input that loops if the same button that was pressed is still held.
    -- Usually I have to loop the same commands from FirstPress to do this
    -- and honestly it's messy.
    if ToEnumShortString(event.type) == "Repeat" then
        if event.GameButton == "Start" then
            if InputMode == "Move" then InputMode = "Rotate" return end
            if InputMode == "Rotate" then InputMode = "Move" return end
        end
        if CamInput[InputMode][event.GameButton] then
            CamInput[InputMode][event.GameButton]()
        end
    end
    MESSAGEMAN:Broadcast("UpAllVal")
end

local Controller = Def.ActorFrame{
	OnCommand=function(self) MESSAGEMAN:Broadcast("UpAllVal")
	SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end;
};

local RandomChar1 = CHARMAN:GetRandomCharacter();

local CRFileLoc = "Save/DIVA_CharacterRooms.ini"
for char in ivalues( CHARMAN:GetAllCharacters() ) do
    local LocRandom = LOADER:LoadStages()[math.random( 1,#LOADER:LoadStages() )]
    if not Config.Load( char:GetCharacterID() ,CRFileLoc) then
        Config.Save( tostring(char:GetCharacterID()) , LocRandom , CRFileLoc)
    end
end

local LocLoad = Config.Load( RandomChar1:GetCharacterID(), CRFileLoc)

-- This will just load the appropiate material from the stage loaded from the config file generated.
function DICLoad_Appropiate_Material()
    local ToFind = "/main_material.txt"
	if Config.Load( "AbleToChangeLight", DIVA:GetPathLocation("",LocLoad.."/ModelConfig.cfg") ) then
		ToFind = "/"..DEDICHAR:LightToLoad().."_material.txt"
	end
	return DIVA:GetPathLocation("",LocLoad..ToFind);
end

-- Add Controller to the input
AllObjects[#AllObjects+1] = Controller;

-- Load stage into the 3D space.
LocationSce[#LocationSce+1] = Def.Model {
    Meshes=DIVA:GetPathLocation("",LocLoad.."/model.txt");
    Materials=DICLoad_Appropiate_Material();
    Bones=DIVA:GetPathLocation("",LocLoad.."/model.txt");
    OnCommand=function(self)
        self:cullmode("CullMode_None"):zoom( DIVA:CheckStageConfigurationNumber(1,"StageZoom") )
        self:xy( DIVA:CheckStageConfigurationNumber(0,"StageXOffset"), DIVA:CheckStageConfigurationNumber(0,"StageYOffset") )
    end,
};

LocationSce[#LocationSce+1] = Def.Model {
    Meshes=RandomChar1:GetModelPath();
    Materials=RandomChar1:GetModelPath();
    Bones=RandomChar1:GetDanceAnimationPath();
    OnCommand=function(self) self:cullmode("CullMode_None") end,
};

UI[#UI+1] = LoadActor("Borders.lua");

UI[#UI+1] = LoadFont("Common Normal")..{
    Text="Camera Viewer";
    InitCommand=function(self) self:align(0,0):xy(30,6):zoom(0.8)
    end;
};

UI[#UI+1] = Def.BitmapText{
    Font="Common Normal",
    OnCommand=function(self)
        self:xy(SCREEN_LEFT+30,SCREEN_BOTTOM-8)
        :strokecolor( Color.Black ):align(0,1):zoom(0.8)
    end;
    UpAllValMessageCommand=function(self)
        self:settext( 
            string.format( "x: %s, y: %s, z: %s, rotx: %s, roty: %s, rotz: %s", Camera.x, Camera.y, Camera.z, Camera.rotx, Camera.roty, Camera.rotz )
         )
    end;
};

UI[#UI+1] = Def.Quad{
    OnCommand=function(self)
        self:FullScreen():diffuse(Color.Black):decelerate(0.5):diffusealpha(0)
    end;
};

AllObjects[#AllObjects+1] = LocationSce;
AllObjects[#AllObjects+1] = UI;

--Config.Save( "CharacterRoom"..RandomChar1:GetCharacterID() , ThemePrefs.Get("CurrentStageLocation") , CRFileLoc)

return AllObjects;