FUNCTION_BLOCK FB_Heating
VAR_INPUT
	
	iReset:BOOL;//报警复位
	iPV:REAL;//实际温度
	iSV_MAX:REAL;//设定温度最大值
	iPV_MAX:REAL;//实际温度最大值
	ICycleTime:DINT;//输出周期时间	
END_VAR
VAR_IN_OUT
	ioHeating:Str_Heating;
END_VAR
VAR_OUTPUT
	Active:BOOL;//SSR控制输出
END_VAR

VAR
	Temp_PIDControl:PID_AT;
	Temp_Enable_P:R_TRIG;
	Temp_Fault3_TON:TON;
END_VAR

Temp_Enable_P(CLK:=ioHeating.Cmd.Enable);
//清除状态
IF Temp_Enable_P.Q THEN
	ioHeating.Cmd.StartAT:=FALSE;
	ioHeating.Parm.PV:=0;
END_IF
//设定值大于设定上限时，强制设定值为设定最大值
IF ioHeating.Parm.SV>iSV_MAX THEN
	ioHeating.Parm.SV:=iSV_MAX;
END_IF
//补偿系数设定超出范围时，强制为上下限参数
IF ioHeating.Parm.K > 1.4 THEN
	ioHeating.Parm.K:= 1.4;
ELSIF ioHeating.Parm.K =0 THEN
	ioHeating.Parm.K:= 1;
ELSIF ioHeating.Parm.K < 0.6 THEN
	ioHeating.Parm.K:= 0.6;
END_IF;

//控制周期
IF ICycleTime<>0 THEN
	Temp_PIDControl.PIDConfig.GeneralConfig.CycleTime:=ICycleTime;
ELSE
	Temp_PIDControl.PIDConfig.GeneralConfig.CycleTime:=1000;
END_IF


//实际温度映射
ioHeating.Parm.PV:=iPV;





//调用温控块
Temp_PIDControl(
	Enable:= ioHeating.Cmd.Enable, 
	SP:= ioHeating.Parm.SV, 
	PV:= ioHeating.Parm.PV, 
	AI:= , 
	PIDConfig:= , 
	InlockSW:= , 
	InlockVal:= , 
	CasSlaveState:= , 
	StartAT:= ioHeating.Cmd.StartAT, 
	Kp:= ioHeating.Parm.Kp, 
	Ti:= ioHeating.Parm.Ti, 
	Td:= ioHeating.Parm.Td, 
	OutPWM=> , 
	OutPercent=> , 
	OutAO=> , 
	PIDOutput=> , 
	State=> , 
	Error=> , 
	ErrorBits=> , 
	SlaveState=> );

//整定状态
ioHeating.Status.ATBusy:=Temp_PIDControl.PIDOutput.ATState=1;
ioHeating.Status.ATDone:=Temp_PIDControl.PIDOutput.ATState=2;

//温控异常	
	(*温度上下限异常
	Fault1:超高温异常报警
	Fault2:热电偶检测温度长时间低于设定温度范围
	Fault3:热电偶断路报警
	Fault4:热电偶短路报警
	
	Error1:低于设定温度范围异常警告
	Error2:高于设定温度范围异常警告*)	
	
//报警复位
IF iReset OR NOT ioHeating.Cmd.Enable THEN
	ioHeating.Status.Fault:=FALSE;
	ioHeating.Status.FaultID:=0;
	ioHeating.Status.Warm:=FALSE;
	ioHeating.Status.WarmID:=0;	
END_IF

//报警&警告

IF ioHeating.Parm.PV >iPV_MAX AND ioHeating.Parm.PV <> 3276.7 THEN
	ioHeating.Status.Fault:=TRUE;
	ioHeating.Status.FaultID:=1;
END_IF//超高温报警
IF 	ioHeating.Cmd.Enable THEN
	IF Temp_Fault3_TON.Q THEN
		ioHeating.Status.Fault:=TRUE;
		ioHeating.Status.FaultID:=2;
	END_IF//实际温度长时间低于设定温度范围
	IF ioHeating.Parm.PV = 3276.7 THEN
		ioHeating.Status.Fault:=TRUE;
		ioHeating.Status.FaultID:=3;
	END_IF//热电偶短路报警
	IF ioHeating.Parm.PV = -3276.8 THEN
		ioHeating.Status.Fault:=TRUE;
		ioHeating.Status.FaultID:=4;
	END_IF//热电偶断路报警

	IF NOT ioHeating.Status.Fault THEN
		IF ABS(ioHeating.Parm.SV/ioHeating.Parm.K-ioHeating.Parm.ControlLimit/ioHeating.Parm.K) > ioHeating.Parm.PV THEN
			ioHeating.Status.Warm:=TRUE;
			ioHeating.Status.WarmID:=1;
		//实际温度低于设定温度范围警告
		ELSIF ABS(ioHeating.Parm.SV/ioHeating.Parm.K+ioHeating.Parm.ControlLimit/ioHeating.Parm.K) < ioHeating.Parm.PV THEN
			ioHeating.Status.Warm:=TRUE;
			ioHeating.Status.WarmID:=2;
		ELSE
			ioHeating.Status.Warm:=FALSE;
			ioHeating.Status.WarmID:=0;
		END_IF//实际温度高于设定温度范围警告
	ELSE
		ioHeating.Status.Warm:=FALSE;
		ioHeating.Status.WarmID:=0;
	END_IF
	
END_IF
Temp_Fault3_TON(IN:= ioHeating.Status.Warm AND ioHeating.Status.WarmID=1 AND NOT ioHeating.Status.ATBusy,PT:=T#300S);	

//继电器输出
ioHeating.OUT.Active:=Temp_PIDControl.OutPWM AND NOT ioHeating.Status.Fault AND ioHeating.Parm.SV/ioHeating.Parm.K+ioHeating.Parm.ControlLimit > ioHeating.Parm.PV;
Active:=ioHeating.OUT.Active;
//温度显示=实际温度*设定比例
IF ioHeating.Parm.PV <> 3276.7 AND ioHeating.Parm.PV <> -3276.8 THEN
	ioHeating.Parm.PV:=iPV*ioHeating.Parm.K;
END_IF
