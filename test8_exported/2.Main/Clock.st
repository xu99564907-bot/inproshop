PROGRAM Clock
VAR
	data_clock_10ms:FB_Clock;
	data_clock_50ms:FB_Clock;
	data_clock_100ms:FB_Clock;
	data_clock_500ms:FB_Clock;
	data_clock_1s:FB_Clock;
END_VAR


//100MS脉冲
data_clock_10ms(iEnable:=TRUE,iClock:=1,o_Clock=>CPU_Clock.Clock_10ms);

//500MS脉冲
data_clock_50ms(iEnable:=TRUE,iClock:=5,o_Clock=>CPU_Clock.Clock_50ms);


//100MS脉冲
data_clock_100ms(iEnable:=TRUE,iClock:=10,o_Clock=>CPU_Clock.Clock_100ms);

//500MS脉冲
data_clock_500ms(iEnable:=TRUE,iClock:=50,o_Clock=>CPU_Clock.Clock_500ms);

//1S脉冲
data_clock_1s(iEnable:=TRUE,iClock:=100,o_Clock=>CPU_Clock.Clock_1s);	















