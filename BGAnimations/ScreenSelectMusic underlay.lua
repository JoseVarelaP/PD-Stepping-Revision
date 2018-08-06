local t = Def.ActorFrame{}

-- x,-230;y,70

local function SongData(ToObtain, xpos, ypos, halign)
	local t = LoadFont("Common Normal")..{
	OnCommand=cmd(zoom,0.7;horizalign,halign or middle;x,xpos;y,ypos);
	UpdateCommand=function(self) self:settext( (GAMESTATE:GetCurrentSong() and ToObtain) or "" ) end,
	CurrentSongChangedMessageCommand=cmd(playcommand,"Update");
	CurrentP1StepsChangedMessageCommand=cmd(playcommand,"Update");
	CurrentP2StepsChangedMessageCommand=cmd(playcommand,"Update");
	};

	return t;
end

t[#t+1] = LoadActor( THEME:GetPathG("","Light_BottomMenuBar") )..{
	OnCommand=cmd(x,SCREEN_RIGHT;horizalign,right;zoom,2;SetTextureFiltering,false;;y,SCREEN_BOTTOM;vertalign,bottom);
};

t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-60;y,SCREEN_CENTER_Y-90;diffusealpha,0;zoom,0.8;sleep,0.3;decelerate,0.2;zoom,1;diffusealpha,1);
	OffCommand=cmd(playcommand,"GoAway");
	CancelMessageCommand=cmd(playcommand,"GoAway");
	GoAwayCommand=cmd(accelerate,0.2;addx,100;diffusealpha,0);
	
	LoadActor( THEME:GetPathG("","SelectMusic/BannerFrame") )..{
		OnCommand=cmd(horizalign,right;zoom,1.5;SetTextureFiltering,false);
	};

	LoadActor( THEME:GetPathG("","SelectMusic/SongInfoBG") )..{
		OnCommand=cmd(horizalign,right;zoom,1.5;SetTextureFiltering,false;y,100);
	};

	-- Info start
	LoadFont("Common Normal")..{
	OnCommand=cmd(zoom,0.7;horizalign,left;x,-239;y,70);
	UpdateCommand=function(self) self:settext( (GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():GetDisplayMainTitle()) or "" ) end,
	CurrentSongChangedMessageCommand=cmd(playcommand,"Update");
	CurrentP1StepsChangedMessageCommand=cmd(playcommand,"Update");
	CurrentP2StepsChangedMessageCommand=cmd(playcommand,"Update");
	};

	LoadFont("Common Normal")..{
	OnCommand=cmd(zoom,0.6;horizalign,left;x,-239;y,85);
	UpdateCommand=function(self) self:settext( (GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():GetDisplaySubTitle()) or "" ) end,
	CurrentSongChangedMessageCommand=cmd(playcommand,"Update");
	CurrentP1StepsChangedMessageCommand=cmd(playcommand,"Update");
	CurrentP2StepsChangedMessageCommand=cmd(playcommand,"Update");
	};

	LoadFont("Common Normal")..{
	OnCommand=cmd(zoom,0.6;horizalign,left;x,-239;y,85);
	UpdateCommand=function(self)
		self:y(85)
		self:settext( (GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():GetDisplayArtist()) or "" )
		if GAMESTATE:GetCurrentSong() and string.len( GAMESTATE:GetCurrentSong():GetDisplaySubTitle() ) > 1 then
			self:y(100)
		end
	end,
	CurrentSongChangedMessageCommand=cmd(playcommand,"Update");
	CurrentP1StepsChangedMessageCommand=cmd(playcommand,"Update");
	CurrentP2StepsChangedMessageCommand=cmd(playcommand,"Update");
	};

	Def.ActorProxy{
	BeginCommand=function(self)
	self:SetTarget( SCREENMAN:GetTopScreen():GetChild("Banner") )
	end,
	InitCommand=cmd(x,-133.5;y,-15);
	CurrentSongChangedMessageCommand=function(self)
	self:finishtweening():zoom(0.8):decelerate(0.2):zoom(1)
	end,
	};

	LoadActor( THEME:GetPathG("","SelectMusic/ICON_ContainsBGChanges") )..{
		OnCommand=cmd(horizalign,right;zoom,1.5;SetTextureFiltering,false;y,20;x,-60);
		CurrentSongChangedMessageCommand=function(self)
		self:visible(false)
		if GAMESTATE:GetCurrentSong() then
			if GAMESTATE:GetCurrentSong():HasBGChanges() then
				self:visible(true)
			end
		end
		end,
	};

	LoadActor( THEME:GetPathG("","SelectMusic/ICON_ContainsAttacks") )..{
		OnCommand=cmd(horizalign,right;zoom,1.5;SetTextureFiltering,false;y,20;x,-42);
		CurrentSongChangedMessageCommand=function(self)
		self:visible(false)
		if GAMESTATE:GetCurrentSong() then
			if GAMESTATE:GetCurrentSong():HasAttacks() then
				self:visible(true)
			end
		end
		end,
	};

	Def.StepsDisplayList{
		Name="StepsDisplayList";
		OnCommand=cmd(zoom,0.8;x,-120;y,150);
		SetCommand=function(self)
			self:visible(GAMESTATE:GetCurrentSong() ~= nil)
		end;
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");

		CursorP1=LoadActor(THEME:GetPathG('SelectMusic/DifficultyList', 'cursor p1'))..{
			Name='CursorP1';
			InitCommand=cmd(player,PLAYER_1;zoom,0);
			ChangeCommand=cmd(stoptweening;bounceend,0.15);
		};
		CursorP1Frame=Def.ActorFrame{
			Name='CursorP1Frame';
			ChangeCommand=cmd(stoptweening;bounceend,0.15);
		};
		CursorP2=LoadActor(THEME:GetPathG('SelectMusic/DifficultyList', 'cursor p2'))..{
			Name='CursorP2';
			InitCommand=cmd(player,PLAYER_2;zoom,0);
			ChangeCommand=cmd(stoptweening;bounceend,0.15);
		};
		CursorP2Frame=Def.ActorFrame {
			Name='CursorP2Frame';
			ChangeCommand=cmd(stoptweening;bounceend,0.15);
		};
	};



	Def.BitmapText{
	Font="Common Normal",
	OnCommand=cmd(horizalign,left;shadowlength,2;zoom,0.8;x,-210;y,125;diffusealpha,1);
	CurrentSongChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local val
		if song then
			local bpms = song:GetDisplayBpms()
			if bpms[1] == bpms[2] then
				val = "BPM "..string.format("%i",bpms[1])
			else
				val = "BPM "..string.format("%i-%i",bpms[1],bpms[2])
			end
		else
			val = " "
		end
		self:settext(val)
	end;
	},
}

