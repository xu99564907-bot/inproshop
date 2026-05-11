PROGRAM OP10_Control
VAR
	FB_ModeControl_instance:FB_ModeControl_V1;
	FB_Count_instance:ARRAY[0..2] OF FB_Count;
END_VAR

(**********模式切换功能***********)
FB_ModeControl_instance(
	iClock:= CPU_Clock, 
	iStartDelay:= T#100MS, 
	iEstop:=DB1070_Fault.EstopTotal, 
	iAlam:=DB1070_Fault.StopTotal,
	iWarn:=DB1070_Fault.RunTotal,
	ioMachine:= DB1000_Control.Machine, 
	ioMode:=DB1000_Control.Mode);

(********************计数****************************)
//总计数
FB_Count_instance[0](
	ioCount:= DB1003_Count.Total, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//OK计数
FB_Count_instance[1](
	ioCount:= DB1003_Count.OK, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//NG计数
FB_Count_instance[2](
	ioCount:= DB1003_Count.NG, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);


(***********良率计算***********)
//良率统计
IF DB1003_Count.Total.Today.Total<>0 THEN
	DB1003_Count.Yield:=DB1003_Count.OK.Today.Total/DB1003_Count.Total.Today.Total;
ELSE
	DB1003_Count.Yield:=0;
END_IF
//良率清零
IF DB1003_Count.Clear THEN
	DB1003_Count.Total.Today.Total:=0;
	DB1003_Count.OK.Today.Total:=0;
	DB1003_Count.NG.Today.Total:=0;
	DB1003_Count.Clear:=FALSE;
END_IF


(********程序调用*******)
OP10_DI_Mirror();
OP10_Communication();
OP10_Recipe();
OP10_Graph();
OP10_DriveControl();
OP10_DO_Mirror();
OP10_Fault();
OP10_Other();
