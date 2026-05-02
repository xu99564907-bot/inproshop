
(*****************************紧急停止************************************)
Estop_R(CLK:=DB3070_Fault.EstopTotal);
IF Estop_R.Q THEN	
	SizeOfAry(In:=EstopMAP,Out=>Size);
	FOR i:=0 TO Size-1 BY 1 DO
		IF EstopMAP[i] THEN
			DB3000_Control.HMI.Jump[0]:=1000;
			DB3000_Control.HMI.Estop.Num:=i;
			EXIT;
		END_IF
	END_FOR
	;
END_IF
(*****************************暂停************************************)
stop_R(CLK:=DB3070_Fault.StopTotal);

IF stop_R.Q THEN
	//轴报警
	SizeOfAry(In:=DB3050_DriveControl.AxisCtrl,Out=>Size);
	FOR i:=0 TO Size-1 BY 1 DO
		IF DB3050_DriveControl.AxisCtrl[i].Status.Error THEN
			DB3000_Control.HMI.Jump[0]:=1001;
			DB3000_Control.HMI.Axis.Num:=i;
			DB3000_Control.HMI.Axis.ErrID:=DB3050_DriveControl.AxisCtrl[i].Status.ErrorID;
			DB3000_Control.HMI.Axis.Name:=FC_LCONCAT(DB3050_DriveControl.AxisCtrl[i].Parm.Comment,"异常");
			EXIT;
		END_IF;
	END_FOR

	//气缸报警
	SizeOfAry(In:=DB3050_DriveControl.CylCtrl,Out=>Size);
	FOR i:=0 TO Size-1 BY 1 DO
		IF DB3050_DriveControl.CylCtrl[i].Status.Error THEN
			DB3000_Control.HMI.Jump[0]:=1002;
			DB3000_Control.HMI.Cyl.Num:=i;
			DB3000_Control.HMI.Cyl.ErrID:=DB3050_DriveControl.CylCtrl[i].Status.ErrorID;
			DB3000_Control.HMI.Cyl.Name:=FC_LCONCAT(DB3050_DriveControl.CylCtrl[i].Parm.Comment,"异常");
			EXIT;
		END_IF;
	END_FOR

	//真空报警
	SizeOfAry(In:=DB3050_DriveControl.VacCtrl,Out=>Size);
	FOR i:=0 TO Size-1 BY 1 DO
		IF DB3050_DriveControl.VacCtrl[i].Status.Error THEN
			DB3000_Control.HMI.Jump[0]:=1003;
			DB3000_Control.HMI.Vac.Num:=i;
			DB3000_Control.HMI.Vac.ErrID:=DB3050_DriveControl.VacCtrl[i].Status.ErrorID;
			DB3000_Control.HMI.Vac.Name:=FC_LCONCAT(DB3050_DriveControl.VacCtrl[i].Parm.Comment,"异常");
			EXIT;
		END_IF;
	END_FOR

	//暂停类单元报警
	FOR i:=0 TO 127 BY 1 DO
		IF StopMAP[i+385] THEN
			DB3000_Control.HMI.Jump[0]:=1010;
			DB3000_Control.HMI.Stop.Num:=i;
			EXIT;
		END_IF;
	END_FOR
	;
END_IF

(*********************提示类************************************)
Run_R(CLK:=DB3070_Fault.RunTotal);
IF Estop_R.Q THEN	
	FOR i:=0 TO 255 BY 1 DO
		IF RunMAP[i] THEN
			DB3000_Control.HMI.Jump[0]:=1011;
			DB3000_Control.HMI.Run.Num:=i;
			EXIT;
		END_IF
	END_FOR
	;
END_IF

//画面编号复位
IF DB3000_Control.Mode.Out.ErrorReset OR DB3000_Control.Mode.Out.HomeStart_F THEN
	DB3000_Control.HMI.Jump[0]:=11;
END_IF

//回原画面跳转
IF DB3000_Control.Mode.Out.HomeStart THEN
	DB3000_Control.HMI.Jump[0]:=20;
END_IF