local Spacing = 120

t[#t+1] = LoadActor( THEME:GetPathG("","SelectMusic/ScrollArrow") )..{
	InitCommand=cmd(x,SCREEN_LEFT+5;horizalign,left;zoom,2;y,SCREEN_CENTER_Y+Spacing);
	OnCommand=cmd(zoomy,-2);
	NextSongMessageCommand=cmd(stoptweening;y,SCREEN_CENTER_Y+Spacing+10;decelerate,0.2;y,SCREEN_CENTER_Y+Spacing);
	OffCommand=cmd(playcommand,"GoAway");
	CancelMessageCommand=cmd(playcommand,"GoAway");
	GoAwayCommand=cmd(accelerate,0.2;addx,-100;diffusealpha,0);
};

t[#t+1] = LoadActor( THEME:GetPathG("","SelectMusic/ScrollArrow") )..{
	InitCommand=cmd(x,SCREEN_LEFT+5;horizalign,left;zoom,2;y,SCREEN_CENTER_Y-Spacing);
	OnCommand=cmd(zoomy,2);
	PreviousSongMessageCommand=cmd(stoptweening;y,SCREEN_CENTER_Y-Spacing-10;decelerate,0.2;y,SCREEN_CENTER_Y-Spacing);
	OffCommand=cmd(playcommand,"GoAway");
	CancelMessageCommand=cmd(playcommand,"GoAway");
	GoAwayCommand=cmd(accelerate,0.2;addx,-100;diffusealpha,0);
};

return t;