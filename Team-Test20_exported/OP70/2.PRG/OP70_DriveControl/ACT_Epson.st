



FB_Epson_V1_Instance[1](
	ioEpson:= DB7050_DriveControl.Epson[1], 
	iMode:= DB7000_Control.Mode, 
	iName:="上料机械手",
	iDstAdr:='192.168.1.11',//IP地址
	iDstTcpPort:=502,//端口号
	iSpeed:=DB7000_Control.Machine.Speed,
	iProductType:=DB7002_Recipe.RecipeNum,
	iClock:=CPU_Clock.Clock_10ms_R,
	oTimeOut=> );
	