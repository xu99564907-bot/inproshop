FUNCTION_BLOCK FB_Rotdisk_V1
VAR_INPUT
	iName:WSTRING;//名称
	iSensor:BOOL;//到位停止传感器
	iEstop:BOOL;//急停信号
	iSafeDoor:BOOL;//安全门信号
	iLightCurtain:BOOL;//光栅信号
	iAuto:BOOL;//设备自动模式
	iReset:BOOL;//报警复位
	iIC:BOOL;//设备互锁条件
	iClock_100ms:BOOL;//100MS脉冲信号
	iTimeDelay:UINT;//超时设定时间
END_VAR
VAR_IN_OUT
	ioRotdisk:Str_Rotdisk;//凸轮控制
END_VAR
VAR_OUTPUT
	oMotor:BOOL;//电机控制
END_VAR
VAR
	i:INT;//循环变量
	SportTimeDelay:UINT;//运动计时
	ManuStart_R:R_TRIG;//手动启动上升沿
	AutoStrat_R:R_TRIG;//自动启动上升沿
	Sensor_R:R_TRIG;//感应器上升沿
	Temp_MotorOn:BOOL;//中转变量
END_VAR

//互锁条件映射
ioRotdisk.Cmd.IC:=iIC;
ioRotdisk.DevStatus.iSensor:=iSensor;
ioRotdisk.DevStatus.oMotor:=oMotor;

//上升沿状态获取
ManuStart_R(CLK:= ioRotdisk.Cmd.ManuStart);
AutoStrat_R(CLK:= ioRotdisk.Cmd.AutoStart);

IF iAuto THEN
	IF AutoStrat_R.Q AND iIC THEN
		Temp_MotorOn:=TRUE;
		ioRotdisk.Status.Done:=FALSE;
		FOR i:=9 TO 1 BY -1 DO//循环数据位移，保存上次记录数据
	    	ioRotdisk.Status.Sp_Time[i]:=ioRotdisk.Status.Sp_Time[i-1];
		END_FOR;
		ioRotdisk.Status.Sp_Time[0]:=0;
	END_IF;
ELSE
	IF ManuStart_R.Q AND iIC THEN
		Temp_MotorOn:=TRUE;
		ioRotdisk.Status.Done:=FALSE;
		FOR i:=9 TO 1 BY -1 DO//循环数据位移，保存上次记录数据
	    	ioRotdisk.Status.Sp_Time[i]:=ioRotdisk.Status.Sp_Time[i-1];
		END_FOR;
		ioRotdisk.Status.Sp_Time[0]:=0;
	END_IF;
END_IF

//位置到达
Sensor_R(CLK:= iSensor);
IF Sensor_R.Q AND Temp_MotorOn THEN
	Temp_MotorOn:=FALSE;
	ioRotdisk.Status.Done:=TRUE;
END_IF

//运转中状态
ioRotdisk.Status.Busy:=Temp_MotorOn;

//运动计时
IF ioRotdisk.Status.Busy AND iClock_100ms THEN
	ioRotdisk.Status.Sp_Time[0]:=ioRotdisk.Status.Sp_Time[0]+1;
END_IF

//报警分类&复位
IF (ioRotdisk.Cmd.AutoStart OR ioRotdisk.Cmd.ManuStart) AND NOT iIC THEN//互锁异常报警
	ioRotdisk.Status.Error:=TRUE;
	ioRotdisk.Status.ErrorID:=1;
ELSIF ioRotdisk.Status.Sp_Time[0] > iTimeDelay AND ioRotdisk.Status.Busy THEN//超时报警
	oMotor:=FALSE;
	ioRotdisk.Status.Error:=TRUE;
	ioRotdisk.Status.ErrorID:=2;	
ELSIF iReset THEN
	ioRotdisk.Status.Error:=FALSE;
END_IF

IF NOT iEstop THEN
	Temp_MotorOn :=FALSE;
END_IF

//输出映射
oMotor:=Temp_MotorOn AND iIC AND iLightCurtain AND iSafeDoor AND iEstop;

//控制标志位自复位
ioRotdisk.Cmd.AutoStart:=FALSE;
ioRotdisk.Cmd.ManuStart:=FALSE;



