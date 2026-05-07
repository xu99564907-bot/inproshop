FUNCTION_BLOCK FB_ElectricScrewdriver_V1_1_0
VAR_IN_OUT
	ioESDCtrl:Str_ESD;
END_VAR

VAR_INPUT
	iName:WSTRING(40);//轴名称
	iEstop:BOOL;//急停
	iSafeDoor:BOOL;//安全门信号
	iLightCurtain:BOOL;//光栅信号
	iMode:Str_Mode;//设备模式
	iNG:BOOL;//锁附NG
	iOK:BOOL;//锁附OK
	iERROR:BOOL;//电批报警
END_VAR
VAR_OUTPUT
	oPowerOn:BOOL;//电批使能
	oStart:BOOL;//电批启动
	oReset:BOOL;//报警复位
END_VAR
VAR
	i:INT;//循环数据用
	En_Control:BOOL;//轴控制条件
	StartDelay:TON;//启动计时
END_VAR
VAR RETAIN PERSISTENT
	// 启动计时
	Velocity: INT;
	Torque:INT;
END_VAR




(*版本V1:
	功能块建立
*)

IF CPU_Clock.FirstRun THEN
	ioESDCtrl.Parm.Velocity:=Velocity;
	ioESDCtrl.Parm.Torque:=Torque;
ELSE
	Velocity:=ioESDCtrl.Parm.Velocity;
	Torque:=ioESDCtrl.Parm.Torque;
END_IF

//初始值赋值
//速度
IF ioESDCtrl.Parm.Velocity<=0 THEN
	ioESDCtrl.Parm.Velocity:=100;
END_IF
//扭矩
IF ioESDCtrl.Parm.Torque<=0 THEN
	ioESDCtrl.Parm.Torque:=100;
END_IF

//自动模式下自动使能
IF iMode.Status.AutoMode THEN
	ioESDCtrl.Cmd.Power:=TRUE;
END_IF


//使能
oPowerOn:= iEstop AND iSafeDoor AND iLightCurtain AND ioESDCtrl.Cmd.Power;


//控制
IF iMode.Status.AutoMode THEN
	oStart:=ioESDCtrl.Cmd.AutoStart;
ELSIF iMode.Status.ManualMode THEN
	oStart:=ioESDCtrl.Cmd.ManuStart;
END_IF

//信号转换
IF oStart THEN
	IF iOK THEN
		ioESDCtrl.Status.OK:=TRUE;
	ELSIF iNG OR StartDelay.Q THEN
		ioESDCtrl.Status.NG:=TRUE;
	END_IF
ELSE
	ioESDCtrl.Status.OK:=FALSE;
	ioESDCtrl.Status.NG:=FALSE;	
END_IF


//急停
IF NOT iEstop THEN
	oStart:=FALSE;
END_IF

StartDelay(IN:= oStart, PT:= T#30S, Q=> , ET=> );

//切换模式手动清除信号
IF iMode.Status.AutoMode THEN
	ioESDCtrl.Cmd.ManuBackward:=FALSE;
	ioESDCtrl.Cmd.ManuFoward:=FALSE;
	ioESDCtrl.Cmd.ManuStart:=FALSE;
END_IF
//自复位自动控制信号
ioESDCtrl.Cmd.AutoBackward:=FALSE;
ioESDCtrl.Cmd.AutoFoward:=FALSE;
ioESDCtrl.Cmd.AutoStart:=FALSE;
