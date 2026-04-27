
//延时时间
IntitalTimeDelay[2,0](IN:=Init[2].Step=5,PT:=T#500MS);
IntitalTimeDelay[2,1]();
IntitalTimeDelay[2,2]();
IntitalTimeDelay[2,3]();
IntitalTimeDelay[2,4]();
IntitalTimeDelay[2,5]();

//初始化完成状态清除
IF DB4070_Fault.EstopTotal OR DB4070_Fault.StopTotal OR DB4000_Control.Mode.Status.ManualMode OR DB4000_Control.Mode.Out.Stop THEN
	Init[2].Step:=0;
	Init[2].Running:=FALSE;
END_IF

//启动回原
IF DB4000_Control.Mode.Out.HomeStart_R AND NOT Init[2].Running THEN
	Init[2].Running:=TRUE;
	Init[2].Complete:=FALSE;
	Init[2].Step:=5;
	Init[2].Comment:="初始化开始";
END_IF

IF Init[2].Running THEN
	
	CASE Init[2].Step OF
		5 :
			Init[2].Comment:="初始化开始判定";
			IF IntitalTimeDelay[2,0].Q THEN
				IF Auto[2].Disable THEN
					Init[2].Step:=1000;
				ELSE
					Init[2].Step:=10;
				END_IF		
			END_IF
						
		10:
			Init[2].Comment:="等待码垛机械手在安全区域";
			IF NOT DB4050_DriveControl.Kuka[2].Status.InterFace_B[57] THEN
				Init[2].Step:=20;
			END_IF

			
		100:
			Init[2].Comment:="拔管解扣气缸上升";
			DB4050_DriveControl.CylCtrl[Enum_OP40_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB4050_DriveControl.CylCtrl[Enum_OP40_Cyl.气缸1].Status.InWork THEN
				Init[2].Step:=110;
			END_IF
			
		110:			
			Init[2].Comment:="插管测试气缸下降";
			DB4050_DriveControl.CylCtrl[Enum_OP40_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB4050_DriveControl.CylCtrl[Enum_OP40_Cyl.气缸1].Status.InHome THEN
				Init[2].Step:=120;
			END_IF	
			
		120:
			Init[2].Comment:="拔管解扣气缸下降";
			DB4050_DriveControl.CylCtrl[Enum_OP40_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB4050_DriveControl.CylCtrl[Enum_OP40_Cyl.气缸1].Status.InHome THEN
				Init[2].Step:=130;
			END_IF	

		130:
			Init[2].Comment:="夹爪夹料松开";
			DB4050_DriveControl.CylCtrl[Enum_OP40_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB4050_DriveControl.CylCtrl[Enum_OP40_Cyl.气缸1].Status.InHome THEN
				Init[2].Step:=140;
			END_IF			

		140:
			Init[2].Comment:="Z2轴下降";
			DB4050_DriveControl.AxisCtrl[Enum_OP30_Axis.Z2].Cmd.AutoABS:=1;
			IF DB4050_DriveControl.AxisCtrl[Enum_OP30_Axis.Z2].Status.InPoint[1] THEN
				Init[2].Step:=180;
			END_IF



		180:
			Init[2].Comment:="驱动齿轮气缸_缩回";
			DB4050_DriveControl.CylCtrl[Enum_OP40_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB4050_DriveControl.CylCtrl[Enum_OP40_Cyl.气缸1].Status.InHome THEN
				Init[2].Step:=1000;
			END_IF
			
		 
		
		1000:
			Init[2].Comment:="工位初始化完成，等待下工位完成";
			Init[2].Running:=FALSE;
			Init[2].Complete:=TRUE;
			Init[2].Step:=0;
			
	ELSE
		;
	END_CASE
	
END_IF

















