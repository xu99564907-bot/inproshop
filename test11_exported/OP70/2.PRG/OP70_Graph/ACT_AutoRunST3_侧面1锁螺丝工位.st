
//延时时间
AutoTimeDelay[3,0](IN:=Auto[3].Step=5,PT:=T#500MS);
AutoTimeDelay[3,1](IN:=Auto[3].Step=50,PT:=T#2S);
AutoTimeDelay[3,2]();
AutoTimeDelay[3,3]();
AutoTimeDelay[3,4]();
AutoTimeDelay[3,5]();
//清除流程步
IF NOT DB7000_Control.Mode.Status.HomeOK THEN
	Auto[3].Step:=0;
	Auto[3].Running:=FALSE;
END_IF

//单元周期计时
IF Auto[3].Running AND CPU_Clock.Clock_100ms_R THEN
	Auto[3].CycleTime:=Auto[3].CycleTime+1;
END_IF

//工程启动条件
Start[3]:=TRUE;//有产品未完成


//工程启动
IF DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.HomeOK AND Init[3].Complete AND NOT Auto[3].Running THEN
	IF (Start[3] AND NOT DB7000_Control.Mode.Status.StationMode) OR 
		(Auto[3].Start AND DB7000_Control.Mode.Status.StationMode) THEN
		Auto[3].Running:=TRUE;
		Auto[3].Step:=5;
		Auto[3].CycleTime:=0;
		Auto[3].Comment:="工程启动";
		 
		 
		Auto[3].Start:=FALSE;
	END_IF
END_IF

RunAgin: //再次执行Case条件命令，节省一个扫描周期
Auto[3].StepBefor := Auto[3].Step;

//流程不暂停条件
Auto[3].NoPausedRunning:=FALSE;


//工程运转中
IF (DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.StepRunning) OR Auto[3].NoPausedRunning THEN
	CASE Auto[3].Step OF
		5 :
			Auto[3].Comment:="工程启动";
			IF DB7050_DriveControl.Sensor[Enum_OP70_Sensor.传感器1].Status._ON  THEN
				Auto[3].Step:=10;
			ELSE
				 ;//物料未检测到异常
			END_IF
			
		10:			
	   		Auto[3].Comment:="定位X-Y气缸动作";
			 
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork   THEN
				Auto[3].Step:=20;
			END_IF
			
		20:			
	   		Auto[3].Comment:="平台1物料压紧气缸下降";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF    DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Auto[3].Step:=50;
			END_IF

		50:
			Auto[3].Comment:="触发扫码";
			DB7050_DriveControl.CodeCtrl[1].Cmd.Execute:=TRUE;
			IF DB7050_DriveControl.CodeCtrl[1].Status.Result=DB7090_Other.StationData[3].ProductCode THEN
				Auto[3].Step:=90;
			ELSIF DB7050_DriveControl.PrintCtrl[1].Cmd.Disable THEN
				Auto[3].Step:=90;
			ELSIF AutoTimeDelay[3,1].Q THEN
				 ;//扫码失败报警
			END_IF

		90:
			Auto[3].Comment:="等待送螺钉到位";
			//IF DB7050_DriveControl.ScrewCtrl[1].Status.Done THEN
				Auto[3].Step:=100;
			//END_IF
		
		100 :
			Auto[3].Comment:=FC_LCONCAT( "X轴Y轴前往锁附位置",INT_TO_WSTRING(DB7050_DriveControl.ESDCtrl[1].Status.VolNum));
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X4].Cmd.AutoABS:=DB7050_DriveControl.ESDCtrl[1].Status.VolNum+1;
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y1].Cmd.AutoABS:=DB7050_DriveControl.ESDCtrl[1].Status.VolNum+1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X4].Status.InPoint[DB7050_DriveControl.ESDCtrl[1].Status.VolNum+1] 
				AND DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Y1].Status.InPoint[DB7050_DriveControl.ESDCtrl[1].Status.VolNum+1] THEN
				Auto[3].Step:=110;
			END_IF
			
		110:
			Auto[3].Comment:="等待送螺钉到位";
			IF DB7050_DriveControl.ScrewCtrl[1].Status.Done THEN
				Auto[3].Step:=120;
			END_IF	
			
		120 :
			Auto[3].Comment:=FC_LCONCAT( "Z轴前往锁附位置",INT_TO_WSTRING(DB7050_DriveControl.ESDCtrl[1].Status.VolNum));	
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z1].Cmd.AutoABS:=DB7050_DriveControl.ESDCtrl[1].Status.VolNum+1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z1].Status.InPoint[DB7050_DriveControl.ESDCtrl[1].Status.VolNum+1]  THEN
				Auto[3].Step:=130;
			END_IF
			
		130:			
	   		Auto[3].Comment:="电批1上下气缸下降";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Auto[3].Step:=140;
			END_IF	
			
		140:			
	   		Auto[3].Comment:="锁螺丝";
			 
				 	
				Auto[3].Step:=150; 		
		 
		150:			
	   		Auto[3].Comment:="电批1上下气缸上升";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Auto[3].Step:=160;
			END_IF	
			
		160:			
	   		Auto[3].Comment:="Z1回原点";
		    DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z1].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z1].Status.InPoint[1]  THEN				
				Auto[3].Step:=170;
			END_IF
			
		170:			
	   		Auto[3].Comment:="判定是否锁附完成";
		    IF  DB7050_DriveControl.ESDCtrl[1].Status.VolNum> DB7050_DriveControl.ESDCtrl[1].Parm.GoalNum  THEN
				Auto[3].Step:=200;
			ELSE
				Auto[3].Step:=90;
			END_IF
			
		200:			
	   		Auto[3].Comment:="X4,Y1回原点";
		     			
				Auto[3].Step:=220;
			 
			
		220:			
	   		Auto[3].Comment:="平台1物料压紧气缸上升";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Auto[3].Step:=230;
			END_IF
			
		230:			
	   		Auto[3].Comment:="定位X-Y气缸回";
		 
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome   THEN
				Auto[3].Step:=240;
			END_IF
			
			
		240:			
	   		Auto[3].Comment:="判断产品OK/NG";
			 
			Auto[3].Step:=500;
			
		500:
			Auto[3].Comment:="运动到第一颗螺丝位置";
			 
				Auto[3].Step:=1000;
			 	
			
			
		1000:
			Auto[3].Comment:="工程结束";
			Auto[3].Running:=FALSE;
			Auto[3].Step:=0;

		;
	ELSE
		;
	END_CASE
	;
END_IF

 

//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[3].StepBefor <> Auto[3].Step THEN
	JMP RunAgin;
END_IF





