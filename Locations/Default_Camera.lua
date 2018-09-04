local t = Def.ActorFrame{}

t.InitialTweenMessageCommand=function(self)
	Camera:addz(-40):decelerate(3):addz(40)
end
t.Camera1MessageCommand=function(self)
	CAMERA:ResetCamera()
	Camera:rotationx(30):spin()
	:effectmagnitude(0,10,0)
end
t.Camera2MessageCommand=function(self)
	CAMERA:ResetCamera()
	Camera:rotationy(45):rotationx(20):rotationz(-30)
end
t.Camera3MessageCommand=function(self)
	CAMERA:ResetCamera()
	Camera:rotationy(140):rotationz(10):rotationx(-10)
end
t.Camera4MessageCommand=function(self)
	CAMERA:ResetCamera()
	Camera:rotationy(210):rotationx(25)
end
t.Camera5MessageCommand=function(self)
	CAMERA:ResetCamera()
	Camera:rotationx(70)
	:z(WideScale(190,290))
end

return t;