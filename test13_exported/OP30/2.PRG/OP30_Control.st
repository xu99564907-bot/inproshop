PROGRAM OP30_Control
VAR
	FB_ModeControl_instance:FB_ModeControl_V1;
	FB_Count_instance:ARRAY[0..2] OF FB_Count;
END_VAR

(**********模式切换功能***********)
FB_ModeControl_instance(
	iClock:= CPU_Clock, 
	iStartDelay:= T#100MS, 
	iEstop:=DB3070_Fault.EstopTotal, 
	iAlam:=DB3070_Fault.StopTotal,
	iWarn:=DB3070_Fault.RunTotal,
	ioMachine:= DB3000_Control.Machine, 
	ioMode:=DB3000_Control.Mode);

(********************计数****************************)
//总计数
FB_Count_instance[0](
	ioCount:= DB3003_Count.Total, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//OK计数
FB_Count_instance[1](
	ioCount:= DB3003_Count.OK, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//NG计数
FB_Count_instance[2](
	ioCount:= DB3003_Count.NG, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);


(***********良率计算***********)
//良率统计
IF DB3003_Count.Total.Today.Total<>0 THEN
	DB3003_Count.Yield:=DB3003_Count.OK.Today.Total/DB3003_Count.Total.Today.Total;
ELSE
	DB3003_Count.Yield:=0;
END_IF
//良率清零
IF DB3003_Count.Clear THEN
	DB3003_Count.Total.Today.Total:=0;
	DB3003_Count.OK.Today.Total:=0;
	DB3003_Count.NG.Today.Total:=0;
	DB3003_Count.Clear:=FALSE;
END_IF


(********程序调用*******)
OP30_DI_Mirror();
OP30_Communication();
OP30_Recipe();
OP30_Graph();
OP30_DriveControl();
OP30_DO_Mirror();
OP30_Fault();
OP30_Other();
