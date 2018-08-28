return Def.ActorFrame{
	LoadActor("Base")..{ OnCommand=cmd(); };
	LoadFont("Common Normal")..{ Text="Score", OnCommand=cmd(diffuse,color("#5A5A5A");x,38;y,-50;zoom,0.8); };
}