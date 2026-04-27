

//启动
TimeDelayControl[0](IN:= ioKuka.Cmd.Rob_Start, PT:=T#3S );
IF TimeDelayControl[0].Q OR ioKuka.Status.Running OR ioKuka.Status.Error THEN
	ioKuka.Cmd.Rob_Start:=FALSE;
END_IF


//停止
IF (iMode.Out.HomeStart_R AND NOT iMode.Status.HomeOK ) OR (iMode.Status.EStop ) THEN
	ioKuka.Cmd.Rob_Stop:=TRUE;
END_IF

TimeDelayControl[1](IN:= ioKuka.Cmd.Rob_Stop, PT:=T#3S );
IF TimeDelayControl[1].Q THEN
	ioKuka.Cmd.Rob_Stop:=FALSE;
END_IF


//复位
IF (ioKuka.Status.Error OR ioKuka.Status.EStopOn OR ioKuka.Status.SafeguardOn OR NOT ioKuka.Status.Ready) AND iMode.Out.ErrorReset  THEN
	ioKuka.Cmd.Acknoledgment:=TRUE;
END_IF

TimeDelayControl[2](IN:= ioKuka.Cmd.Acknoledgment, PT:=T#1S );
IF TimeDelayControl[2].Q THEN
	ioKuka.Cmd.Acknoledgment:=FALSE;
END_IF


//暂停
IF ioKuka.Status.Running AND (iMode. Out.AutoRun_F OR iMode.Out.Stop) THEN
	ioKuka.Cmd.Rob_Pause:=TRUE;
END_IF

TimeDelayControl[3](IN:= ioKuka.Cmd.Rob_Pause, PT:=T#1S );
IF TimeDelayControl[3].Q OR ioKuka.Status.Paused OR ioKuka.Status.Error  OR ioKuka.Status.EStopOn OR ioKuka.Status.SafeguardOn THEN
	ioKuka.Cmd.Rob_Pause:=FALSE;
END_IF


//继续
IF ioKuka.Status.Paused AND iMode. Out.AutoRun_R THEN
	ioKuka.Cmd.Rob_Continue:=TRUE;
END_IF

TimeDelayControl[4](IN:= ioKuka.Cmd.Rob_Continue, PT:=T#3S );
IF TimeDelayControl[4].Q OR ioKuka.Status.Error OR ioKuka.Status.EStopOn OR ioKuka.Status.SafeguardOn THEN
	ioKuka.Cmd.Rob_Continue:=FALSE;
END_IF

//使能 
IF NOT ioKuka.Status.Actived AND NOT iMode.Status.EStop THEN
	ioKuka.Cmd.ActiveScara:=TRUE;
END_IF

IF iMode.Status.EStop THEN
	ioKuka.Cmd.ActiveScara:=FALSE;
END_IF

//安全回路复位
IF ioKuka.Status.EStopOn OR ioKuka.Status.SafeguardOn AND iMode.Out.ErrorReset THEN
	oRESET:=TRUE;
ELSE
	oRESET:=FALSE;
END_IF

//设备状态映射
ioKuka.Cmd.Speed:=REAL_TO_INT(iSpeed);//速度
ioKuka.Cmd.MachineAutoRun:=iMode.Status.AutoRunning;//设备自动运转中
ioKuka.Cmd.MachineStepRun:=iMode.Status.StepRunning;//设备单步运转中
ioKuka.Cmd.ProductType:=iProductType;//产品型号



