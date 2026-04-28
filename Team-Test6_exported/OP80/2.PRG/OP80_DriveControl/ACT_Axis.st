


//轴实例化
FB_Axis_Instance[1](
	ioAxis:= Axis_气密测试S1轴, 
	ioAxisCtrl:= DB8050_DriveControl.AxisCtrl[1], 
	iName:="气密测试S1轴",
	iEstop:=TRUE,// DB8000_Control.Machine.EmgSafetyRelay, 
	iSafeDoor:=TRUE,// DB8000_Control.Machine.EmgSafetyRelay, 
	iLightCurtain:=TRUE,// DB8000_Control.Machine.LightCurtainRelay, 
	iMode:= DB8000_Control.Mode, 
	iSpeed:= DB8000_Control.Machine.Speed, 
	iIntermediateStop:= TRUE, 
	iIC_Home:= TRUE,
	iIC_ABS:=TRUE,
	iIC_JOG:= TRUE
	);


	
	
	
	

FB_Axis_Instance[0](
	ioAxis:= Axis_0,
	ioAxisCtrl:= DB8050_DriveControl.AxisCtrl[0],
	iName:="虚主轴",
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iMode:= DB8000_Control.Mode,
	iSpeed:= DB8000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[1](
	ioAxis:= Axis_1,
	ioAxisCtrl:= DB8050_DriveControl.AxisCtrl[1],
	iName:="气密测试S1轴",
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iMode:= DB8000_Control.Mode,
	iSpeed:= DB8000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[2](
	ioAxis:= Axis_2,
	ioAxisCtrl:= DB8050_DriveControl.AxisCtrl[2],
	iName:="气密测试Z1轴",
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iMode:= DB8000_Control.Mode,
	iSpeed:= DB8000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[3](
	ioAxis:= Axis_3,
	ioAxisCtrl:= DB8050_DriveControl.AxisCtrl[3],
	iName:="气密测试S2轴",
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iMode:= DB8000_Control.Mode,
	iSpeed:= DB8000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[4](
	ioAxis:= Axis_4,
	ioAxisCtrl:= DB8050_DriveControl.AxisCtrl[4],
	iName:="气密测试Z2轴",
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iMode:= DB8000_Control.Mode,
	iSpeed:= DB8000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[5](
	ioAxis:= Axis_5,
	ioAxisCtrl:= DB8050_DriveControl.AxisCtrl[5],
	iName:="气密测试S3轴",
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iMode:= DB8000_Control.Mode,
	iSpeed:= DB8000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[6](
	ioAxis:= Axis_6,
	ioAxisCtrl:= DB8050_DriveControl.AxisCtrl[6],
	iName:="气密测试Z3轴",
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iMode:= DB8000_Control.Mode,
	iSpeed:= DB8000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[7](
	ioAxis:= Axis_7,
	ioAxisCtrl:= DB8050_DriveControl.AxisCtrl[7],
	iName:="气密测试S4轴",
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iMode:= DB8000_Control.Mode,
	iSpeed:= DB8000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[8](
	ioAxis:= Axis_8,
	ioAxisCtrl:= DB8050_DriveControl.AxisCtrl[8],
	iName:="气密测试Z4轴",
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iMode:= DB8000_Control.Mode,
	iSpeed:= DB8000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[9](
	ioAxis:= Axis_9,
	ioAxisCtrl:= DB8050_DriveControl.AxisCtrl[9],
	iName:="上料机械臂X1轴",
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iMode:= DB8000_Control.Mode,
	iSpeed:= DB8000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[11](
	ioAxis:= Axis_11,
	ioAxisCtrl:= DB8050_DriveControl.AxisCtrl[11],
	iName:="码垛机械臂X2轴",
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iMode:= DB8000_Control.Mode,
	iSpeed:= DB8000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////
