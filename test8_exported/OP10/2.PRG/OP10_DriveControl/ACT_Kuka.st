


FB_Kuka_V1_Instance[1](
	ioKuka:= DB1050_DriveControl.Kuka[1], 
	iMode:= DB1000_Control.Mode, 
	iName:="上料机械手",
	iSpeed:=DB1000_Control.Machine.Speed,
	iProductType:=DB1002_Recipe.RecipeNum,
	inputAddres:=TempKUKA1InPut,
	outputAddres=>TempKUKA1OutPut,
	oTimeOut=> );


 