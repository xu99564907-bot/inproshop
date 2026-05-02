


//停止
IF (iMode.Out.HomeStart_F AND NOT iMode.Status.HomeOK ) OR iMode.Status.EStop OR iMode.Out.HomeOK_F THEN
	ioKuka.Cmd.EXT_Stop:=TRUE;
END_IF

TimeDelayControl[1](IN:= ioKuka.Cmd.EXT_Stop, PT:=T#1S );
IF TimeDelayControl[1].Q THEN
	ioKuka.Cmd.EXT_Stop:=FALSE;
END_IF


//复位
IF ioKuka.Status.STOPMESS  AND iMode.Out.ErrorReset  THEN
	ioKuka.Cmd.CONF_MESS:=TRUE;
END_IF
TimeDelayControl[2](IN:= ioKuka.Cmd.CONF_MESS, PT:=T#1S );
IF TimeDelayControl[2].Q OR NOT ioKuka.Status.STOPMESS THEN
	ioKuka.Cmd.CONF_MESS:=FALSE;
END_IF

TimeDelayControl[0](IN:=NOT ioKuka.Cmd.MOVE_ENABLE, PT:=T#500MS );
//使能 
IF NOT iMode.Status.EStop AND ioKuka.Status.EXT AND TimeDelayControl[0].Q THEN
	ioKuka.Cmd.MOVE_ENABLE:=TRUE;
END_IF

IF iMode.Out.AutoRun_F OR (iMode.Out.HomeStart_F AND NOT iMode.Status.HomeOK) OR NOT ioKuka.Status.EXT  THEN
	ioKuka.Cmd.MOVE_ENABLE:=FALSE;
END_IF



//驱动开启
TimeDelayControl[3](IN:= ioKuka.Cmd.MOVE_ENABLE, PT:=T#500MS );
IF TimeDelayControl[3].Q THEN
	ioKuka.Cmd.DRIVES_OFF:=TRUE;
ELSE
	ioKuka.Cmd.DRIVES_OFF:=FALSE;
END_IF
TimeDelayControl[4](IN:= ioKuka.Cmd.DRIVES_OFF, PT:=T#500MS );
IF TimeDelayControl[4].Q AND NOT ioKuka.Status.Ready THEN
	ioKuka.Cmd.DRIVES_ON:=TRUE;
ELSE
	ioKuka.Cmd.DRIVES_ON:=FALSE;
END_IF


//启动机器人程序
//启动
IF iMode.Out.AutoRun_R OR iMode.Out.HomeStart_R THEN
	ioKuka.Cmd.EXT_START:=TRUE;
END_IF

TimeDelayControl[5](IN:= ioKuka.Cmd.EXT_START, PT:=T#500MS );
IF TimeDelayControl[5].Q OR ioKuka.Status.PRO_ACT OR ioKuka.Status.STOPMESS THEN
	ioKuka.Cmd.EXT_START:=FALSE;
END_IF

//请求程序号
IF ioKuka.Status.PGNO_REQ THEN
	ioKuka.Cmd.PGNO_VALID:=TRUE;
END_IF
TimeDelayControl[6](IN:= ioKuka.Cmd.PGNO_VALID, PT:=T#1S );
IF TimeDelayControl[6].Q THEN
	ioKuka.Cmd.EXT_START:=FALSE;
	ioKuka.Cmd.PGNO_VALID:=FALSE;
END_IF



//设备状态映射
ioKuka.Cmd.Speed:=REAL_TO_INT(iSpeed);//速度
ioKuka.Cmd.MachineAutoRun:=iMode.Status.AutoRunning;//设备自动运转中
ioKuka.Cmd.MachineStepRun:=iMode.Status.StepRunning;//设备单步运转中
ioKuka.Cmd.ProductType:=iProductType;//产品型号



