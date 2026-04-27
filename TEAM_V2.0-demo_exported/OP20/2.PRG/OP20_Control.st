PROGRAM OP20_Control
VAR
	FB_ModeControl_instance:FB_ModeControl_V1;
	FB_Count_instance:ARRAY[0..2] OF FB_Count;
END_VAR

(**********模式切换功能***********)
FB_ModeControl_instance(
	iClock:= CPU_Clock, 
	iStartDelay:= T#100MS, 
	iEstop:=DB2070_Fault.EstopTotal, 
	iAlam:=DB2070_Fault.StopTotal,
	iWarn:=DB2070_Fault.RunTotal,
	ioMachine:= DB2000_Control.Machine, 
	ioMode:=DB2000_Control.Mode);

(********************计数****************************)
//总计数
FB_Count_instance[0](
	ioCount:= DB2003_Count.Total, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//OK计数
FB_Count_instance[1](
	ioCount:= DB2003_Count.OK, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//NG计数
FB_Count_instance[2](
	ioCount:= DB2003_Count.NG, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);


(***********良率计算***********)
//良率统计
IF DB2003_Count.Total.Today.Total<>0 THEN
	DB2003_Count.Yield:=DB2003_Count.OK.Today.Total/DB2003_Count.Total.Today.Total;
ELSE
	DB2003_Count.Yield:=0;
END_IF
//良率清零
IF DB2003_Count.Clear THEN
	DB2003_Count.Total.Today.Total:=0;
	DB2003_Count.OK.Today.Total:=0;
	DB2003_Count.NG.Today.Total:=0;
	DB2003_Count.Clear:=FALSE;
END_IF


(********程序调用*******)
OP20_DI_Mirror();
OP20_Communication();
OP20_Recipe();
OP20_Graph();
OP20_DriveControl();
OP20_DO_Mirror();
OP20_Fault();
OP20_Other();
