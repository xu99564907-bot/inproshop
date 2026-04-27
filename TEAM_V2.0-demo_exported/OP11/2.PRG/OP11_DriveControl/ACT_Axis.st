


//轴实例化
FB_Axis_Instance[1](
	ioAxis:= Axis_气密测试S1轴, 
	ioAxisCtrl:= DB1150_DriveControl.AxisCtrl[1], 
	iName:="气密测试S1轴",
	iEstop:=TRUE,// DB8000_Control.Machine.EmgSafetyRelay, 
	iSafeDoor:=TRUE,// DB8000_Control.Machine.EmgSafetyRelay, 
	iLightCurtain:=TRUE,// DB8000_Control.Machine.LightCurtainRelay, 
	iMode:= DB1100_Control.Mode, 
	iSpeed:= DB1100_Control.Machine.Speed, 
	iIntermediateStop:= TRUE, 
	iIC_Home:= TRUE,
	iIC_ABS:=TRUE,
	iIC_JOG:= TRUE
	);

	
	
	