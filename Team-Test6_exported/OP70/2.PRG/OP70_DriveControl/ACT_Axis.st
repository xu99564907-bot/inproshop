


// //轴实例化
// FB_Axis_Instance[1](
// 	ioAxis:=  , 
// 	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[1], 
// 	iName:="上料X1轴",
// 	iEstop:= DB7000_Control.Machine.EmgSafetyRelay, 
// 	iSafeDoor:= DB7000_Control.Machine.SafetyDoorRelay, 
// 	iLightCurtain:=NOT DB7070_Fault.Run.LightCurtain, 
// 	iMode:= DB7000_Control.Mode, 
// 	iSpeed:= DB7000_Control.Machine.Speed, 
// 	iIntermediateStop:= TRUE, 
// 	iIC_Home:= TRUE,
// 	iIC_ABS:= TRUE,
// 	iIC_JOG:= TRUE
// 	);
// 
// 	
// 	
// 	
	
	
	
	

FB_Axis_Instance[1](
	ioAxis:= Axis_1,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[1],
	iName:="上料X1轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[2](
	ioAxis:= Axis_2,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[2],
	iName:="同步X2轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[3](
	ioAxis:= Axis_3,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[3],
	iName:="同步X3轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[4](
	ioAxis:= Axis_4,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[4],
	iName:="锁付1X4轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[5](
	ioAxis:= Axis_5,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[5],
	iName:="锁付1Y1轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[6](
	ioAxis:= Axis_6,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[6],
	iName:="锁付1Z1轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[7](
	ioAxis:= Axis_7,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[7],
	iName:="锁付2X5轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[8](
	ioAxis:= Axis_8,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[8],
	iName:="锁付2Y2轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[9](
	ioAxis:= Axis_9,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[9],
	iName:="锁付2Z2轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[10](
	ioAxis:= Axis_10,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[10],
	iName:="锁付3X6轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[11](
	ioAxis:= Axis_11,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[11],
	iName:="锁付3Y3轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[12](
	ioAxis:= Axis_12,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[12],
	iName:="锁付3Z3轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////

FB_Axis_Instance[13](
	ioAxis:= Axis_13,
	ioAxisCtrl:= DB7050_DriveControl.AxisCtrl[13],
	iName:="锁付3Z4轴",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB7000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay,
	iMode:= DB7000_Control.Mode,
	iSpeed:= DB7000_Control.Machine.Speed,
	iIntermediateStop:= TRUE,
	iIC_Home:= TRUE,
	iIC_ABS:= TRUE,
	iIC_JOG:= TRUE);
///////
///////
///////
