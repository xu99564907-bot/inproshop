

//AAS实例化
FB_AAS_Instance[1](
	iMode:= DB7000_Control.Mode, 
	iCameraNum:= 12, //相机通道数量
	iDstAdr:= '192.168.1.100', 
	iDstTcpPort:= 503, 
	iRecipeNum:= DB7002_Recipe.RecipeName, 
	ioAAS:= DB7050_DriveControl.AAS[1], 
	oTimeOut=> );
	
	
	
	
	
	