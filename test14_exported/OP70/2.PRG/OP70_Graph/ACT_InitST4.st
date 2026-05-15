
//延时时间
IntitalTimeDelay[4,0](IN:=Init[4].Step=5,PT:=T#500MS);
IntitalTimeDelay[4,1]();
IntitalTimeDelay[4,2]();
IntitalTimeDelay[4,3]();
IntitalTimeDelay[4,4]();
IntitalTimeDelay[4,5]();

//初始化完成状态清除
IF DB7070_Fault.EstopTotal OR DB7070_Fault.StopTotal OR DB7000_Control.Mode.Status.ManualMode OR DB7000_Control.Mode.Out.Stop THEN
	Init[4].Step:=0;
	Init[4].Running:=FALSE;
END_IF

//启动回原
IF DB7000_Control.Mode.Out.HomeStart_R AND NOT Init[4].Running THEN
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
				Init[4].Step:=10;
			END_IF
			
		10:
	   		Init[4].Comment:="电批2上下气缸上升";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Init[4].Step:=20;
			END_IF	
		
		20:
	   		Init[4].Comment:="Z2回原点";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z2].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z2].Status.InPoint[1]  THEN				
				Init[4].Step:=30;
			END_IF	
			
		30:			
	   		Init[4].Comment:="X5,Y2回原点";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X5].Cmd.AutoABS:=1;
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y2].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X5].Status.InPoint[1] 
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y2].Status.InPoint[1]  THEN				
				Init[4].Step:=40;
			END_IF			
			
		40:
	   		Init[4].Comment:="电批2上下气缸下降";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Init[4].Step:=50;
			END_IF			
			
		50:
	   		Init[4].Comment:="电批2上下气缸上升";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Init[4].Step:=60;
			END_IF				
			
		60:
			Init[4].Comment:="出钉,等待备钉完成";
			DB7050_DriveControl.ScrewCtrl[2].Cmd.AutoStart:=TRUE;
			IF DB7050_DriveControl.ScrewCtrl[2].Status.Ready THEN
				Init[4].Step:=70;	
			END_IF;
		
		70:
			Init[4].Comment:="结束";
			Init[4].Step:=1000;

		1000:
			Init[4].Comment:="工位初始化完成，等待下工位完成";
			Init[4].Running:=FALSE;
			Init[4].Complete:=TRUE;
			Init[4].Step:=0;
		
	ELSE
		;
	END_CASE
	
END_IF

















