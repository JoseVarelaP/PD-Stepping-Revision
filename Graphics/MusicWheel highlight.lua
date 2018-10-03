local t = Def.ActorFrame{
	CurrentStepsP1ChangedMessageCommand=function(self)
		self:queuemessage("UpdateSteps")
	end;
	CurrentStepsP2ChangedMessageCommand=function(self)
		self:queuemessage("UpdateSteps")
	end;
	CurrentSongChangedMessageCommand=function(self)
		self:queuemessage("UpdateSteps")
	end;
};

	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self)
			self:x(290):pulse():effectmagnitude(1,1.02,0):effectclock("bgm"):effectperiod(1):effectoffset(0.2)
		end;

		LoadActor("SelectMusic/WheelHighlight")..{
		InitCommand=function(self)
			self:zoom(0.54):zoomy(0.64)
		end;
		SetMessageCommand=function(self,params)
			local steps = GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() ):GetDifficulty()
			self:diffuse( CustomDifficultyToColor( steps ) )
		end,
		};

	};

return t;