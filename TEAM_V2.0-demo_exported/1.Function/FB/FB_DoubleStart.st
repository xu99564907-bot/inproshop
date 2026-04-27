FUNCTION_BLOCK FB_DoubleStart
VAR_IN_OUT
	ioDoubleStart:Str_DoubleStart;
END_VAR
VAR_INPUT
	Clock:BOOL;//500MS脉冲
END_VAR
VAR
	TimeDelay_Button1:TON;
	TimeDelay_Button2:TON;
	Button_R:R_TRIG;
END_VAR

(************V1.0******************)
//功能说明
//两个按钮同时按下，输出一个启动脉冲信号
//按钮防呆，两个按钮按下间隔大于500MS，无启动输出信号
//按钮待机状态下，500ms闪烁，有效按下后常亮，无效按下后灭


TimeDelay_Button1(IN:=ioDoubleStart.Button1 AND (NOT ioDoubleStart.Button2 OR TimeDelay_Button1.Q),PT:=T#500MS);//按钮1按下延时
TimeDelay_Button2(IN:=ioDoubleStart.Button2 AND (NOT ioDoubleStart.Button1 OR TimeDelay_Button2.Q),PT:=T#500MS);//按钮2按下延时
Button_R(CLK:=ioDoubleStart.Button1 AND ioDoubleStart.Button2);//按钮上升沿

//按钮启动
IF Button_R.Q AND NOT TimeDelay_Button1.Q AND NOT TimeDelay_Button2.Q THEN
	ioDoubleStart.Start:=TRUE;
ELSE
	ioDoubleStart.Start:=FALSE;
END_IF

//按钮指示灯
IF TimeDelay_Button1.Q OR TimeDelay_Button2.Q THEN
	ioDoubleStart.Lamp1:=FALSE;
	ioDoubleStart.Lamp2:=FALSE;
ELSIF ioDoubleStart.Button1 OR ioDoubleStart.Button2 THEN
	ioDoubleStart.Lamp1:=ioDoubleStart.Button1;
	ioDoubleStart.Lamp2:=ioDoubleStart.Button2;
ELSIF NOT ioDoubleStart.Button1 AND NOT ioDoubleStart.Button2 THEN
	ioDoubleStart.Lamp1:=Clock;
	ioDoubleStart.Lamp2:=Clock;	
ELSE
	ioDoubleStart.Lamp1:=FALSE;
	ioDoubleStart.Lamp2:=FALSE;	
END_IF