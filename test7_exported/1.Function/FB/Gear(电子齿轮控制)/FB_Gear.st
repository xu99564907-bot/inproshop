FUNCTION_BLOCK FB_Gear
VAR_IN_OUT
	ioMaster:AXIS_REF_SM3;//主轴
	ioSlave:AXIS_REF_SM3;//从轴
	ioGear:Str_Gear;//控制
END_VAR
VAR_INPUT
	iEstop:BOOL;//急停信号
	iRatioNumerator:DINT := 1;//齿轮比分子
	iRatioDenominator:UDINT := 1;//齿轮比分母
END_VAR
VAR_OUTPUT
END_VAR
VAR
	MC_GearIn_0: MC_GearIn;
	MC_GearOut_0: MC_GearOut;
	MC_Stop_0: MC_Stop;
END_VAR


//主轴未使能，轴报错，轴回原中 不可以耦合
IF ioMaster.nAxisState <> 0 AND ioSlave.nAxisState <> 0 AND ioMaster.nAxisState <> 1 AND ioMaster.nAxisState<>7 THEN
	ioGear.Cmd.GearIn:=FALSE;
END_IF

//从轴异常 控制解耦
IF ioSlave.nAxisState = 1 THEN
	ioGear.Cmd.GearOut:=TRUE;
END_IF
//解耦
IF ioGear.Cmd.GearOut THEN
	MC_GearIn_0.Execute:=FALSE;
END_IF

//耦合实例化
MC_GearIn_0(
	Master:= ioMaster, 
	Slave:= ioSlave, 
	Execute:= MC_GearIn_0.Execute , 
	RatioNumerator:= iRatioNumerator, 
	RatioDenominator:= iRatioDenominator, 
	Acceleration:= , 
	Deceleration:= , 
	Jerk:= , 
	BufferMode:= , 
	InGear=> ioGear.Status.InGear, 
	Busy=> , 
	Active=> , 
	CommandAborted=> , 
	Error=> , 
	ErrorID=> );
	
//解耦实例化
MC_GearOut_0(
	Slave:= ioSlave, 
	Execute:= ioGear.Cmd.GearOut, 
	Done=> , 
	Busy=> , 
	Error=> , 
	ErrorID=> );

(*********解耦后触发轴停止，防止从轴继续运行*************)
//停止轴实例化
MC_Stop_0(
	Axis:= ioSlave, 
	Execute:= MC_GearOut_0.Done, 
	Deceleration:= , 
	Jerk:= , 
	Done=> , 
	Busy=> , 
	Error=> , 
	ErrorID=> );
