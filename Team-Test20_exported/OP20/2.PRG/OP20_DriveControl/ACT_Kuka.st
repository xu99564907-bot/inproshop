


FB_Kuka_V1_Instance[1](
	ioKuka:= DB2050_DriveControl.Kuka[1], 
	iMode:= DB2000_Control.Mode, 
	iName:="上料机械手",
	iSpeed:=DB2000_Control.Machine.Speed,
	iProductType:=DB2002_Recipe.RecipeNum,
	inputAddres:=TempKUKA1InPut,
	outputAddres=>TempKUKA1OutPut,
	oTimeOut=> );



 