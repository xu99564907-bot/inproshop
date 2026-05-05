
//延时时间
AutoTimeDelay[4,0](IN:=Auto[4].Step=5,PT:=T#500MS);
AutoTimeDelay[4,1](IN:=Auto[4].Step=50,PT:=T#2S);
AutoTimeDelay[4,2]();
AutoTimeDelay[4,3]();
AutoTimeDelay[4,4]();
AutoTimeDelay[4,5]();
//清除流程步
IF NOT DB7000_Control.Mode.Status.HomeOK THEN
	Auto[4].Step:=0;
	Auto[4].Running:=FALSE;
END_IF

//单元周期计时
IF Auto[4].Running AND CPU_Clock.Clock_100ms_R THEN
	Auto[4].CycleTime:=Auto[4].CycleTime+1;
END_IF

//工程启动条件
Start[3]:=TRUE;//有产品未完成


//工程启动
IF DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.HomeOK AND Init[4].Complete AND NOT Auto[4].Running THEN
	IF (Start[3] AND NOT DB7000_Control.Mode.Status.StationMode) OR 
		(Auto[4].Start AND DB7000_Control.Mode.Status.StationMode) THEN
		Auto[4].Running:=TRUE;
		Auto[4].Step:=5;
		Auto[4].CycleTime:=0;
		Auto[4].Comment:="工程启动";
		 
		Auto[4].Start:=FALSE;
	END_IF
END_IF

RunAgin: //再次执行Case条件命令，节省一个扫描周期
Auto[4].StepBefor := Auto[4].Step;

//流程不暂停条件
Auto[4].NoPausedRunning:=FALSE;


//工程运转中
IF (DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.StepRunning) OR Auto[4].NoPausedRunning THEN
	CASE Auto[4].Step OF
		5 :
			Auto[4].Comment:="工程启动";
			IF DB7050_DriveControl.Sensor[Enum_OP70_Sensor.传感器1].Status._ON  THEN
				Auto[4].Step:=10;
			ELSE
				 ;//物料未检测到异常
			END_IF
			
		10:			
	   		Auto[4].Comment:="定位X-Y气缸动作";
		 
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Auto[4].Step:=20;
			END_IF			
		20:			
	   		Auto[4].Comment:="平台2物料压紧气缸下降";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF    DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Auto[4].Step:=50;
			END_IF

		50:
			Auto[4].Comment:="触发扫码";
			DB7050_DriveControl.CodeCtrl[2].Cmd.Execute:=TRUE;
			IF DB7050_DriveControl.CodeCtrl[2].Status.Result=DB7090_Other.StationData[5].ProductCode THEN
				Auto[4].Step:=90;
			ELSIF DB7050_DriveControl.PrintCtrl[1].Cmd.Disable THEN
				Auto[4].Step:=90;
			ELSIF AutoTimeDelay[4,1].Q THEN
				 ;//扫码失败报警
			END_IF
		
		90:
			Auto[4].Comment:="等待送螺钉到位";
			//IF DB7050_DriveControl.ScrewCtrl[2].Status.Done THEN
				Auto[4].Step:=100;
			//END_IF
		
		100 :
			Auto[4].Comment:=FC_LCONCAT( "X轴Y轴前往锁附位置",INT_TO_WSTRING(DB7050_DriveControl.ESDCtrl[2].Status.VolNum));
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X5].Cmd.AutoABS:=DB7050_DriveControl.ESDCtrl[2].Status.VolNum+1;
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y2].Cmd.AutoABS:=DB7050_DriveControl.ESDCtrl[2].Status.VolNum+1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X5].Status.InPoint[DB7050_DriveControl.ESDCtrl[2].Status.VolNum+1] 
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y2].Status.InPoint[DB7050_DriveControl.ESDCtrl[2].Status.VolNum+1] THEN
				Auto[4].Step:=110;
			END_IF
			
		110:
			Auto[4].Comment:="等待送螺钉到位";
			IF DB7050_DriveControl.ScrewCtrl[2].Status.Done THEN
				Auto[4].Step:=120;
			END_IF	
			
		120:
			Auto[4].Comment:=FC_LCONCAT( "Z轴前往锁附位置",INT_TO_WSTRING(DB7050_DriveControl.ESDCtrl[2].Status.VolNum));	
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z2].Cmd.AutoABS:=DB7050_DriveControl.ESDCtrl[2].Status.VolNum+1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z2].Status.InPoint[DB7050_DriveControl.ESDCtrl[2].Status.VolNum+1]  THEN
				Auto[4].Step:=130;
			END_IF
			
		130:			
	   		Auto[4].Comment:="电批2上下气缸下降";
		 
				Auto[4].Step:=140;
			 	
			
		140:			
	   		Auto[4].Comment:="锁螺丝";
			 
				Auto[4].Step:=150; 		
		 
			
		150:			
	   		Auto[4].Comment:="电批2上下气缸上升";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Auto[4].Step:=160;
			END_IF	
			
		160:			
	   		Auto[4].Comment:="Z1回原点";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z2].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z2].Status.InPoint[1]  THEN				
				Auto[4].Step:=170;
			END_IF
			
		170:			
	   		Auto[4].Comment:="判定是否锁附完成";
		    IF  DB7050_DriveControl.ESDCtrl[2].Status.VolNum> DB7050_DriveControl.ESDCtrl[2].Parm.GoalNum  THEN
				Auto[4].Step:=200;
			ELSE
				Auto[4].Step:=90;
			END_IF
			
		200:			
	   		Auto[4].Comment:="X4,Y1回原点";
		     			
				Auto[4].Step:=220;
 
			
		220:			
	   		Auto[4].Comment:="平台2物料压紧气缸上升";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Auto[4].Step:=230;
			END_IF
			
		230:			
	   		Auto[4].Comment:="定位X-Y气缸回";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome THEN
				Auto[4].Step:=240;
			END_IF
			
			
		240:			
	   		Auto[4].Comment:="判断产品OK/NG";
		 
			Auto[4].Step:=500;

		500:
			Auto[4].Comment:="运动到第一颗螺丝位置";
			 
				Auto[4].Step:=1000;
			 

		1000:
			Auto[4].Comment:="工程结束";
			Auto[4].Running:=FALSE;
			Auto[4].Step:=0;

		;
	ELSE
		;
	END_CASE
	;
END_IF
 

//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[4].StepBefor <> Auto[4].Step THEN
	JMP RunAgin;
END_IF





