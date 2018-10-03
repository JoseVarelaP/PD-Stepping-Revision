local function PercentScore(pn)
	local SongOrCourse, StepsOrTrail;
		if GAMESTATE:IsCourseMode() then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
		else
			SongOrCourse = GAMESTATE:GetCurrentSong();
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
		end;
		local profile, scorelist;
		local text = "";
		if SongOrCourse and StepsOrTrail then
			local st = StepsOrTrail:GetStepsType();
			local diff = StepsOrTrail:GetDifficulty();
			local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
			local cd = GetCustomDifficulty(st, diff, courseType);
			if PROFILEMAN:IsPersistentProfile(pn) then
				-- player profile
				profile = PROFILEMAN:GetProfile(pn);
			else
				-- machine profile
				profile = PROFILEMAN:GetMachineProfile();
			end;
			scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
			assert(scorelist)
			local scores = scorelist:GetHighScores();
			local topscore = scores[1];
			if topscore then
				text = string.format("%.2f%%", topscore:GetPercentDP()*100.0);
				-- 100% hack
				if text == "100.00%" then
					text = "100%";
				end;
			else
				text = string.format("%.2f%%", 0);
			end;
		else
			text = "";
		end;

	return text;
end

local function PointScore(pn)
	local SongOrCourse, StepsOrTrail;
		if GAMESTATE:IsCourseMode() then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
		else
			SongOrCourse = GAMESTATE:GetCurrentSong();
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
		end;
		local profile, scorelist;
		local text = "";
		if SongOrCourse and StepsOrTrail then
			local st = StepsOrTrail:GetStepsType();
			local diff = StepsOrTrail:GetDifficulty();
			local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
			local cd = GetCustomDifficulty(st, diff, courseType);
			if PROFILEMAN:IsPersistentProfile(pn) then
				-- player profile
				profile = PROFILEMAN:GetProfile(pn);
			else
				-- machine profile
				profile = PROFILEMAN:GetMachineProfile();
			end;
			scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
			assert(scorelist)
			local scores = scorelist:GetHighScores();
			local topscore = scores[1];
			if topscore then
				text = topscore:GetScore().." pts";
			else
				text = "0 pts";
			end;
		else
			text = "";
		end;

	return text;
end


local t = Def.ActorFrame{
	CurrentStepsP1ChangedMessageCommand=function(self)
		self:queuemessage("UpdateScore")
	end;
	CurrentStepsP2ChangedMessageCommand=function(self)
		self:queuemessage("UpdateScore")
	end;
	CurrentSongChangedMessageCommand=function(self)
		self:queuemessage("UpdateScore")
	end;
};

t[#t+1] = LoadActor("Base");
t[#t+1] = LoadFont("Common Normal")..{
	 Text="Score", OnCommand=function(self)
		self:diffuse(color("#5A5A5A")):x(38):y(-50):zoom(0.8)
	end
};

for player in ivalues(PlayerNumber) do

t[#t+1] = LoadActor("ScoreInfoBG")..{
	 OnCommand=function(self)
		self:y((player == PLAYER_1 and -4) or 42):x(-8):zoomy(0.7)
	end
};
t[#t+1] = LoadFont("unsteady oversteer/20px")..{
	Condition=GAMESTATE:IsPlayerEnabled(player);
	OnCommand=function(self)
		self:horizalign(right):x(50):y((player == PLAYER_1 and -12) or 34):zoom(1)
	end;
	UpdateScoreMessageCommand=function(self)
	self:settext( PercentScore(player) )
	end,
};
t[#t+1] = LoadFont("Common Normal")..{
	Condition=GAMESTATE:IsPlayerEnabled(player);
	OnCommand=function(self)
		self:horizalign(right):x(50):y((player == PLAYER_1 and 5) or 50):zoom(0.8)
	end;
	UpdateScoreMessageCommand=function(self)
	self:settext( PointScore(player) )
	end,
};
end

return t;