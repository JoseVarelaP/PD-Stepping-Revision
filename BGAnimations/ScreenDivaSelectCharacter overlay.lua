local t=Def.ActorFrame{}

-- Character List!
local ScreenNames = CHARMAN:GetAllCharacters();

------- Globals -----
local CurrChoice = 1;
------- Globals -----

local function VerifyValues()
	SBank:GetChild("MoveChoice"):play()
	-- Current Menu Choice
	if CurrChoice <= 0 					then CurrChoice = #ScreenNames end
	if CurrChoice >= #ScreenNames+1 	then CurrChoice = 1 end
end

--------------------------------------------------------
-- Input Callback
--------------------------------------------------------
local function ScrollInput(event)
	if not event.PlayerNumber then return end
	if ToEnumShortString(event.type) == "FirstPress" then
		if event.GameButton == "Start" then
			SBank:GetChild("StartSound"):play()

			GAMESTATE:SetCharacter( PLAYER_1, ScreenNames[CurrChoice]:GetCharacterID() )

			-- move to next screen
			SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectMusic")
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		end
		if event.GameButton == "MenuRight" then
			CurrChoice = CurrChoice + 1
			VerifyValues()
		end
		if event.GameButton == "MenuLeft" then
			CurrChoice = CurrChoice - 1
			VerifyValues()
		end
		if event.GameButton == "Back" then
			SCREENMAN:GetTopScreen():SetPrevScreenName("ScreenTitleMenu")
			SCREENMAN:GetTopScreen():Cancel()
		end
		MESSAGEMAN:Broadcast("UpdateAllValues")
	end
end

--------------------------------------------------------
-- Additional Actors
--------------------------------------------------------
local Controller = Def.ActorFrame{
	OnCommand=function(self) MESSAGEMAN:Broadcast("UpdateAllValues") SCREENMAN:GetTopScreen():AddInputCallback(ScrollInput) end;
};

local SoundBank = Def.ActorFrame{ OnCommand=function(self) SBank = self end;
	Def.Sound{Name="StartSound",File=THEME:GetPathS("", "Common start")},
	Def.Sound{Name="MoveChoice",File=THEME:GetPathS("", "Common change")},
};

local ChoiceStrip = Def.ActorFrame{}

local function TestActorScroller()
	local t = Def.ActorFrame{}
	for value in ivalues(ScreenNames) do
		local Result = Def.ActorFrame{
			OnCommand=function(self)
			self:fov(90)
			self:diffusealpha(0):zoom(0.8):sleep(0.3):decelerate(0.4):diffusealpha(1):zoom(1)
			end;

			Def.Model{
				Meshes=value:GetModelPath(),
				Materials=value:GetModelPath(),
				Bones=value:GetRestAnimationPath(),
				InitCommand=function(self)
					self:cullmode("CullMode_None"):rate(0.2* math.random(1,4) )
					self:zoom(15):rotationy(180):y(10)

					if string.find( value:GetDisplayName(), "Baby") then
						self:zoom(7)
					end
				end,
			};

			Def.Sprite{ Texture=THEME:GetPathG("","SelectMusic/WheelNotify/BPMChanges");
			OnCommand=function(self) self:zoom(2) end;
			};
	
			LoadFont("proto sans/20px") ..{
			OnCommand=function(self)
				self:zoom(0.6):y(0):shadowlength(1):diffuse(Color.Blue):strokecolor(Color.White)
				self:settext( value:GetDisplayName() )
			end;
			};
		};
		t[#t+1] = Result
	end

	return t;
end

local StaticItems = Def.ActorFrame{
	Def.ActorScroller{
		Name = 'Scroller';
		NumItemsToDraw=11;
		OnCommand=function(self)
			self:xy(SCREEN_CENTER_X,SCREEN_BOTTOM-100)
			:SetFastCatchup(true):SetSecondsPerItem(0.2)
			:SetDrawByZPosition(true):zoom( WideScale(0.6,0.8) ):SetWrap(true)
		end;
		TransformFunction=function(self, offset, itemIndex, numItems)
			local curve = math.pi;
			local WHEEL_3D_RADIUS = 1400;
			local rotationx_radians = scale(offset,-numItems/2,numItems/2,-curve/2,curve/2);
			self:x( WHEEL_3D_RADIUS * math.sin(rotationx_radians) );
			if CurrChoice-3 > itemIndex then
				self:x( WHEEL_3D_RADIUS * math.sin(rotationx_radians) );
			end

			self:finishtweening():decelerate(0.2)
			:diffuse( itemIndex == CurrChoice-1 and Color.White or color("0.3,0.3,0.3,1") )
			:z( itemIndex == CurrChoice-1 and 110 or (90 * math.cos(rotationx_radians*offset)) )
			self:diffusealpha( 2 * math.cos(rotationx_radians*offset) )
		end;
		children = TestActorScroller();
		UpdateAllValuesMessageCommand=function(self)
		self:SetDestinationItem(CurrChoice-1)
		end;
	};

	LoadFont("Common Normal")..{
		Text=Screen.String("HeaderText");
		InitCommand=function(self)
			self:vertalign(top):horizalign(left):xy(30,6):zoom(0.8)
		end;
	};
};

t[#t+1] = Controller
t[#t+1] = SoundBank
t[#t+1] = StaticItems
t[#t+1] = ChoiceStrip..{ OnCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y) end; };

return t;