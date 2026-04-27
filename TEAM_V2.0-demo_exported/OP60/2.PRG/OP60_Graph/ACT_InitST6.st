
//延时时间
IntitalTimeDelay[6,0](IN:=Init[6].Step=5,PT:=T#500MS);
IntitalTimeDelay[6,1]();
IntitalTimeDelay[6,2]();
IntitalTimeDelay[6,3]();
IntitalTimeDelay[6,4]();
IntitalTimeDelay[6,5]();

//初始化完成状态清除
IF DB6070_Fault.EstopTotal OR DB6070_Fault.StopTotal OR DB6000_Control.Mode.Status.ManualMode OR DB6000_Control.Mode.Out.Stop THEN
	Init[6].Step:=0;
	Init[6].Running:=FALSE;
END_IF

//启动回原
IF DB6000_Control.Mode.Out.HomeStart_R AND NOT Init[6].Running THEN
	Init[6].Running:=TRUE;
	Init[6].Complete:=FALSE;
	Init[6].Step:=5;
	Init[6].Comment:="初始化开始";
END_IF

IF Init[6].Running THEN
	
	CASE Init[6].Step OF
		5 :
			Init[6].Comment:="初始化开始判定";
			IF IntitalTimeDelay[6,0].Q THEN
				IF Auto[6].Disable THEN
					Init[6].Step:=1000;
				ELSE
					Init[6].Step:=20;
				END_IF		
			END_IF
		
		20:
			Init[6].Comment:="判定记忆状态";
			 
				Init[6].Step:=100;
			 	
			
		100:
			Init[6].Comment:="等待机械手到达安全位置";
			DB6050_DriveControl.KUKA[2].Cmd.EXT_Stop:=TRUE;
			DB6050_DriveControl.Kuka[2].Cmd.InterFace_Register4:=0;
			DB6050_DriveControl.Kuka[2].Cmd.StepNum:=0;		
			Init[6].Step:=150;
			
		150:
			Init[6].Comment:="等待机械手到达安全位置";
			IF DB6050_DriveControl.KUKA[2].Status.Intialed THEN
				Init[6].Step:=200;
			END_IF
		
		200:
			Init[6].Comment:="X1轴前往待机取料位";
			DB6050_DriveControl.AxisCtrl[Enum_OP60_Axis.X2].Cmd.AutoABS:=1;
			IF DB6050_DriveControl.AxisCtrl[Enum_OP60_Axis.X2].Status.InPoint[1]  THEN
				Init[6].Step:=1000;
			END_IF
		
		1000:
			Init[6].Comment:="工位初始化完成，等待下工位完成";
			Init[6].Running:=FALSE;
			Init[6].Complete:=TRUE;
			Init[6].Step:=0;
	ELSE
		;
	END_CASE
	
END_IF
