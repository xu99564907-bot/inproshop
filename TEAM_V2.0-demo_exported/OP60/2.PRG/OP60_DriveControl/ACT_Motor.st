


FB_Motor_Instance[1](
	iName:="上层流线",
	iEstop:=DB6000_Control.Machine.EmgSafetyRelay,
	iAlam:=, //控制器报警
	iAuto:= DB6000_Control.Mode.Status.AutoMode, 
	iReset:= DB6000_Control.Mode.Out.ErrorReset, 
	iTimeDelay:= T#1S, 
	iMode:= 1, 
	ioMotor:= DB6050_DriveControl.Motor[1], 
	oMotorFor=>  , //正转
	oMotorBack=>, //反转
	oReset=> );//复位信号
	


