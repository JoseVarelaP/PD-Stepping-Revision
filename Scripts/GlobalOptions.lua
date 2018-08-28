function ReturnBoolean()
	return { THEME:GetString("OptionNames","Off"); THEME:GetString("OptionNames","On") }
end

GlobalOptions = {
	-- -- -- -- -- -- -- -- -- --
	-- Appearance Options
	-- -- -- -- -- -- -- -- -- --
	Game = { "dance", "pump", "kb7", "para", "beat", "techno", "lights" };

	Language = {
		"Deutsch",
		"English",
		"Español",
		"Francais",
		"English",
		"English",
		"English",
	};

	Announcer = ANNOUNCER:GetAnnouncerNames();
	Theme = THEME:GetSelectableThemeNames();
	DefaultNoteSkin = NOTESKIN:GetNoteSkinNames();

	PercentageScoring = ReturnBoolean();
	ShowBeginnerHelper = ReturnBoolean();

	RandomBackgroundMode = {
		THEME:GetString("OptionNames","Off");
		THEME:GetString("OptionNames","Animations");
		THEME:GetString("OptionNames","Random Movies");
	};

	BackgroundFitMode = {
		THEME:GetString("OptionNames","CoverDistort");
		THEME:GetString("OptionNames","CoverPreserve");
		THEME:GetString("OptionNames","FitInside");
		THEME:GetString("OptionNames","FitInsideAvoidLetter");
		THEME:GetString("OptionNames","FitInsideAvoidPillar");
	};

	ShowDancingCharacters = {
		THEME:GetString("OptionNames","Default to Off");
		THEME:GetString("OptionNames","Default to Random");
		THEME:GetString("OptionNames","Select");
	};

	NumBackgrounds = { "1", "5", "10", "15", "20" };
	BGBrightness = { "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" };

	-- -- -- -- -- -- -- -- -- --
	-- UI Options
	-- -- -- -- -- -- -- -- -- --
	Center1Player = ReturnBoolean();
	MenuTimer = ReturnBoolean();
	MusicWheelUsesSections = {
		THEME:GetString("OptionNames","Never");
		THEME:GetString("OptionNames","Always");
		THEME:GetString("OptionNames","Title Only");
	};
	ShowBanners = ReturnBoolean();
	ShowCaution = { THEME:GetString("OptionNames","Skip"); THEME:GetString("OptionNames","Show"); };
	ShowDanger = { THEME:GetString("OptionNames","Skip"); THEME:GetString("OptionNames","Show"); };
	ShowInstructions = { THEME:GetString("OptionNames","Skip"); THEME:GetString("OptionNames","Show"); };
	ShowLyrics = { THEME:GetString("OptionNames","Skip"); THEME:GetString("OptionNames","Show"); };
	ShowSongOptions = {
		THEME:GetString("OptionNames","Ask");
		THEME:GetString("OptionNames","Hide");
		THEME:GetString("OptionNames","Show");
	};
	ShowNativeLanguage = { THEME:GetString("OptionNames","Romanization"); THEME:GetString("OptionNames","Native Language"); };

	-- Graphic Options

	-- -- -- -- -- -- -- -- -- --
	-- Advanced Options
	-- -- -- -- -- -- -- -- -- --
	TimingWindowScale = range(8);
	LifeDifficulty = range(7);
	DefaultFailType = {
		THEME:GetString("OptionNames","Immediate");
		THEME:GetString("OptionNames","ImmediateContinue");
		THEME:GetString("OptionNames","EndOfSong");
		THEME:GetString("OptionNames","Off");
	};

	AllowW1 = {
		THEME:GetString("OptionNames","Never");
		THEME:GetString("OptionNames","Courses Only");
		THEME:GetString("OptionNames","Always");
	};

	HiddenSongs = ReturnBoolean();
	EasterEggs = ReturnBoolean();
	AllowExtraStage = ReturnBoolean();
	UseUnlockSystem = ReturnBoolean();
	AutogenSteps = ReturnBoolean();
	AutogenGroupCourses = ReturnBoolean();
	FastLoad = ReturnBoolean();
	FastLoadAdditionalSongs = ReturnBoolean();
	AllowSongDeletion = ReturnBoolean();

}

table.insert(GlobalOptions.TimingWindowScale, "Justice")