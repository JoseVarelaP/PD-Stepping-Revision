local t = Def.ActorFrame{};

local function ObtainSongOrCourseName()
	if GAMESTATE:IsCourseMode() then
		return GAMESTATE:GetCurrentCourse():GetDisplayFullTitle()
	end
	return GAMESTATE:GetCurrentSong():GetDisplayMainTitle()
end

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:diffusealpha(0):addx(-30):decelerate(0.2):diffusealpha(1):addx(30):sleep(5)
	end;
	OffCommand=function(self)
		self:decelerate(0.2):diffusealpha(0):addx(-30)
	end;
		Def.Quad{
			OnCommand=function(self)
				self:diffuse(Color.Black):y(SCREEN_BOTTOM-30):horizalign(left):vertalign(bottom):zoomto(500,70):faderight(1)
			end;
		};

		Def.Quad{
			InitCommand=function(self)
				self:diffuse(Color.Black):y(SCREEN_BOTTOM-70):horizalign(left):vertalign(bottom):x(SCREEN_LEFT+110):zoomto(350,25):faderight(1):fadeleft(0.1)
			end;
			OnCommand=function(self)
				self:diffusealpha(0.6)
			end;
		};

		Def.Sprite {
			InitCommand=function(self)
				self:diffusealpha(1):horizalign(left):vertalign(bottom):x(SCREEN_LEFT+50):y(SCREEN_BOTTOM-38)
			end;
			CurrentSongChangedMessageCommand=function(self)
			self:stoptweening()
			self:linear(0.05):diffusealpha(0)
			:queuecommand("UpdateBackground")
			end,
			UpdateBackgroundCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
				self:LoadFromCurrentSongBackground():diffusealpha(1)
				self:setsize(110/2,110/2)
			end
			end,
			OnCommand=function(self)
				self:diffusealpha(0):sleep(1):linear(1):diffusealpha(1)
				self:setsize(110/2,110/2)
			end;
		};

		LoadFont("Common Normal")..{
				Text=ObtainSongOrCourseName();
				InitCommand=function(self)
					self:zoom(0.7):horizalign(left):x(SCREEN_LEFT+110):y(SCREEN_BOTTOM-83)
				end;
				OnCommand=function(self)
					self:diffusealpha(0):linear(0.5):diffusealpha(1)
				end;
			};

};

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffusealpha(0):sleep(5.2)
	end;
	OffCommand=function(self)
		self:linear(0.5):diffusealpha(1)
	end;
};

return t;
