


//模拟量输入实例化
FB_AI_Instance[1](
	iValueInput:= WORD_TO_INT(%IW500), 
	iADMin:= 0, 
	iADMax:= 27648, 
	iUserMin:= 4.0, 
	iUserMax:= 20.0, 
	ioAI:= DB7050_DriveControl.AI[1], 
	oValueUser=> ,
	oError=>);
