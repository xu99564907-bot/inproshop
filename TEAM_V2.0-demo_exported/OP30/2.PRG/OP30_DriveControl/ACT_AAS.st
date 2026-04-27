

//AAS实例化
FB_AAS_Instance[1](
	iMode:= DB3000_Control.Mode, 
	iCameraNum:= 12, //相机通道数量
	iDstAdr:= '192.168.1.100', 
	iDstTcpPort:= 503, 
	iRecipeNum:= DB3002_Recipe.RecipeName, 
	ioAAS:= DB3050_DriveControl.AAS[1], 
	oTimeOut=> );
	
	
	
	
	
	