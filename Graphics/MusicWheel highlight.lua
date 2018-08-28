local t = Def.ActorFrame{
	CurrentStepsP1ChangedMessageCommand=cmd(queuemessage,"UpdateSteps");
	CurrentStepsP2ChangedMessageCommand=cmd(queuemessage,"UpdateSteps");
	CurrentSongChangedMessageCommand=cmd(queuemessage,"UpdateSteps");
};

	t[#t+1] = Def.ActorFrame{
		OnCommand=cmd(x,290;pulse;effectmagnitude,1,1.02,0;effectclock,"bgm";effectperiod,1);

		LoadActor("SelectMusic/WheelHighlight")..{
		InitCommand=cmd(zoom,0.54;zoomy,0.64);
		SetMessageCommand=function(self,params)
			local steps = GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() ):GetDifficulty()
			self:diffuse( CustomDifficultyToColor( steps ) )
		end,
		};

	};

return t;