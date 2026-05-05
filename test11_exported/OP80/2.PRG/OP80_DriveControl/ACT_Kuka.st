


FB_Kuka_V1_Instance[1](
	ioKuka:= DB8050_DriveControl.Kuka[1], 
	iMode:= DB8000_Control.Mode, 
	iName:="上料机械手",
	iSpeed:=DB8000_Control.Machine.Speed,
	iProductType:=DB8002_Recipe.RecipeNum,
	inputAddres:=TempKUKA1InPut,
	outputAddres=>TempKUKA1OutPut,
	oTimeOut=> );

