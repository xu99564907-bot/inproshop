

//启动
TimeDelayControl[0](IN:= ioEpson.Cmd.Rob_Start, PT:=T#1S );
IF TimeDelayControl[0].Q OR ioEpson.Status.Running OR ioEpson.Status.Error THEN
	ioEpson.Cmd.Rob_Start:=FALSE;
END_IF


//停止
IF (ioEpson.Status.Running OR ioEpson.Status.Error) AND (iMode.Out.HomeStart_R OR iMode.Status.EStop OR iMode.Out.HomeOK_F OR( NOT iMode.Status.HomeOK AND iMode.Out.HomeStart_F) ) THEN
	ioEpson.Cmd.Rob_Stop:=TRUE;
END_IF

TimeDelayControl[1](IN:= ioEpson.Cmd.Rob_Stop, PT:=T#1S );
IF ioEpson.Status.Ready OR TimeDelayControl[1].Q THEN
	ioEpson.Cmd.Rob_Stop:=FALSE;
END_IF


//复位
IF (ioEpson.Status.Error OR ioEpson.Status.EStopOn OR ioEpson.Status.SafeguardOn) OR iMode.Out.ErrorReset THEN
	ioEpson.Cmd.Rob_Reset:=TRUE;
END_IF

TimeDelayControl[2](IN:= ioEpson.Cmd.Rob_Reset, PT:=T#1S );
IF TimeDelayControl[2].Q THEN
	ioEpson.Cmd.Rob_Reset:=FALSE;
END_IF


//暂停
IF ioEpson.Status.Running AND (iMode.Out.AutoRun_R OR iMode.Out.Stop) THEN
	ioEpson.Cmd.Rob_Pause:=TRUE;
END_IF

TimeDelayControl[3](IN:= ioEpson.Cmd.Rob_Pause, PT:=T#1S );
IF TimeDelayControl[3].Q OR ioEpson.Status.Paused OR ioEpson.Status.Error  OR ioEpson.Status.EStopOn OR ioEpson.Status.SafeguardOn THEN
	ioEpson.Cmd.Rob_Pause:=FALSE;
END_IF


//继续
IF ioEpson.Status.Paused AND iMode.Out.AutoRun_R  THEN
	ioEpson.Cmd.Rob_Continue:=TRUE;
END_IF

TimeDelayControl[4](IN:= ioEpson.Cmd.Rob_Pause, PT:=T#1S );
IF TimeDelayControl[4].Q OR  ioEpson.Status.Ready OR ioEpson.Status.Running OR ioEpson.Status.Error OR ioEpson.Status.EStopOn OR ioEpson.Status.SafeguardOn THEN
	ioEpson.Cmd.Rob_Continue:=FALSE;
END_IF


//设备状态映射
ioEpson.Cmd.Speed:=REAL_TO_INT(iSpeed);//速度
ioEpson.Cmd.MachineAutoRun:=iMode.Status.AutoRunning;//设备自动运转中
ioEpson.Cmd.MachineStepRun:=iMode.Status.StepRunning;//设备单步运转中
ioEpson.Cmd.ProductType:=iProductType;//产品型号





