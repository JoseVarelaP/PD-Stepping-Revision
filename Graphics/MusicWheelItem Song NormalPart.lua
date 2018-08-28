local t = Def.ActorFrame {};

	t[#t+1] = Def.ActorFrame{
		NextSongMessageCommand=cmd(playcommand,"Close");
		PreviousSongMessageCommand=cmd(playcommand,"Close");
		StartSelectingStepsMessageCommand=cmd(queuemessage,"FadeWheel");
		StepsChosenMessageCommand=cmd(playcommand,"Close");
		PlayerJoinedMessageCommand=cmd(playcommand,"Close");
		CancelMessageCommand=cmd(playcommand,"Close");
		CloseCommand=cmd(queuemessage,"ReturnWheel");

		Def.ActorFrame{
			SetMessageCommand=function(self,params)
			local song = params.Song;
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber());
				if song then
					if steps then
						if song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ) then
							self:stoptweening()
							self:zoom(1)
							self:diffuse(1,1,1,1)
						else
							self:stoptweening()
							self:zoom(0.9)
							self:diffuse(0.6,0.6,0.6,1)
						end
					end
				end
			end;
		
			LoadActor("SelectMusic/WheelHighlight")..{
			InitCommand=cmd(horizalign,left;zoom,0.5;shadowlength,3);
			SetMessageCommand=function(self,params)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber());
			if steps then
				self:diffuse( CustomDifficultyToColor( steps:GetDifficulty() ) )
			end
			end,
			};
	
			LoadActor("SelectMusic/Base_WheelSong")..{
			OnCommand=cmd(horizalign,left;zoom,0.5);
			};
	
			LoadActor("SelectMusic/Color_WheelSong")..{
			OnCommand=cmd(horizalign,left;zoom,0.5);
			SetMessageCommand=function(self,params)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber());
			if steps then
				self:diffuse( CustomDifficultyToColor( steps:GetDifficulty() ) )
			end
			end,
			};
	
			LoadActor("SelectMusic/Star_WheelSong")..{
			OnCommand=cmd(horizalign,left;zoom,0.6;y,-2;x,-15;shadowlengthy,2);
			SetMessageCommand=function(self,params)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber());
			if steps then
				self:diffuse( CustomDifficultyToColor( steps:GetDifficulty() ) )
			end
			end,
			};
	
			LoadFont("renner/20px") ..{
			Text="This is test";
			OnCommand=cmd(x,110;y,-14;horizalign,left;shadowlength,1;strokecolor,Color.Black;maxwidth,430);
			SetMessageCommand=function(self,params)
				local song = params.Song;
				if song then
					self:settext( song:GetDisplayMainTitle() );
				else
					self:settext("")
				end;
			end;
			};
	
			LoadFont("proto sans 33") ..{
			Text="This is test";
			OnCommand=cmd(x,500;y,-30;zoom,0.8;horizalign,right;shadowlength,1;strokecolor,Color.Blue);
			SetMessageCommand=function(self,params)
				local song = params.Song;
				if song then
					if string.len(song:GetGenre()) > 1 then
						self:settext( song:GetGenre() );
					else
						self:settext( "No Genre" );
					end
				else
					self:settext("")
				end;
			end;
			};

			LoadFont("renner/20px") ..{
			Text="This is test";
			OnCommand=cmd(x,530;y,-30;zoom,0.8;shadowlength,1;strokecolor,Color.Blue);
			SetMessageCommand=function(self,params)
				local song = params.Song;
				if song and PROFILEMAN:IsSongNew(params.Song) then
					self:settext("NEW!")
					self:diffuse(Color.Red)
					self:strokecolor( Color.Orange )
				else
					self:settext("")
				end;
			end;
			};
	
			LoadFont("unsteady oversteer") ..{
			Text="This is test";
			OnCommand=cmd(x,80;y,-10;zoom,1.2;strokecolor,Color.Black);
			SetMessageCommand=function(self,params)
				local song = params.Song;
				local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber());
				if song then
					if steps then
						if song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ) then
							self:settext( song:GetOneSteps(steps:GetStepsType(), steps:GetDifficulty() ):GetMeter() );
						else
							self:settext( " " )
						end
					end
				else
					self:settext("")
				end;
			end;
			};

			Def.ActorFrame{
			SetMessageCommand=function(self,params)
			local song = params.Song;
			self:visible(false)
			if song then
				if song:IsLong() then
					self:visible(true)
				end
				if song:IsMarathon() then
					self:visible(true)
				end
			end
			end;

				LoadActor("SelectMusic/WheelNotify/SongDuration")..{
				OnCommand=cmd(horizalign,left;zoom,1;y,16;x,150;shadowlengthy,2);
				SetMessageCommand=function(self,params)
				local song = params.Song;
				if song then
					if song:IsLong() then
						self:diffuse(Color.Orange)
					end
					if song:IsMarathon() then
						self:diffuse(Color.Red)
					end
				end
				end,
				};
	
				LoadFont("unsteady oversteer") ..{
				Text="This is test";
				OnCommand=cmd(x,170;y,6;zoom,1.2;strokecolor,Color.Black);
				SetMessageCommand=function(self,params)
				local song = params.Song;
				if song then
					if song:IsLong() then
						self:strokecolor( ColorDarkTone(Color.Orange) )
						self:settext( "2" )
					end
					if song:IsMarathon() then
						self:strokecolor( ColorDarkTone(Color.Red) )
						self:settext( "3" )
					end
				end
				end,
				};

				LoadFont("renner/20px") ..{
				Text="Stages";
				OnCommand=cmd(x,210;y,18;zoom,0.8;strokecolor,Color.Black);
				SetMessageCommand=function(self,params)
				local song = params.Song;
				if song then
					if song:IsLong() then
						self:strokecolor( ColorDarkTone(Color.Orange) )
					end
					if song:IsMarathon() then
						self:strokecolor( ColorDarkTone(Color.Red) )
					end
				end
				end,
				};

			};

			Def.ActorFrame{
			SetMessageCommand=function(self,params)
			local song = params.Song;
			self:visible(false)
			if song then
				local bpms = song:GetDisplayBpms()
				if bpms[1] ~= bpms[2] then
					self:visible(true)
				end
			end
			end;

				LoadActor("SelectMusic/WheelNotify/BPMChanges")..{
				OnCommand=cmd(horizalign,left;zoom,1;y,16;x,105;shadowlengthy,2);
				SetMessageCommand=function(self,params)
				local song = params.Song;
				if song then
					if song:IsLong() then
						self:diffuse(Color.Orange)
					end
					if song:IsMarathon() then
						self:diffuse(Color.Red)
					end
				end
				end,
				};

				Def.BitmapText{
				Font="unsteady oversteer",
				OnCommand=cmd(zoom,0.6;strokecolor,color("0,0,0,1");wrapwidthpixels,500;x,128;vertspacing,-8;y,12);
				SetMessageCommand=function(self,params)
					local song = params.Song;
					local val
					if song then
						local bpms = song:GetDisplayBpms()
						val = string.format("%i \n %i",bpms[1],bpms[2])
					else
						val = " "
					end
					self:settext(val)
				end;
				},

			};

		};

	};
	
return t;