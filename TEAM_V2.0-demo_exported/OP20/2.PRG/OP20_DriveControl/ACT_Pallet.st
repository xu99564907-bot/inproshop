
//码垛1
FB_Palletizing_Instance[1](
	iClock:= CPU_Clock, 
	iMode:= DB2000_Control.Mode, 
	iEstop:= DB2000_Control.Machine.EmgSafetyRelay, 
	iLightCurtain:= ,
	iSensor:=  , 
	iRequestButton:=  , 
	iFinishButton:=  , 
	iRobotInStep:= OP20_Graph.Auto[6].Running AND NOT OP20_Graph.PartitionInRobot, 
	oRequestButtonLamp=>  , 
	oFinishButtonLamp=>  , 
	ioPalletizing:= DB2050_DriveControl.PalletCtrl[1]);
 