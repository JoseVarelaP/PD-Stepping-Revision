local t = Def.ActorFrame{};

t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/TopInfo") )..{
	InitCommand=cmd(x,SCREEN_LEFT;horizalign,left;zoom,1;vertalign,top);
};

t[#t+1] = LoadFont("Common Normal")..{
	Text=GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
	OnCommand=cmd(x,SCREEN_LEFT+90;y,4;horizalign,left;zoom,0.6;SetTextureFiltering,false;vertalign,top);
};

return t;