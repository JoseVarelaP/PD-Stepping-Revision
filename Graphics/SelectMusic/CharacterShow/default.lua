local function LoadCharacterFromPlayer(pn)
	local t = Def.Model {
					Condition=GAMESTATE:IsPlayerEnabled(pn) and GAMESTATE:GetCharacter(pn):GetDisplayName() ~= "default",
					Meshes=GAMESTATE:GetCharacter(pn):GetModelPath(),
					Materials=GAMESTATE:GetCharacter(pn):GetModelPath(),
					Bones=GAMESTATE:GetCharacter(pn):GetRestAnimationPath(),
					InitCommand=function(self)
						self:cullmode("CullMode_None"):rate(0)
						self:zoom(5):y(60):rotationy(180):x(-8)
					end,
				};
	return t;
end

local function BothPlayersEnabled()
	return GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2)
end

local t = Def.ActorFrame{};

t[#t+1] = LoadActor("Base")..{ OnCommand=cmd(shadowlengthy,3); };
t[#t+1] = LoadFont("Common Normal")..{ Text="Character", OnCommand=cmd(diffuse,color("#54918D");y,-50;x,40;zoom,0.8); };

for player in ivalues(PlayerNumber) do
	t[#t+1] = LoadCharacterFromPlayer(player)..{
		OnCommand=function(self)
		if BothPlayersEnabled() then
			self:x( (player == PLAYER_1 and -50) or 30 )
		end
		end,
	};
end

return t;