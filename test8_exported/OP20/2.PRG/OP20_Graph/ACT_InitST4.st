
//延时时间
IntitalTimeDelay[4,0](IN:=Init[4].Step=5,PT:=T#500MS);
IntitalTimeDelay[4,1]();
IntitalTimeDelay[4,2]();
IntitalTimeDelay[4,3]();
IntitalTimeDelay[4,4]();
IntitalTimeDelay[4,5]();

//初始化完成状态清除
IF DB2070_Fault.EstopTotal OR DB2070_Fault.StopTotal OR DB2000_Control.Mode.Status.ManualMode OR DB2000_Control.Mode.Out.Stop THEN
	Init[4].Step:=0;
	Init[4].Running:=FALSE;
END_IF

//启动回原
IF DB2000_Control.Mode.Out.HomeStart_R AND NOT Init[4].Running THEN
	Init[4].Running:=TRUE;
	Init[4].Complete:=FALSE;
	Init[4].Step:=5;
	Init[4].Comment:="初始化开始";
END_IF

IF Init[4].Running THEN
	
	CASE Init[4].Step OF
		5 :
			Init[4].Comment:="初始化开始判定";
			IF IntitalTimeDelay[4,0].Q THEN
				IF Auto[4].Disable THEN
					Init[4].Step:=1000;
				ELSE
					Init[4].Step:=10;
				END_IF		
			END_IF	
			
		10:
			Init[4].Comment:="等待码垛机械手在安全区域";
			IF NOT DB2050_DriveControl.Kuka[2].Status.InterFace_B[57] THEN
				Init[4].Step:=20;
			END_IF

			
		100:
			Init[4].Comment:="拔管解扣气缸上升";
			DB2050_DriveControl.CylCtrl[Enum_OP20_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB2050_DriveControl.CylCtrl[Enum_OP20_Cyl.气缸1].Status.InWork THEN
				Init[4].Step:=110;
			END_IF
			
		110:			
			Init[4].Comment:="插管测试气缸下降";
			DB2050_DriveControl.CylCtrl[Enum_OP20_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB2050_DriveControl.CylCtrl[Enum_OP20_Cyl.气缸1].Status.InHome THEN
				Init[4].Step:=120;
			END_IF	
			
		120:
			Init[4].Comment:="拔管解扣气缸下降";
			DB2050_DriveControl.CylCtrl[Enum_OP20_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB2050_DriveControl.CylCtrl[Enum_OP20_Cyl.气缸1].Status.InHome THEN
				Init[4].Step:=130;
			END_IF	

		130:
			Init[4].Comment:="夹爪夹料松开";
			DB2050_DriveControl.CylCtrl[Enum_OP20_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB2050_DriveControl.CylCtrl[Enum_OP20_Cyl.气缸1].Status.InHome THEN
				Init[4].Step:=140;
			END_IF			

		140:
			Init[4].Comment:="Z4轴下降";
			DB2050_DriveControl.AxisCtrl[Enum_OP20_Axis.Z4].Cmd.AutoABS:=1;
			IF DB2050_DriveControl.AxisCtrl[Enum_OP20_Axis.Z4].Status.InPoint[1] THEN
				Init[4].Step:=180;
			END_IF

		180:
			Init[4].Comment:="驱动齿轮气缸_缩回";
			DB2050_DriveControl.CylCtrl[Enum_OP20_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB2050_DriveControl.CylCtrl[Enum_OP20_Cyl.气缸1].Status.InHome THEN
				Init[4].Step:=1000;
			END_IF
			
		 
		
		
		1000:
			Init[4].Comment:="工位初始化完成，等待下工位完成";
			Init[4].Running:=FALSE;
			Init[4].Complete:=TRUE;
			Init[4].Step:=0;
	ELSE
		;
	END_CASE
	
END_IF

















