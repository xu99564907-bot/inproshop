PROGRAM OP70_Control
VAR
	FB_ModeControl_instance:FB_ModeControl_V1;
	FB_Count_instance:ARRAY[0..2] OF FB_Count;
END_VAR

(**********模式切换功能***********)
FB_ModeControl_instance(
	iClock:= CPU_Clock, 
	iStartDelay:= T#0.1S, 
	iEstop:=DB7070_Fault.EstopTotal, 
	iAlam:=DB7070_Fault.StopTotal,
	iWarn:=DB7070_Fault.RunTotal,
	ioMachine:= DB7000_Control.Machine, 
	ioMode:=DB7000_Control.Mode);

(********************计数****************************)
//总计数
FB_Count_instance[0](
	ioCount:= DB7003_Count.Total, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//OK计数
FB_Count_instance[1](
	ioCount:= DB7003_Count.OK, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//NG计数
FB_Count_instance[2](
	ioCount:= DB7003_Count.NG, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);


(***********良率计算***********)
//良率统计
IF DB7003_Count.Total.Today.Total<>0 THEN
	DB7003_Count.Yield:=DB7003_Count.OK.Today.Total/DB7003_Count.Total.Today.Total;
ELSE
	DB7003_Count.Yield:=0;
END_IF
//良率清零
IF DB7003_Count.Clear THEN
	DB7003_Count.Total.Today.Total:=0;
	DB7003_Count.OK.Today.Total:=0;
	DB7003_Count.NG.Today.Total:=0;
	DB7003_Count.Clear:=FALSE;
END_IF


(********程序调用*******)
OP70_DI_Mirror();
OP70_Communication();
OP70_Recipe();
OP70_Graph();
OP70_DriveControl();
OP70_DO_Mirror();
OP70_Fault();

