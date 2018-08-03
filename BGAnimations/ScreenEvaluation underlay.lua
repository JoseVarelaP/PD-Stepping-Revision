local t = Def.ActorFrame{
	OnCommand=cmd(rotationz,5;fov,90);
}

t[#t+1] = Def.ActorFrame{
	Def.Quad{ OnCommand=cmd(zoomto,SCREEN_WIDTH*3,SCREEN_HEIGHT*2;diffuse,0,0.1,0.2,1) };
	LoadActor( THEME:GetPathG("","Evaluation/Background/Clouds") )..{
	OnCommand=function(self)
	local Czoomx = 2
	self:Center():blend("BlendMode_Add"):diffusealpha(0.3):addy(-30)
	:texcoordvelocity(-0.10,0):customtexturerect(0,0,Czoomx,2)
	:zoomx(Czoomx):zoomy(Czoomx)
	end
	};
}

for i=1,80 do
	t[#t+1] = LoadActor( THEME:GetPathG("","Evaluation/Background/Lasers") )..{
	OnCommand=function(self)
	self:xy( math.random(0,SCREEN_RIGHT), math.random(50,SCREEN_BOTTOM-50) )
	self:z( math.random(-200,200) )
	:diffuse(0,math.random(60.0/100,100.0/100),math.random(80.0/100,100.0/100),0.5):glowshift(1,1,1,0.5):zoomy(0.5)
	:effectperiod(10)
	:queuecommand("BeginLoop")
	end,
	BeginLoopCommand=function(self)
	self:sleep(0.05*i):linear(4):x(self:GetX()-3500):sleep(0)
	:xy( SCREEN_RIGHT+720, math.random(0,SCREEN_BOTTOM-0) )
	:queuecommand("BeginLoop")
	end,
	};
end

return t;