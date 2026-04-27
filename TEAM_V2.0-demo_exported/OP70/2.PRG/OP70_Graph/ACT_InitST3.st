
//延时时间
IntitalTimeDelay[3,0](IN:=Init[3].Step=5,PT:=T#500MS);
IntitalTimeDelay[3,1]();
IntitalTimeDelay[3,2]();
IntitalTimeDelay[3,3]();
IntitalTimeDelay[3,4]();
IntitalTimeDelay[3,5]();

//初始化完成状态清除
IF DB7070_Fault.EstopTotal OR DB7070_Fault.StopTotal OR DB7000_Control.Mode.Status.ManualMode OR DB7000_Control.Mode.Out.Stop THEN
	Init[3].Step:=0;
	Init[3].Running:=FALSE;
END_IF

//启动回原
IF DB7000_Control.Mode.Out.HomeStart_R AND NOT Init[3].Running THEN
	Init[3].Running:=TRUE;
	Init[3].Complete:=FALSE;
	Init[3].Step:=5;
	Init[3].Comment:="初始化开始";
END_IF

IF Init[3].Running THEN
	
	CASE Init[3].Step OF
		5 :
			Init[3].Comment:="初始化开始判定";
			 IF IntitalTimeDelay[3,0].Q THEN
				Init[3].Step:=10;
			END_IF
			
		10:
	   		Init[3].Comment:="电批1上下气缸上升";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Init[3].Step:=20;
			END_IF	
		
		20:
	   		Init[3].Comment:="Z1回原点";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z1].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z1].Status.InPoint[1]  THEN				
				Init[3].Step:=30;
			END_IF	
			
		30:			
	   		Init[3].Comment:="X4,Y1回原点";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X4].Cmd.AutoABS:=1;
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y1].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X4].Status.InPoint[1] AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y1].Status.InPoint[1]  THEN				
				Init[3].Step:=40;
			END_IF			
			
		40:
	   		Init[3].Comment:="电批1上下气缸下降";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Init[3].Step:=50;
			END_IF			
			
			
		50:
	   		Init[3].Comment:="电批1上下气缸上升";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Init[3].Step:=60;
			END_IF				
			
		60:
			Init[3].Comment:="出钉,等待备钉完成";
			 
			IF TRUE THEN
				Init[3].Step:=70;
			END_IF
			

		
		70:
			Init[3].Comment:="结束";
			Init[3].Step:=1000;
		
		
		1000:
			Init[3].Comment:="工位初始化完成，等待下工位完成";
			Init[3].Running:=FALSE;
			Init[3].Complete:=TRUE;
			Init[3].Step:=0;
		
	ELSE
		;
	END_CASE
	
END_IF

















