FUNCTION_BLOCK FB_ModeControl_V1
VAR_INPUT
	iClock:Str_Clock;//系统时钟
	iStartDelay:TIME;//延时启动
	iEstop:BOOL;//急停报警
	iAlam:BOOL;//暂停报警
	iWarn:BOOL;//警告
END_VAR
VAR_IN_OUT
	ioMachine:Str_Machine;//设备
	ioMode:Str_Mode;//模式
END_VAR
VAR_OUTPUT
END_VAR
VAR
	i:INT;//循环变量
	Start_R:R_TRIG;//开始按钮上升沿
	Reset_R:R_TRIG;//复位按钮上升沿
	Step_R:R_TRIG;//单步按钮上升沿
	Home_R:R_TRIG;//回原按钮上升沿
	Home_F:F_TRIG;//回原按钮下降沿
	DelayStart:TON;//开始按钮延时
	DelayReset:TON;//复位按钮延时
	DelayStop:TON;//停止按钮延时
	AutoRun_R:R_TRIG;//运转中上升沿
	AutoRun_F:F_TRIG;//运转中上升沿
	HomeOK_R:R_TRIG;//回原完成上升沿
	HomeOK_F:F_TRIG;//回原完成下降沿
	HomeStart_R:R_TRIG;//回原开始上升沿
	HomeStart_F:F_TRIG;//回原开始下降沿
END_VAR

//******************************************************HMI&Machine&Interface控制状态切换


