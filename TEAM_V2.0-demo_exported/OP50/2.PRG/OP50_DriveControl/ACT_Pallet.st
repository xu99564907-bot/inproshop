
// //码垛1
// FB_Palletizing_Instance[1](
// 	iClock:= CPU_Clock, 
// 	iMode:= DB3000_Control.Mode, 
// 	iEstop:= DB3000_Control.Machine.EmgSafetyRelay, 
// 	iLightCurtain:=IX8700_4_码垛区域1安全光栅,
// 	iSensor:= IX8700_3_码垛区域1托盘到位检测Sensor154, 
// 	iRequestButton:= IX8700_5_码垛区域1上下托盘请求, 
// 	iFinishButton:= IX8700_6_码垛区域1托盘请求完成, 
// 	iRobotInStep:= OP30_Graph.Auto[6].Running AND NOT OP30_Graph.PartitionInRobot, 
// 	oRequestButtonLamp=> QX8700_5_码垛区域1上托盘按钮指示灯, 
// 	oFinishButtonLamp=> QX8700_6_码垛区域1下托盘按钮指示灯, 
// 	ioPalletizing:= DB3050_DriveControl.PalletCtrl[1]);
// 	
//  
