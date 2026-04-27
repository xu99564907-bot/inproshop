PROGRAM OP40_Control
VAR
	FB_ModeControl_instance:FB_ModeControl_V1;
	FB_Count_instance:ARRAY[0..2] OF FB_Count;
END_VAR

(**********模式切换功能***********)
FB_ModeControl_instance(
	iClock:= CPU_Clock, 
	iStartDelay:= T#100MS, 
	iEstop:=DB4070_Fault.EstopTotal, 
	iAlam:=DB4070_Fault.StopTotal,
	iWarn:=DB4070_Fault.RunTotal,
	ioMachine:= DB4000_Control.Machine, 
	ioMode:=DB4000_Control.Mode);

(********************计数****************************)
//总计数
FB_Count_instance[0](
	ioCount:= DB4003_Count.Total, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//OK计数
FB_Count_instance[1](
	ioCount:= DB4003_Count.OK, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//NG计数
FB_Count_instance[2](
	ioCount:= DB4003_Count.NG, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);


(***********良率计算***********)
//良率统计
IF DB4003_Count.Total.Today.Total<>0 THEN
	DB4003_Count.Yield:=DB4003_Count.OK.Today.Total/DB4003_Count.Total.Today.Total;
ELSE
	DB3003_Count.Yield:=0;
END_IF
//良率清零
IF DB4003_Count.Clear THEN
	DB4003_Count.Total.Today.Total:=0;
	DB4003_Count.OK.Today.Total:=0;
	DB4003_Count.NG.Today.Total:=0;
	DB4003_Count.Clear:=FALSE;
END_IF


(********程序调用*******)
OP40_DI_Mirror();
OP40_Communication();
OP40_Recipe();
OP40_Graph();
OP40_DriveControl();
OP40_DO_Mirror();
OP40_Fault();
OP40_Other();
