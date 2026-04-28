
//EstopMAP:=DB40_Fault.Estop;
(***********报警状态映射**************)

//急停类报警
Pobool_IN:=ADR(DB4070_Fault.Estop.MAP);
Pobool_OUT:=ADR(EstopMAP[0]);
FOR i:=0 TO 64 BY 1 DO	
	IF DB3000_Control.Mode.Out.ErrorReset THEN
		Pobool_IN^:=FALSE;
	END_IF
	Pobool_OUT^:=Pobool_IN^;	
	Pobool_IN:=Pobool_IN+1;
	Pobool_OUT:=Pobool_OUT+1;
END_FOR

//停止类报警
Pobool_IN:=ADR(DB4070_Fault.Stop.MAP);
Pobool_OUT:=ADR(StopMAP[0]);
FOR i:=0 TO 512 BY 1 DO
	IF DB3000_Control.Mode.Out.ErrorReset THEN
		Pobool_IN^:=FALSE;
	END_IF
	Pobool_OUT^:=Pobool_IN^;	
	Pobool_IN:=Pobool_IN+1;
	Pobool_OUT:=Pobool_OUT+1;
END_FOR

//警告
Pobool_IN:=ADR(DB4070_Fault.Run.MAP);
Pobool_OUT:=ADR(RunMAP[0]);
FOR i:=0 TO 64 BY 1 DO
	IF DB3000_Control.Mode.Out.ErrorReset THEN
		Pobool_IN^:=FALSE;
	END_IF
	Pobool_OUT^:=Pobool_IN^;	
	Pobool_IN:=Pobool_IN+1;
	Pobool_OUT:=Pobool_OUT+1;
END_FOR



//报警汇总
FOR i:=0 TO 63 BY 1 DO
	IF EstopMAP[i] THEN
		DB4070_Fault.EstopTotal:=TRUE;
		EXIT;
	ELSE
		DB4070_Fault.EstopTotal:=FALSE;
	END_IF
END_FOR

FOR i:=0 TO 511 BY 1 DO
	IF StopMAP[i] THEN
		DB4070_Fault.StopTotal:=TRUE;
		EXIT;
	ELSE
		DB4070_Fault.StopTotal:=FALSE;
	END_IF
END_FOR

FOR i:=0 TO 63 BY 1 DO
	IF RunMAP[i] THEN
		DB4070_Fault.RunTotal:=TRUE;
		EXIT;
	ELSE
		DB4070_Fault.RunTotal:=FALSE;
	END_IF
END_FOR