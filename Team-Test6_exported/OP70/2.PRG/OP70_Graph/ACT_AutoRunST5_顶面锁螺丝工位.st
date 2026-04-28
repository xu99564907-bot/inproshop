
//延时时间
AutoTimeDelay[5,0](IN:=Auto[5].Step=5,PT:=T#500MS);
AutoTimeDelay[5,1](IN:=Auto[5].Step=325,PT:=T#10000MS);
AutoTimeDelay[5,2](IN:=Auto[5].Step=257,PT:=T#200MS);
AutoTimeDelay[5,3](IN:=Auto[5].Step=317,PT:=T#200MS);
AutoTimeDelay[5,4](IN:=Auto[5].Step=131,PT:=T#200MS);
AutoTimeDelay[5,5](IN:=Auto[5].Step=640,PT:=T#200MS);
//清除流程步
IF NOT DB7000_Control.Mode.Status.HomeOK THEN
	Auto[5].Step:=0;
	Auto[5].Running:=FALSE;
END_IF

//单元周期计时
IF Auto[5].Running AND CPU_Clock.Clock_100ms_R THEN
	Auto[5].CycleTime:=Auto[5].CycleTime+1;
END_IF

//工程启动条件
Start[3]:=TRUE;//有产品未完成


//工程启动
IF DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.HomeOK AND Init[5].Complete AND NOT Auto[5].Running THEN
	IF (Start[3] AND NOT DB7000_Control.Mode.Status.StationMode) OR 
		(Auto[5].Start AND DB7000_Control.Mode.Status.StationMode) THEN
		Auto[5].Running:=TRUE;
		Auto[5].Step:=5;
		Auto[5].CycleTime:=0;
		Auto[5].Comment:="工程启动";
		 
		Auto[5].Start:=FALSE;
	END_IF
END_IF

RunAgin: //再次执行Case条件命令，节省一个扫描周期
Auto[5].StepBefor := Auto[5].Step;

//流程不暂停条件
Auto[5].NoPausedRunning:=FALSE;


//工程运转中
IF (DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.StepRunning) OR Auto[5].NoPausedRunning THEN
	CASE Auto[5].Step OF
		5 :
			Auto[5].Comment:="工程启动";
			IF DB7050_DriveControl.Sensor[Enum_OP70_Sensor.传感器1].Status._ON  THEN
				Auto[5].Step:=10;
			ELSE
				 ;//物料未检测到异常
			END_IF		
			
		10:			
	   		Auto[5].Comment:="定位X-Y气缸动作"; 
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Auto[5].Step:=20;
			END_IF
	
			
		20:			
	   		Auto[5].Comment:="平台3物料压紧气缸下降";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF    DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Auto[5].Step:=50;
			END_IF

		50:
			Auto[5].Comment:="触发扫码";
			DB7050_DriveControl.CodeCtrl[3].Cmd.Execute:=TRUE;
			IF DB7050_DriveControl.CodeCtrl[3].Status.Result=DB7090_Other.StationData[7].ProductCode THEN
				Auto[5].Step:=80;
			ELSIF DB7050_DriveControl.PrintCtrl[1].Cmd.Disable THEN
				Auto[5].Step:=80;
			ELSIF AutoTimeDelay[5,1].Q THEN
				 ;//扫码失败报警
			END_IF
			
		80:	
			Auto[5].Comment:="判定螺丝是否锁附完成";
		    IF  DB7050_DriveControl.ESDCtrl[3].Status.VolNum> DB7050_DriveControl.ESDCtrl[3].Parm.GoalNum  THEN
				Auto[5].Step:=200;
			ELSE
				Auto[5].Step:=90;
			END_IF	

		90:
			Auto[5].Comment:="等待送螺钉到位";
			//IF DB7050_DriveControl.ScrewCtrl[2].Status.Done THEN
				Auto[5].Step:=100;
			//END_IF
		
		100 :
			Auto[5].Comment:=FC_LCONCAT( "X轴Y轴前往锁附位置",INT_TO_WSTRING(DB7050_DriveControl.ESDCtrl[3].Status.VolNum));
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X6].Cmd.AutoABS:=DB7050_DriveControl.ESDCtrl[3].Status.VolNum+1;
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y3].Cmd.AutoABS:=DB7050_DriveControl.ESDCtrl[3].Status.VolNum+1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X6].Status.InPoint[DB7050_DriveControl.ESDCtrl[3].Status.VolNum+1] 
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y3].Status.InPoint[DB7050_DriveControl.ESDCtrl[3].Status.VolNum+1] THEN
				Auto[5].Step:=110;
			END_IF
			
		110:
			Auto[5].Comment:="等待送螺钉到位";
			IF DB7050_DriveControl.ScrewCtrl[3].Status.Done THEN
				Auto[5].Step:=120;
			END_IF	
		
		120:			
	   		Auto[5].Comment:="电批3整体上下气缸下降";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Auto[5].Step:=125;
			END_IF	
			
		125:			
	   		Auto[5].Comment:="真空吸打开";
			DB7050_DriveControl.VacCtrl[Enum_OP70_Vac.真空1].Cmd.AutoToWork :=TRUE;
			IF DB7050_DriveControl.VacCtrl[Enum_OP70_Vac.真空1].Status.InWork  THEN
				Auto[5].Step:=130;
			END_IF
			
		130:			
	   		Auto[5].Comment:="电批3鸟嘴上下气缸下降";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Cmd.AutoABS:=8;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork 
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Status.InPoint[8] THEN
				Auto[5].Step:=131;
			END_IF
			
		131:	
			Auto[5].Comment:="等待";
			IF  AutoTimeDelay[5,4].Q THEN
				Auto[5].Step:=135;
			END_IF
			
		135 :
			Auto[5].Comment:=FC_LCONCAT( "Z轴前往锁附位置",INT_TO_WSTRING(DB7050_DriveControl.ESDCtrl[3].Status.VolNum));	
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Cmd.AutoABS:=DB7050_DriveControl.ESDCtrl[3].Status.VolNum+1;
			DB7050_DriveControl.ESDCtrl[3].Cmd.AutoStart:=TRUE;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Status.InPoint[DB7050_DriveControl.ESDCtrl[3].Status.VolNum+1]  THEN
				Auto[5].Step:=140;
			END_IF			
			
		140:
	   		Auto[5].Comment:="锁螺丝";
			 
				Auto[5].Step:=150; 		
			 
			
		150:			
	   		Auto[5].Comment:="电批3上下气缸上升";
		 
				Auto[5].Step:=160;
		 
			
		160:			
	   		Auto[5].Comment:="Z1回原点";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Status.InPoint[1]  THEN				
				Auto[5].Step:=170;
			END_IF
			
		170:			
	   		Auto[5].Comment:="判定是否锁附完成";
		    IF  DB7050_DriveControl.ESDCtrl[3].Status.VolNum> DB7050_DriveControl.ESDCtrl[3].Parm.GoalNum  THEN
				Auto[5].Step:=200;
			ELSE
				Auto[5].Step:=90;
			END_IF


		200:			
	   		Auto[5].Comment:="判定螺母是否已经锁附";		
 		    IF  DB7050_DriveControl.ESDCtrl[4].Status.VolNum > DB7050_DriveControl.ESDCtrl[4].Parm.GoalNum  THEN
 				Auto[5].Step:=500;
 			ELSE
				Auto[5].Step:=210;
 			END_IF			

		210:
			Auto[5].Comment:="判定披头上是否有螺母";
			IF DB7050_DriveControl.VacCtrl[Enum_OP70_Vac.真空1].DevStatus.Sensor_Home THEN
				Auto[5].Step:=250;
			ELSE
				Auto[5].Step:=300;
			END_IF

		250 :
			Auto[5].Comment:= "X轴Y轴前往取螺母位置";
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X6].Cmd.AutoABS:=9;
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y3].Cmd.AutoABS:=9;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X6].Status.InPoint[9] 
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y3].Status.InPoint[9] THEN
				Auto[5].Step:=255;
			END_IF
			
		255:
			Auto[5].Comment:="等待送螺母到位";
			IF DB7050_DriveControl.ScrewCtrl[4].Status.Ready THEN
				Auto[5].Step:=256;
			END_IF	
			
		256 :
			Auto[5].Comment:="Z轴前往取螺母位置";	
		 
				Auto[5].Step:=257;
 
		257 :	
		   Auto[5].Comment:="等待";
		   DB7050_DriveControl.ESDCtrl[4].Parm.Velocity:= DB7050_DriveControl.ESDCtrl[4].Parm.Velocity1;
		   DB7050_DriveControl.ESDCtrl[4].Parm.Torque:= DB7050_DriveControl.ESDCtrl[4].Parm.Torque1;
		   IF AutoTimeDelay[5,2].Q  THEN
				Auto[5].Step:=260;
			END_IF
			
		260 :
			Auto[5].Comment:="Z轴前往取螺母位置";	
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Cmd.AutoABS:=2;
			DB7050_DriveControl.ESDCtrl[4].Cmd.AutoStart:=TRUE;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Status.InPoint[2] THEN
				Auto[5].Step:=270;
			END_IF

		270 :
			Auto[5].Comment:="真空打开";	
		 
				Auto[5].Step:=280;
 
			
		280 :
			Auto[5].Comment:="电批4上下气缸抬起";	
 
				Auto[5].Step:=300;
 	
			
		300 :
			Auto[5].Comment:="Z轴前往初始位置";	
			 
				Auto[5].Step:=310;
			 

		310:			
	   		Auto[5].Comment:="X6,Y3前往锁螺母位置";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X6].Cmd.AutoABS:=10;
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y3].Cmd.AutoABS:=10;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X6].Status.InPoint[10]
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y3].Status.InPoint[10]  THEN				
				Auto[5].Step:=315;
			END_IF
		
		315:			
	   		Auto[5].Comment:="电批4上下气缸下降";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Auto[5].Step:=316;
			END_IF	
		
		316 :
			Auto[5].Comment:="Z轴前往锁螺母位置";	
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Cmd.AutoABS:=6;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Status.InPoint[6]  THEN
				Auto[5].Step:=317;
			END_IF	
		
		317 :	
		   Auto[5].Comment:="等待";
		   DB7050_DriveControl.ESDCtrl[4].Parm.Velocity:= DB7050_DriveControl.ESDCtrl[4].Parm.Velocity2;
		   DB7050_DriveControl.ESDCtrl[4].Parm.Torque:= DB7050_DriveControl.ESDCtrl[4].Parm.Torque2;
		   IF AutoTimeDelay[5,3].Q  THEN
				Auto[5].Step:=320;
			END_IF
		
		320 :
			Auto[5].Comment:="Z轴前往锁螺母位置";	
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Cmd.AutoABS:=3;
			DB7050_DriveControl.ESDCtrl[4].Cmd.AutoStart:=TRUE;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Status.InPoint[3]  THEN
				Auto[5].Step:=325;
			END_IF	
		
		325:			
	   		Auto[5].Comment:="锁螺母";
		 
				Auto[5].Step:=330; 		
		 
			
		330:
	   		Auto[5].Comment:="电批4上下气缸上升";
		 
				Auto[5].Step:=340;
		 

		340 :
			Auto[5].Comment:="Z轴前往初始位置";	
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z4].Status.InPoint[1]  THEN
				Auto[5].Step:=500;
			END_IF	

			
		500:			
	   		Auto[5].Comment:="平台3物料压紧气缸上升";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Auto[5].Step:=530;
			END_IF
			
		530:			
	   		Auto[5].Comment:="定位X-Y气缸回";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome THEN
				Auto[5].Step:=540;
			END_IF
						
		540:			
	   		Auto[5].Comment:="判断产品OK/NG";
			 
			Auto[5].Step:=1000;
 
		1000:
			Auto[5].Comment:="工程结束";
			Auto[5].Running:=FALSE;
			Auto[5].Step:=0;

		;
	ELSE
		;
	END_CASE
	;
END_IF
 

 



//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[5].StepBefor <> Auto[5].Step THEN
	JMP RunAgin;
END_IF

