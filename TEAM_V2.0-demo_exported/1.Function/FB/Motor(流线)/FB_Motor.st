FUNCTION_BLOCK FB_Motor
VAR_INPUT
	iName:WSTRING;//流线名称
	iEstop:BOOL;//急停信号
	iAlam:BOOL;//控制器报警
	iAuto:BOOL;//自动模式
	iReset:BOOL;//报警复位
	iTimeDelay:TIME;//切换手动模式后延时停止时间
	iMode:INT;//控制模式[=0,单向流线运动；=1，双向流程控制
END_VAR
VAR_IN_OUT
	ioMotor:Str_Motor;
END_VAR
VAR_OUTPUT
	oMotorFor:BOOL;//电机正转
	oMotorBack:BOOL;//电机反转
	oReset:BOOL;//控制器报警复位
END_VAR
VAR
	ManuTime:TON;//切换回手动时间
END_VAR

//单项控制模式自动运转中启动流线
IF 	iMode=0 THEN
	IF iAuto AND NOT iAlam THEN
		ioMotor.Cmd.AutoFor:=TRUE;
	END_IF
END_IF

//手动模式切换计时，自动切换手动模式5S之后流线自动停止
ManuTime(IN:= NOT iAuto, PT:= iTimeDelay );

//切换手动模式超过设定时间停止
IF ManuTime.Q THEN
	ioMotor.Cmd.AutoFor:=FALSE;
	ioMotor.Cmd.AutoBack:=FALSE;
END_IF

//切换自动模式复位手动控制
IF iAuto THEN
	ioMotor.Cmd.ManuFor:=FALSE;
	ioMotor.Cmd.ManuBack:=FALSE;
END_IF

//报警复位
oReset:=iReset AND iAlam;

//流线控制输出
oMotorFor:=(ioMotor.Cmd.AutoFor OR (NOT iAuto AND ioMotor.Cmd.ManuFor)) AND NOT oMotorBack;
oMotorBack:=(ioMotor.Cmd.AutoBack OR (NOT iAuto AND ioMotor.Cmd.ManuBack)) AND NOT oMotorFor;


//急停复位信号
IF NOT iEstop THEN
	oMotorFor:=FALSE;
	oMotorBack:=FALSE;
END_IF


//硬件地址状态映射
ioMotor.DevStatus.MotorFor:=oMotorFor;
ioMotor.DevStatus.MotorBack:=oMotorBack;
ioMotor.DevStatus.Reset:=oReset;


