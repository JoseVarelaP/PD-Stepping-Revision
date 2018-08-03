local t = Def.ActorFrame{
	OnCommand=cmd(fov,90);
}

t[#t+1] = Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,color("0,0.7,0.6,0.1"));
}

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/CircleInner") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;diffusealpha,0.3;spin;effectmagnitude,0,0,24;zoom,1.2);
};

t[#t+1] = LoadActor( THEME:GetPathG("","Light_TopMenuBar") )..{
	OnCommand=cmd(x,SCREEN_LEFT;horizalign,left;zoom,2;SetTextureFiltering,false;vertalign,top);
};

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/CircleOuter") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;zoom,1.2;queuecommand,"Loop");
	LoopCommand=function(self)
	self:diffusealpha(0.2):linear(5)
	:diffusealpha(0.8):decelerate(1)
	:diffusealpha(0.2):sleep(6)
	:queuecommand("Loop")
	end,
};

t[#t+1] = Def.Quad{
	OnCommand=cmd(zoom,1.2;queuecommand,"Loop");
	LoopCommand=function(self)
	self:diffusealpha(0):zoom(0)
	:x( math.random(0,SCREEN_RIGHT) ):y( math.random(0,SCREEN_BOTTOM) )
	:zoomto(0,10):diffuse(0,0.6,0.8,0.5):zoomto(200,10):cropright(1):linear(1):cropright(0)
	:linear(1):zoomto( 450, 60 ):diffusealpha(0):sleep( math.random(1,3) )
	:queuecommand("Loop")
	end,
}

t[#t+1] = LoadActor( THEME:GetPathG("","BGElements/CircleOuter") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;zoom,1.2;queuecommand,"Loop");
	LoopCommand=function(self)
	self:diffusealpha(0):zoom(1.2):sleep(5)
	:diffusealpha(1):linear(6)
	:zoom(5):diffusealpha(0.1):sleep(1)
	:queuecommand("Loop")
	end,
};

t[#t+1] = LoadActor( THEME:GetPathG("","BGMenuTile") )..{
	OnCommand=cmd(x,SCREEN_RIGHT-50;zoomx,0.5;zoomy,1.5;horizalign,right;CenterY;diffusealpha,0.5;texcoordvelocity,0,0.25;customtexturerect,0,0,1,2);
};

-- Load the character BEFORE doing anything.
-- This is because calling the command will make a mesh of 
-- loading everything with other characters.
local CharacterToLoad = CHARMAN:GetRandomCharacter();

t[#t+1] = Def.Model {
	Meshes=CharacterToLoad:GetModelPath(),
	Materials=CharacterToLoad:GetModelPath(),
	-- For this, we'll change the location to a bone being used,
	-- by using a function to call it.
	-- Let's setup the Rest animation for now.
	Bones=CharacterToLoad:GetDanceAnimationPath(),
	OnCommand=function(self)
		-- Set their y rotation to our view.
		-- And also apply a z that will get the model closer to the camera.
		-- Now that we've setup the rest animation, we'll need to also setup the Y position
		-- back to a lower one.
		self:Center():rotationy(200):z(405):addy(12)
		-- lets pause the animation
		:rate(0.05):cullmode("CullMode_None")
	end,
};

return t;