PROGRAM OP50_Control
VAR
	FB_ModeControl_instance:FB_ModeControl_V1;
	FB_Count_instance:ARRAY[0..2] OF FB_Count;
END_VAR

(**********模式切换功能***********)
FB_ModeControl_instance(
	iClock:= CPU_Clock, 
	iStartDelay:= T#100MS, 
	iEstop:=DB5070_Fault.EstopTotal, 
	iAlam:=DB5070_Fault.StopTotal,
	iWarn:=DB5070_Fault.RunTotal,
	ioMachine:= DB5000_Control.Machine, 
	ioMode:=DB5000_Control.Mode);

(********************计数****************************)
//总计数
FB_Count_instance[0](
	ioCount:= DB5003_Count.Total, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//OK计数
FB_Count_instance[1](
	ioCount:= DB5003_Count.OK, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//NG计数
FB_Count_instance[2](
	ioCount:= DB5003_Count.NG, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);


(***********良率计算***********)
//良率统计
IF DB5003_Count.Total.Today.Total<>0 THEN
	DB5003_Count.Yield:=DB5003_Count.OK.Today.Total/DB5003_Count.Total.Today.Total;
ELSE
	DB5003_Count.Yield:=0;
END_IF
//良率清零
IF DB5003_Count.Clear THEN
	DB5003_Count.Total.Today.Total:=0;
	DB5003_Count.OK.Today.Total:=0;
	DB5003_Count.NG.Today.Total:=0;
	DB5003_Count.Clear:=FALSE;
END_IF


(********程序调用*******)
OP50_DI_Mirror();
OP50_Communication();
OP50_Recipe();
OP50_Graph();
OP50_DriveControl();
OP50_DO_Mirror();
OP50_Fault();
OP50_Other();
