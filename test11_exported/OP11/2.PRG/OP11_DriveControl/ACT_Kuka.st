


FB_Kuka_V1_Instance[1](
	ioKuka:= DB1150_DriveControl.Kuka[1], 
	iMode:= DB1100_Control.Mode, 
	iName:="上料机械手",
	iSpeed:=DB1100_Control.Machine.Speed,
	iProductType:=DB1102_Recipe.RecipeNum,
	inputAddres:=TempKUKA1InPut,
	outputAddres=>TempKUKA1OutPut,
	oTimeOut=> );

 