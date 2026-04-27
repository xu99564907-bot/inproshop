
//延时时间
IntitalTimeDelay[2,0](IN:=Init[2].Step=5,PT:=T#500MS);
IntitalTimeDelay[2,1](IN:=NOT DB7050_DriveControl.CamCtrl[1].Status.InCam,PT:=T#500MS);
IntitalTimeDelay[2,2]();
IntitalTimeDelay[2,3]();
IntitalTimeDelay[2,4]();
IntitalTimeDelay[2,5]();

//初始化完成状态清除
IF DB7070_Fault.EstopTotal OR DB7070_Fault.StopTotal OR DB7000_Control.Mode.Status.ManualMode OR DB7000_Control.Mode.Out.Stop THEN
	Init[2].Step:=0;
	Init[2].Running:=FALSE;
END_IF

//启动回原
IF DB7000_Control.Mode.Out.HomeStart_R AND NOT Init[2].Running THEN
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
				Init[2].Step:=10;
			END_IF
			
		10:
			Init[2].Comment:="判定夹爪是否有料";
		 
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome   THEN
				Init[2].Step:=15;
			END_IF
			
		15:
			Init[2].Comment:="同步轴解耦";
			IF IntitalTimeDelay[2,1].Q THEN
				DB7050_DriveControl.CamCtrl[1].Cmd.GearOut:=FALSE;
				Init[2].Step:=20;
			END_IF
			
		20:
			Init[2].Comment:="定位气缸打开，真空关闭";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE; 
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Init[2].Step:=25;
			END_IF	
		
		25:
			Init[2].Comment:="等待锁螺丝工位初始化完成";
			IF Init[3].Complete AND Init[4].Complete 
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Status.InPoint[1]
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Status.InPoint[1] THEN
				Init[2].Step:=30;
			END_IF 
		
		30:
			Init[2].Comment:="前往取料位置";
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X2].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X2].Status.InPoint[1] THEN
				Init[2].Step:=50;
			END_IF
			
		50:
			Init[2].Comment:="前往取料位置";
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X3].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X3].Status.InPoint[1] THEN
				Init[2].Step:=60;
			END_IF		
		
         60:			
	   		Init[2].Comment:="旋转气缸取料位";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
		 
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Init[2].Step:=70;
			END_IF	
			
         70:			
	   		Init[2].Comment:="压紧气缸上升";
			 
				Init[2].Step:=80;
			 
         80:			
	   		Init[2].Comment:="顶升气缸下降";
			 
				Init[2].Step:=100;
			 
			
		100:
			Init[2].Comment:="同步轴耦合";
			DB7050_DriveControl.CamCtrl[1].Cmd.GearIn:=TRUE;
			DB7050_DriveControl.CamCtrl[1].Cmd.GearOut:=FALSE;
			IF DB7050_DriveControl.CamCtrl[1].Status.InCam THEN
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

















