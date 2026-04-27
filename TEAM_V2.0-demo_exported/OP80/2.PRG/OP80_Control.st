PROGRAM OP80_Control
VAR
	FB_ModeControl_instance:FB_ModeControl_V1;
	FB_Count_instance:ARRAY[0..2] OF FB_Count;
END_VAR

(**********模式切换功能***********)
FB_ModeControl_instance(
	iClock:= CPU_Clock, 
	iStartDelay:= T#100MS, 
	iEstop:=DB8070_Fault.EstopTotal, 
	iAlam:=DB8070_Fault.StopTotal,
	iWarn:=DB8070_Fault.RunTotal,
	ioMachine:= DB8000_Control.Machine, 
	ioMode:=DB8000_Control.Mode);

(********************计数****************************)
//总计数
FB_Count_instance[0](
	ioCount:= DB8003_Count.Total, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//OK计数
FB_Count_instance[1](
	ioCount:= DB8003_Count.OK, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//NG计数
FB_Count_instance[2](
	ioCount:= DB8003_Count.NG, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);


(***********良率计算***********)
//良率统计
IF DB8003_Count.Total.Today.Total<>0 THEN
	DB8003_Count.Yield:=DB8003_Count.OK.Today.Total/DB8003_Count.Total.Today.Total;
ELSE
	DB8003_Count.Yield:=0;
END_IF
//良率清零
IF DB8003_Count.Clear THEN
	DB8003_Count.Total.Today.Total:=0;
	DB8003_Count.OK.Today.Total:=0;
	DB8003_Count.NG.Today.Total:=0;
	DB8003_Count.Clear:=FALSE;
END_IF


(********程序调用*******)
OP80_DI_Mirror();
OP80_Communication();
OP80_Recipe();
OP80_Graph();
OP80_DriveControl();
OP80_DO_Mirror();
OP80_Fault();
OP80_Other();
