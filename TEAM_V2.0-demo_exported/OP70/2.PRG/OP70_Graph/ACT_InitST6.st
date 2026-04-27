
//延时时间
IntitalTimeDelay[6,0](IN:=Init[6].Step=5,PT:=T#500MS);
IntitalTimeDelay[6,1]();
IntitalTimeDelay[6,2]();
IntitalTimeDelay[6,3]();
IntitalTimeDelay[6,4]();
IntitalTimeDelay[6,5]();

//初始化完成状态清除
IF DB7070_Fault.EstopTotal OR DB7070_Fault.StopTotal OR DB7000_Control.Mode.Status.ManualMode OR DB7000_Control.Mode.Out.Stop THEN
	Init[6].Step:=0;
	Init[6].Running:=FALSE;
END_IF

//启动回原
IF DB7000_Control.Mode.Out.HomeStart_R AND NOT Init[6].Running THEN
	Init[6].Running:=TRUE;
	Init[6].Complete:=FALSE;
	Init[6].Step:=5;
	Init[6].Comment:="初始化开始";
END_IF

IF Init[6].Running THEN
	
	CASE Init[6].Step OF
		5 :
			Init[6].Comment:="初始化开始判定";
			IF IntitalTimeDelay[6,0].Q AND Init[2].Complete THEN
				Init[6].Step:=10;
			END_IF
		10:
			Init[6].Comment:="等待搬运工位初始化完成";
			IF Init[2].Complete THEN
				Init[6].Step:=15;
			END_IF;
		
		15:
			Init[6].Comment:="定位气缸伸出";
		 
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome   THEN
				Init[6].Step:=20;
			END_IF
		
		20:
			Init[6].Comment:="旋转气缸返回接料位置";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Init[6].Step:=30;
			END_IF		

		30:
			Init[6].Comment:="升降气缸下降";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Init[6].Step:=40;
			END_IF

		40:
			Init[6].Comment:="定位气缸缩回";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork THEN
				Init[6].Step:=50;
			END_IF			
		
		50:
			Init[6].Comment:="判定物料记忆状态";
		 
				Init[6].Step:=1000;
			 
		
		1000:
			Init[6].Comment:="工位初始化完成，等待下工位完成";
			Init[6].Running:=FALSE;
			Init[6].Complete:=TRUE;
			Init[6].Step:=0;		
	ELSE
		;
	END_CASE
	
END_IF

















