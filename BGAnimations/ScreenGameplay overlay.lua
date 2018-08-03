local t = Def.ActorFrame{}

t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/TopInfo") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;horizalign,right;zoom,2;SetTextureFiltering,false;vertalign,top);
};

t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/TuneIcon") )..{
	OnCommand=cmd(x,SCREEN_LEFT+10;y,7;horizalign,left;zoom,2;SetTextureFiltering,false;vertalign,top);
};

t[#t+1] = LoadFont("Common Normal")..{
	Text=GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
	OnCommand=cmd(x,SCREEN_LEFT+40;y,11;horizalign,left;zoom,0.8;SetTextureFiltering,false;vertalign,top);
};

t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/BottomInfo/Base") )..{
	OnCommand=cmd(CenterX;zoomtowidth,SCREEN_WIDTH-126;cropright,0.0755;SetTextureFiltering,false;y,SCREEN_BOTTOM;vertalign,bottom);
};

t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/BottomInfo/LifeIndicator") )..{
	OnCommand=cmd(x,SCREEN_LEFT;horizalign,left;zoom,1;SetTextureFiltering,false;y,SCREEN_BOTTOM;vertalign,bottom);
};

t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/BottomInfo/RightBorder") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;horizalign,right;zoom,1;SetTextureFiltering,false;y,SCREEN_BOTTOM;vertalign,bottom);
};

for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
	for i = 1,15 do
		t[#t+1] = Def.Sprite{
			BeginCommand=cmd(y,SCREEN_BOTTOM-5;vertalign,bottom);
			InitCommand=function(self) 
				self:x(SCREEN_LEFT+28)
			end;
			LifeChangedMessageCommand=function(self,params)
				self:Load(THEME:GetCurrentThemeDirectory().."Graphics/Gameplay/lifebar/Frames 13x2.png")
				self:pause()
				if (params.Player == pn) then
					local life = string.format("%.1f",params.LifeMeter:GetLife() * 10)
					local pills = (string.format("%.1f",life * 2.9 / 15)) * 10
					self:setstate(-1 + i)
					if pills >= i then self:visible(true) else self:visible(false) end
					if pills >= 15 then self:glowshift():effectperiod(0.1):effectcolor1(1,1,1,0.4):effectcolor2(1,1,1,0) else self:stopeffect() end
				end;
			end;
		};
	end
end

return t;