PROGRAM OP60_Control
VAR
	FB_ModeControl_instance:FB_ModeControl_V1;
	FB_Count_instance:ARRAY[0..2] OF FB_Count;
END_VAR

(**********模式切换功能***********)
FB_ModeControl_instance(
	iClock:= CPU_Clock, 
	iStartDelay:= T#100MS, 
	iEstop:=DB6070_Fault.EstopTotal, 
	iAlam:=DB6070_Fault.StopTotal,
	iWarn:=DB6070_Fault.RunTotal,
	ioMachine:= DB6000_Control.Machine, 
	ioMode:=DB6000_Control.Mode);

(********************计数****************************)
//总计数
FB_Count_instance[0](
	ioCount:= DB6003_Count.Total, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//OK计数
FB_Count_instance[1](
	ioCount:= DB6003_Count.OK, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//NG计数
FB_Count_instance[2](
	ioCount:= DB6003_Count.NG, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);


(***********良率计算***********)
//良率统计
IF DB6003_Count.Total.Today.Total<>0 THEN
	DB6003_Count.Yield:=DB6003_Count.OK.Today.Total/DB6003_Count.Total.Today.Total;
ELSE
	DB6003_Count.Yield:=0;
END_IF
//良率清零
IF DB6003_Count.Clear THEN
	DB6003_Count.Total.Today.Total:=0;
	DB6003_Count.OK.Today.Total:=0;
	DB6003_Count.NG.Today.Total:=0;
	DB6003_Count.Clear:=FALSE;
END_IF


(********程序调用*******)
OP60_DI_Mirror();
OP60_Communication();
OP60_Recipe();
OP60_Graph();
OP60_DriveControl();
OP60_DO_Mirror();
OP60_Fault();
OP60_Other();
