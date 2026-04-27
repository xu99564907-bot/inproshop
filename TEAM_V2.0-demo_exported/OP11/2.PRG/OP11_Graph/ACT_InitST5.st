
//延时时间
IntitalTimeDelay[5,0](IN:=Init[5].Step=5,PT:=T#500MS);
IntitalTimeDelay[5,1]();
IntitalTimeDelay[5,2]();
IntitalTimeDelay[5,3]();
IntitalTimeDelay[5,4]();
IntitalTimeDelay[5,5]();

//初始化完成状态清除
IF DB1170_Fault.EstopTotal OR DB1170_Fault.StopTotal OR DB1100_Control.Mode.Status.ManualMode OR DB1100_Control.Mode.Out.Stop THEN
	Init[5].Step:=0;
	Init[5].Running:=FALSE;
END_IF

//启动回原
IF DB1100_Control.Mode.Out.HomeStart_R AND NOT Init[5].Running THEN
	Init[5].Running:=TRUE;
	Init[5].Complete:=FALSE;
	Init[5].Step:=5;
	Init[5].Comment:="初始化开始";
END_IF

IF Init[5].Running THEN
	
	CASE Init[5].Step OF
		5 :
			Init[5].Comment:="初始化开始判定";
			IF IntitalTimeDelay[5,0].Q THEN
				IF Auto[5].Disable THEN
					Init[5].Step:=1000;
				ELSE
					Init[5].Step:=20;
				END_IF		
			END_IF			
		
		20:
			Init[5].Comment:="判定记忆状态";
			IF TRUE THEN 
				Init[5].Step:=100;
			END_IF
			
		100:
			Init[5].Comment:="触发流程";
		 
			Init[5].Step:=150;
			
		150:
			Init[5].Comment:="等待机械手到达安全位置";
			IF DB1150_DriveControl.KUKA[1].Status.Intialed THEN
				Init[5].Step:=200;
			END_IF
		
		200:
			Init[5].Comment:="X1轴前往待机取料位";
			DB1150_DriveControl.AxisCtrl[Enum_OP11_Axis.X1].Cmd.AutoABS:=1;
			IF DB1150_DriveControl.AxisCtrl[Enum_OP11_Axis.X1].Status.InPoint[1]  THEN
				Init[5].Step:=1000;
			END_IF
		
		1000:
			Init[5].Comment:="工位初始化完成，等待下工位完成";
			Init[5].Running:=FALSE;
			Init[5].Complete:=TRUE;
			Init[5].Step:=0;
	ELSE
		;
	END_CASE
	
END_IF
