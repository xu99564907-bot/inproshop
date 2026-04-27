PROGRAM OP11_Control
VAR
	FB_ModeControl_instance:FB_ModeControl_V1;
	FB_Count_instance:ARRAY[0..2] OF FB_Count;
END_VAR

(**********模式切换功能***********)
FB_ModeControl_instance(
	iClock:= CPU_Clock, 
	iStartDelay:= T#100MS, 
	iEstop:=DB1170_Fault.EstopTotal, 
	iAlam:=DB1170_Fault.StopTotal,
	iWarn:=DB1170_Fault.RunTotal,
	ioMachine:= DB1100_Control.Machine, 
	ioMode:=DB1100_Control.Mode);

(********************计数****************************)
//总计数
FB_Count_instance[0](
	ioCount:= DB1103_Count.Total, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//OK计数
FB_Count_instance[1](
	ioCount:= DB1103_Count.OK, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);

//NG计数
FB_Count_instance[2](
	ioCount:= DB1103_Count.NG, 
	iClock:= CPU_Clock, 
	iDayStartTime:= CPU_Clock.DayStartTime, 
	iNightStartTime:=CPU_Clock.NightStartTime);


(***********良率计算***********)
//良率统计
IF DB1103_Count.Total.Today.Total<>0 THEN
	DB1103_Count.Yield:=DB1103_Count.OK.Today.Total/DB1103_Count.Total.Today.Total;
ELSE
	DB1103_Count.Yield:=0;
END_IF
//良率清零
IF DB1103_Count.Clear THEN
	DB1103_Count.Total.Today.Total:=0;
	DB1103_Count.OK.Today.Total:=0;
	DB1103_Count.NG.Today.Total:=0;
	DB1103_Count.Clear:=FALSE;
END_IF


(********程序调用*******)
OP11_DI_Mirror();
OP11_Communication();
OP11_Recipe();
OP11_Graph();
OP11_DriveControl();
OP11_DO_Mirror();
OP11_Fault();
OP11_Other();
