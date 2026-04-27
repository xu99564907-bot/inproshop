PROGRAM PLC_PRG
VAR
	Temp_pulse_on_R:R_TRIG;
	Temp_clock_10ms_R:R_TRIG;
	Temp_clock_50ms_R:R_TRIG;	
	Temp_clock_100ms_R:R_TRIG;
	Temp_clock_500ms_R:R_TRIG;
	Temp_clock_1s_R:R_TRIG;
	
END_VAR
//RUN之后一个扫描周期ON
Temp_pulse_on_R(CLK:=TRUE,Q=>CPU_Clock.FirstRun);


//10ms脉冲上升沿
Temp_clock_10ms_R(CLK:=CPU_Clock.Clock_10ms,Q=>CPU_Clock.Clock_10ms_R);

//50ms脉冲上升沿
Temp_clock_50ms_R(CLK:=CPU_Clock.Clock_50ms,Q=>CPU_Clock.Clock_50ms_R);

//100ms脉冲上升沿
Temp_clock_100ms_R(CLK:=CPU_Clock.Clock_100ms,Q=>CPU_Clock.Clock_100ms_R);

//500ms脉冲上升沿
Temp_clock_500ms_R(CLK:=CPU_Clock.Clock_500ms,Q=>CPU_Clock.Clock_500ms_R);

//1s脉冲上升沿
Temp_clock_1s_R(CLK:=CPU_Clock.Clock_1s,Q=>CPU_Clock.Clock_1s_R);

//累计运行时间ms获取
GetSystemTime(udiTimeMs=>CPU_Clock.TimeMs );
//获取系统时间
GetSystemDate_sDt(stSystemDate=>CPU_Clock.DataToday);
//获取前31天时间
FC_SysTime(iNow:= CPU_Clock.DataToday, ioBefor:=CPU_Clock.DateOld );



//开班时间设定
CPU_Clock.DayStartTime:='8:30';
CPU_Clock.NightStartTime:='20:30';
//

OP10_Control();
OP11_Control();
OP20_Control();
OP30_Control();
OP70_Control();
OP80_Control();



