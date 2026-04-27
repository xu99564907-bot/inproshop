
//延时时间
IntitalTimeDelay[5,0](IN:=Init[5].Step=5,PT:=T#500MS);
IntitalTimeDelay[5,1]();
IntitalTimeDelay[5,2]();
IntitalTimeDelay[5,3]();
IntitalTimeDelay[5,4]();
IntitalTimeDelay[5,5]();

//初始化完成状态清除
IF DB7070_Fault.EstopTotal OR DB7070_Fault.StopTotal OR DB7000_Control.Mode.Status.ManualMode OR DB7000_Control.Mode.Out.Stop THEN
	Init[5].Step:=0;
	Init[5].Running:=FALSE;
END_IF

//启动回原
IF DB7000_Control.Mode.Out.HomeStart_R AND NOT Init[5].Running THEN
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
				Init[5].Step:=10;
			END_IF
		10:
	   		Init[5].Comment:="电批4上下气缸上升";
			 
				Init[5].Step:=20;
			 
		20:
	   		Init[5].Comment:="Z3,Z4回原点";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Cmd.AutoABS:=1;
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Status.InPoint[1]
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Status.InPoint[1] THEN				
				Init[5].Step:=30;
			END_IF	
			
		30:			
	   		Init[5].Comment:="X6,Y3回原点";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X6].Cmd.AutoABS:=1;
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y3].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X6].Status.InPoint[1] 
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y3].Status.InPoint[1]  THEN				
				Init[5].Step:=40;
			END_IF			
			
		40:
	   		Init[5].Comment:="电批4上下气缸下降";
		 
			DB7050_DriveControl.VacCtrl[Enum_OP70_Vac.真空1].Cmd.AutoToHome :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Init[5].Step:=50;
			END_IF			

		50:
	   		Init[5].Comment:="电批4上下气缸上升";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Init[5].Step:=100;
			END_IF

		100:
			Init[5].Comment:="等待搬运工位初始化完成";
			IF Init[2].Complete THEN
				Init[5].Step:=110;
			END_IF;

		110:			
	   		Init[5].Comment:="X6,Y3去抛钉位";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X6].Cmd.AutoABS:=11;
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y3].Cmd.AutoABS:=11;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X6].Status.InPoint[11] 
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y3].Status.InPoint[11]  THEN				
				Init[5].Step:=120;
			END_IF	

		120:
	   		Init[5].Comment:="Z3去抛钉位";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Cmd.AutoABS:=11;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Status.InPoint[11] THEN				
				Init[5].Step:=130;
			END_IF	
		
		130:
	   		Init[5].Comment:="电批3鸟嘴上下气缸下降"; 
			DB7050_DriveControl.VacCtrl[Enum_OP70_Vac.真空1].Cmd.AutoToHome :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Init[5].Step:=140;
			END_IF			
			
		140:
	   		Init[5].Comment:="电批3鸟嘴上下气缸下降";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Init[5].Step:=150;
			END_IF	

		150:
	   		Init[5].Comment:="Z3,Z4回原点";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Cmd.AutoABS:=1;
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Status.InPoint[1]
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Status.InPoint[1] THEN				
				Init[5].Step:=160;
			END_IF	
			
		160:			
	   		Init[5].Comment:="X6,Y3回原点";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X6].Cmd.AutoABS:=1;
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y3].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X6].Status.InPoint[1] 
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y3].Status.InPoint[1]  THEN				
				Init[5].Step:=200;
			END_IF

		200:
			Init[5].Comment:="出钉,等待备钉完成";
			DB7050_DriveControl.ScrewCtrl[3].Cmd.AutoStart:=TRUE;
			IF DB7050_DriveControl.ScrewCtrl[3].Status.Ready THEN
				Init[5].Step:=300;	
			END_IF;

		
		300:
			Init[5].Comment:="结束";
			Init[5].Step:=1000;
			
		1000:
			Init[5].Comment:="工位初始化完成，等待下工位完成";
			Init[5].Running:=FALSE;
			Init[5].Complete:=TRUE;
			Init[5].Step:=0;
	ELSE
		;
	END_CASE
	
END_IF

















