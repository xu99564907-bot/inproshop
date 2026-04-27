

//AAS实例化
FB_AAS_Instance[1](
	iMode:= DB1100_Control.Mode, 
	iCameraNum:= 12, //相机通道数量
	iDstAdr:= '192.168.1.100', 
	iDstTcpPort:= 503, 
	iRecipeNum:= DB1102_Recipe.RecipeName, 
	ioAAS:= DB1150_DriveControl.AAS[1], 
	oTimeOut=> );
	
	
	
	
	
	