

// //实例化
// FB_Rotdisk_V1_Instance[1](
// 	iName:="检测凸轮",
// 	iEstop:=DB8000_Control.Machine.EmgSafetyRelay,
// 	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay, 
// 	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay, 
// 	iSensor:= %IX1003.1, 
// 	iAuto:= DB8000_Control.Mode.Status.AutoMode, 
// 	iReset:= DB8000_Control.Mode.Out.ErrorReset, 
// 	iIC:= TRUE, 
// 	iClock_100ms:= CPU_Clock.Clock_100ms_R, 
// 	iTimeDelay:= 100, //单位100ms
// 	iORotdisk:= DB8050_DriveControl.Rotdisk[1], 
// 	oMotor=> %QX1003.1);
