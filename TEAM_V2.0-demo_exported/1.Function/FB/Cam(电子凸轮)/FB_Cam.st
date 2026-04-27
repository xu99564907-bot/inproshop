FUNCTION_BLOCK FB_Cam
VAR_IN_OUT
	ioMaster:AXIS_REF_SM3;//主轴
	ioSlave:AXIS_REF_SM3;//从轴
	ioCam:Str_Cam;//控制
	ioCamTable:MC_CAM_REF;//凸轮表
END_VAR
VAR_INPUT
	iEstop:BOOL;//急停信号
	iEn_Control:BOOL;//允许耦合	
END_VAR
VAR_OUTPUT
END_VAR
VAR
	MC_CamIn_0: MC_CamIn;
	MC_CamOut_0: MC_CamOut;
	MC_Stop_0: MC_Stop;	
	MC_Stop_1: MC_Stop;	
	MC_CamTableSelect_0: MC_CamTableSelect;
	CamOutDelay:TON;//解耦延时
	CamIn_F:F_TRIG;//耦合完成下降沿
END_VAR


//主轴未使能，轴报错，轴回原中 不可以耦合
IF ioMaster.nAxisState = 0 OR ioSlave.nAxisState = 0 OR ioMaster.nAxisState = 1 OR ioMaster.nAxisState = 7 THEN
	ioCam.Cmd.GearIn:=FALSE;
END_IF

//从轴异常 控制解耦
IF ioSlave.nAxisState = 1 THEN
	ioCam.Cmd.GearOut:=TRUE;
END_IF
//解耦
IF ioCam.Cmd.GearOut THEN
	MC_CamIn_0.Execute:=FALSE;
END_IF

//解耦延时
CamOutDelay(IN:= NOT ioCam.Status.InCam, PT:= T#1S, Q=> , ET=> );
IF MC_CamOut_0.Done OR MC_CamOut_0.Error OR CamOutDelay.Q THEN
	ioCam.Cmd.GearOut:=FALSE;
END_IF



//凸轮表选择	
MC_CamTableSelect_0(
	Master:= ioMaster, 
	Slave:= ioSlave, 
	CamTable:= ioCamTable, 
	Execute:= iEn_Control AND ioCam.Cmd.GearIn, 
	Periodic:= TRUE, 
	MasterAbsolute:= TRUE, 
	SlaveAbsolute:= TRUE, 
	Done=> , 
	Busy=> , 
	Error=> , 
	ErrorID=> , 
	CamTableID=> );	
	
	
	
//耦合实例化
MC_CamIn_0(
	Master:= ioMaster, 
	Slave:= ioSlave, 
	Execute:= MC_CamTableSelect_0.Done, 
	MasterOffset:= 0, 
	SlaveOffset:= 0, 
	MasterScaling:= 1, 
	SlaveScaling:= 1, 
	StartMode:= 2, 
	CamTableID:= MC_CamTableSelect_0.CamTableID, 
	VelocityDiff:= 10, 
	Acceleration:= 10, 
	Deceleration:= 10, 
	Jerk:= , 
	TappetHysteresis:= , 
	InSync=> ioCam.Status.InCam, 
	Busy=> , 
	CommandAborted=> , 
	Error=> , 
	ErrorID=> , 
	EndOfProfile=> , 
	Tappets=> );



	
//解耦实例化
MC_CamOut_0(
	Slave:= ioSlave, 
	Execute:= ioCam.Cmd.GearOut, 
	Done=> , 
	Busy=> , 
	Error=> , 
	ErrorID=> );

(*********解耦后触发轴停止，防止从轴继续运行*************)


CamIn_F(CLK:= ioCam.Status.InCam, Q=> );

//停止轴实例化
MC_Stop_0(
	Axis:= ioMaster, 
	Execute:= MC_CamOut_0.Done OR CamIn_F.Q, 
	Deceleration:= , 
	Jerk:= , 
	Done=> , 
	Busy=> , 
	Error=> , 
	ErrorID=> );

//停止轴实例化	
MC_Stop_1(
	Axis:= ioSlave, 
	Execute:= MC_CamOut_0.Done OR CamIn_F.Q, 
	Deceleration:= , 
	Jerk:= , 
	Done=> , 
	Busy=> , 
	Error=> , 
	ErrorID=> );	
	