//启动按钮状态获取
Start_R(CLK:=DelayStart.Q );//上升沿
DelayStart(IN:=ioMachine.OP_StartButton OR ioMode.Cmd.RunButton,PT:=iStartDelay);//延时启动
//复位按钮状态获取
Reset_R(CLK:=ioMachine.OP_ResetButton OR ioMode.Cmd.ResetButton OR ioMode.Cmd.HomingButton);//上升沿
DelayReset(IN:=ioMachine.OP_ResetButton OR ioMode.Cmd.ResetButton,PT:=T#3S);//复位按钮延时
//停止按钮状态获取
DelayStop(IN:=ioMachine.OP_StopButton OR ioMode.Cmd.StopButton,PT:=T#3S);//停止延时
//单步按钮状态获取
Step_R(CLK:=ioMode.Cmd.StepButton);
//回原按钮状态获取
Home_R(CLK:=ioMode.Cmd.HomingButton OR DelayReset.Q);
Home_F(CLK:=ioMode.Cmd.HomingButton OR DelayReset.Q);

//报警&警告状态切换
ioMode.Status.EStop:=iEstop;
ioMode.Status.Fault:=iEstop OR iAlam;
ioMode.Status.Warning:=iWarn;

IF Reset_R.CLK THEN
	ioMode.Out.ErrorReset:=TRUE;
ELSE
	ioMode.Out.ErrorReset:=FALSE;
END_IF;

IF DelayStop.IN OR ioMode.Status.Fault OR ioMode.Status.EStop THEN
	ioMode.Out.Stop:=TRUE;
ELSE
	ioMode.Out.Stop:=FALSE;
END_IF;


//手自动模式切换
ioMode.Status.ManualMode:=NOT ioMachine.OP_AutoManual;
ioMode.Status.AutoMode:=ioMachine.OP_AutoManual;

//手动互锁条件屏蔽复位
IF ioMode.Status.AutoMode THEN
	ioMode.Cmd.ManUnlock:=FALSE;
END_IF;

//回原
IF Home_R.Q THEN
	ioMode.Status.HomeOK:=FALSE;
END_IF
IF ioMode.Status.AutoMode AND NOT ioMode.Status.Fault AND Home_F.Q AND NOT ioMode.Status.AutoRunning THEN
	ioMode.Out.HomeStart:=TRUE;	
END_IF;

IF ioMode.Status.Fault OR DelayStop.IN OR ioMode.Status.ManualMode OR ioMode.Status.HomeOK THEN
	ioMode.Out.HomeStart:=FALSE;
END_IF;

IF iEstop OR DelayStop.Q THEN
	ioMode.Status.HomeOK:=FALSE;
END_IF;

//运转中
IF ioMode.Status.HomeOK AND ioMode.Status.AutoMode AND Start_R.Q THEN
	ioMode.Status.AutoRunning:=TRUE;
END_IF;
IF ioMode.Status.Fault OR DelayStop.IN OR ioMode.Status.ManualMode OR Home_R.Q THEN
	ioMode.Status.AutoRunning:=FALSE;
END_IF;


//单步模式
IF ioMode.Status.StepMode THEN
	ioMode.Status.StepRunning:=FALSE;
END_IF;
IF Start_R.Q THEN
	ioMode.Status.StepRunning:=TRUE;
END_IF;



//状态沿获取
AutoRun_R(CLK:= ioMode.Status.AutoRunning, Q=>ioMode.Out.AutoRun_R );
AutoRun_F(CLK:= ioMode.Status.AutoRunning, Q=>ioMode.Out.AutoRun_F );
HomeOK_R(CLK:= ioMode.Status.HomeOK, Q=>ioMode.Out.HomeOK_R );
HomeOK_F(CLK:= ioMode.Status.HomeOK, Q=>ioMode.Out.HomeOK_F );
HomeStart_R(CLK:= ioMode.Out.HomeStart, Q=>ioMode.Out.HomeStart_R );
HomeStart_F(CLK:= ioMode.Out.HomeStart, Q=>ioMode.Out.HomeStart_F );



(*************************************************指示灯控制*********************************************************)
//上电&测试点亮塔灯按钮灯
IF iClock.FirstRun OR ioMode.Cmd.LampTest THEN
	ioMachine.RedLightHouse:=TRUE;
	ioMachine.YeLightHouse:=TRUE;
	ioMachine.GrLightHouse:=TRUE;
	ioMachine.StartLamp:=TRUE;
	ioMachine.StopLamp:=TRUE;
	ioMachine.ResetLamp:=TRUE;
	ioMachine.Light:=TRUE;
ELSE
	ioMachine.RedLightHouse:=FALSE;
	ioMachine.YeLightHouse:=FALSE;
	ioMachine.GrLightHouse:=FALSE;
	ioMachine.StartLamp:=FALSE;
	ioMachine.StopLamp:=FALSE;
	ioMachine.ResetLamp:=FALSE;
	ioMachine.Buzzer:=FALSE;
END_IF;


IF ioMode.Status.Fault THEN//停止类报警发生时，停止按钮灯亮，红色塔灯、蜂鸣器、复位按钮灯闪烁
	ioMachine.StopLamp:=TRUE;
	IF iClock.Clock_1s THEN
		ioMachine.RedLightHouse:=TRUE;
		ioMachine.Buzzer:=TRUE;
		ioMachine.ResetLamp:=TRUE;
	END_IF;
ELSIF iOMode.Status.Warning AND ioMode.Status.AutoRunning THEN//自动运转中，发生不停机报警时，绿色塔灯、开始按钮灯亮，黄色塔灯、蜂鸣器1S+0.2S闪烁,复位按钮灯1S闪烁
	ioMachine.StartLamp:=TRUE;
	ioMachine.GrLightHouse:=TRUE;
	IF iClock.Clock_1s AND iClock.Clock_100ms THEN
		ioMachine.YeLightHouse:=TRUE;
		ioMachine.Buzzer:=TRUE;
	END_IF;
	IF iClock.Clock_1s THEN
		ioMachine.ResetLamp:=TRUE;
	END_IF;
ELSIF ioMode.Status.AutoMode AND ioMode.Status.HomeOK AND NOT ioMode.Status.Fault AND NOT ioMode.Status.AutoRunning AND NOT DelayStart.IN THEN//自动模式下，原点回归完成，无报警时，绿色按钮灯闪烁
	ioMachine.StopLamp:=TRUE;
	ioMachine.YeLightHouse:=TRUE;
	IF iClock.Clock_1s THEN
		ioMachine.StartLamp:=TRUE;
	END_IF;
ELSIF ioMode.Status.AutoMode AND ioMode.Status.HomeOK AND NOT ioMode.Status.Fault AND NOT ioMode.Status.AutoRunning AND  DelayStart.IN THEN//自动模式下，原点回归完成，无报警时，绿色按钮灯闪烁
	ioMachine.StopLamp:=TRUE;
	ioMachine.YeLightHouse:=TRUE;
	IF iClock.Clock_1s THEN
		ioMachine.StartLamp:=TRUE;
	END_IF;
	IF  iClock.Clock_100ms THEN
		ioMachine.YeLightHouse:=TRUE;
		ioMachine.Buzzer:=TRUE;
	END_IF;
ELSIF ioMode.Status.AutoMode AND NOT ioMode.Status.HomeOK AND NOT ioMode.Status.Fault AND NOT iOMode.Status.AutoRunning AND NOT ioMode.Out.HomeStart  THEN//自动模式下，原点回归未完成，无报警时，黄色按钮灯亮
	ioMachine.StopLamp:=TRUE;
	ioMachine.YeLightHouse:=TRUE;
	ioMachine.ResetLamp:=TRUE;
ELSIF ioMode.Status.ManualMode AND  NOT ioMode.Status.Fault THEN//手动模式下，设备未初始化，设备未报警时，停止按钮灯、红色塔灯亮
	ioMachine.StopLamp:=TRUE;
	ioMachine.RedLightHouse:=TRUE;
ELSIF ioMode.Out.HomeStart THEN//初始化中开始按钮灯亮，绿色塔灯1S闪烁
	ioMachine.StartLamp:=TRUE;
	IF iClock.Clock_1s THEN
		ioMachine.GrLightHouse:=TRUE;
	END_IF;
ELSIF  iOMode.Status.AutoRunning THEN//自动运转中，开始按钮灯、绿色塔灯亮
	ioMachine.StartLamp:=TRUE;
	ioMachine.GrLightHouse:=TRUE;

ELSE//其他情况塔灯闪烁
	IF iClock.Clock_1s THEN
		ioMachine.RedLightHouse:=TRUE;
		ioMachine.YeLightHouse:=TRUE;
		ioMachine.GrLightHouse:=TRUE;
	END_IF;
END_IF;
//蜂鸣器屏蔽
IF ioMode.Cmd.Debug_BUZButton THEN
	ioMachine.Buzzer:=FALSE;
END_IF;
//复位后蜂鸣器屏蔽取消
// IF ioMode. Out.ErrorReset THEN
// 	ioMode.Cmd.Debug_BUZButton:=FALSE;
// END_IF

(*************************安全信号汇总**************************************)
//急停按钮
FOR i:=0 TO 9 BY 1 DO
	IF NOT ioMachine.Emg_Stop[i] THEN
		ioMachine.EmgSafetyRelay:=FALSE;
		EXIT;
	END_IF;
	ioMachine.EmgSafetyRelay:=TRUE;
END_FOR;

//安全门
FOR i:=0 TO 9 BY 1 DO
	IF NOT ioMachine.SafetyDoor[i] AND NOT ioMode.Cmd.SafetyDoorShieild THEN
		ioMachine.SafetyDoorRelay:=FALSE;
		EXIT;
	END_IF;
	ioMachine.SafetyDoorRelay:=TRUE;
END_FOR;

//安全光栅
FOR i:=0 TO 9 BY 1 DO
	IF NOT ioMachine.LightCurtain[i] THEN
		ioMachine.LightCurtainRelay:=FALSE;
		EXIT;
	END_IF;
	ioMachine.LightCurtainRelay:=TRUE;
END_FOR;

(*************************整机CT计时**************************************)
IF ioMode.Status.AutoRunning THEN
	IF ioMachine.CycleTime.Start THEN
		ioMachine.CycleTime.Start:= FALSE;
		ioMachine.CycleTime.Befor:=ioMachine.CycleTime.Now;
		ioMachine.CycleTime.Now:=0;
	END_IF;
	
	IF iClock.Clock_100ms_R THEN
		ioMachine.CycleTime.Now:=ioMachine.CycleTime.Now+1;
	END_IF;
END_IF;

(*************************整机稼动率统计**************************************)
//开机时间统计
//运行时间统计
IF iClock.Clock_1s_R THEN
	ioMachine.PowerOnTime:=ioMachine.PowerOnTime+1;
	IF ioMode.Status.AutoRunning THEN
		ioMachine.RunTime:=ioMachine.RunTime+1;
	END_IF;
END_IF;

IF ioMachine.PowerOnTime<>0 THEN
	ioMachine.EfficencyResult:=UDINT_TO_REAL(ioMachine.RunTime)/UDINT_TO_REAL(ioMachine.PowerOnTime);
ELSE
	ioMachine.EfficencyResult:=0;
END_IF;
IF ioMachine.EfficencyClear THEN
	ioMachine.PowerOnTime:=0;
	ioMachine.RunTime:=0;
	ioMachine.EfficencyClear:=FALSE;
END_IF;

//整机速度限制
IF ioMachine.Speed <= 0 OR ioMachine.Speed > 100 THEN	
	ioMachine.Speed:=10;
END_IF




