
// 
// //上料缓存挡停
// FB_Stopper_V1_Instance[1](
// 	iAuto:= DB8000_Control.Mode.Status.AutoMode, 
// 	iReset:=  DB8000_Control.Mode.Out.ErrorReset, 
// 	iSensor1:= %IX1004.0, 
// 	iSensor2:= %IX1004.1, 
// 	iCylFor:= TRUE, 
// 	iCylBack:= TRUE, 
// 	iMotor:= DB8050_DriveControl.Motor[1].DevStatus.MotorFor, 
// 	iBuffer:= TRUE, 
// 	iStationHome:= TRUE, 
// 	iTimes:= 2, 
// 	iMode:= 1, 
// 	iEachTimes:= 0, 
// 	iGoInOutTogether:= 1, 
// 	iTimeDelay:= T#50MS, 
// 	oCylFor=> , 
// 	oCylBack=> %QX1004.0, 
// 	oTimeOut=> , 
// 	ioCurStaData:= DB8050_DriveControl.Stopper[1], 
// 	ioNextStaData:= DB8050_DriveControl.Stopper[2]);
// 
// //上料组装挡停
// FB_Stopper_V1_Instance[1](
// 	iAuto:= DB8000_Control.Mode.Status.AutoMode, 
// 	iReset:=  DB8000_Control.Mode.Out.ErrorReset, 
// 	iSensor1:= %IX1004.2, 
// 	iSensor2:= %IX1004.3, 
// 	iCylFor:= TRUE, 
// 	iCylBack:= TRUE, 
// 	iMotor:= DB8050_DriveControl.Motor[1].DevStatus.MotorFor, 
// 	iBuffer:= FALSE, 
// 	iStationHome:= DB8050_DriveControl.CylCtrl[2].Status.InHome, 
// 	iTimes:= 2, 
// 	iMode:= 1, 
// 	iEachTimes:= 0, 
// 	iGoInOutTogether:= 1, 
// 	iTimeDelay:= T#50MS, 
// 	oCylFor=> , 
// 	oCylBack=> %QX1004.1, 
// 	oTimeOut=> , 
// 	ioCurStaData:= DB8050_DriveControl.Stopper[2], 
// 	ioNextStaData:= DB8050_DriveControl.Stopper[3]);
// 
// 
// 
// 
