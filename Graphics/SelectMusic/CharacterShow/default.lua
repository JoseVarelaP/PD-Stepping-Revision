local function LoadCharacterFromPlayer(pn)
	local t = Def.Model {
					Condition=GAMESTATE:IsPlayerEnabled(pn) and GAMESTATE:GetCharacter(pn):GetDisplayName() ~= "default",
					Meshes=GAMESTATE:GetCharacter(pn):GetModelPath(),
					Materials=GAMESTATE:GetCharacter(pn):GetModelPath(),
					Bones=GAMESTATE:GetCharacter(pn):GetDanceAnimationPath(),
					InitCommand=function(self)
						self:cullmode("CullMode_None")
						self:zoom(5):y(60):rotationy(180):x(-8)
						self:position( math.random(5,15) ):rate(0)
					end,
				};
	return t;
end

local t = Def.ActorFrame{};

if (DIVA:HasAnyCharacters(PLAYER_1) or DIVA:HasAnyCharacters(PLAYER_2)) then
	t[#t+1] = LoadActor("Base")..{
		 OnCommand=function(self)
			self:shadowlengthy(3)
		end
	};
	
	t[#t+1] = LoadFont("Common Normal")..{
		 Text="Character", OnCommand=function(self)
			self:diffuse(color("#54918D")):xy(40,-50):zoom(0.8)
		end
	};
end

for player in ivalues(PlayerNumber) do
	if GAMESTATE:IsPlayerEnabled(player) and DIVA:IsSafeToLoad(player) then
		t[#t+1] = LoadCharacterFromPlayer(player)..{
			OnCommand=function(self)
			if DIVA:BothPlayersEnabled() then
				self:x( (player == PLAYER_1 and -50) or 30 )
			end
			end,
		};
	end
end

return t;