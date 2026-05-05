

//温控实例化
FB_Heating_Instance[1](
	iReset:= DB4000_Control.Mode.Out.ErrorReset, 
	iPV:= , 
	iSV_MAX:= 80.0, 
	iPV_MAX:=100.0 , 
	ICycleTime:= 1000, //PID控制周期时间，单位ms
	ioHeating:= DB4050_DriveControl.HeatCtrl[1], 
	Active=> %QX1010.0);






