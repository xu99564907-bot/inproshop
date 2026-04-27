
//延时时间
AutoTimeDelay[2,0](IN:=Auto[2].Step=5,PT:=T#500MS);
AutoTimeDelay[2,1](IN:=Auto[2].Step=200,PT:=T#500MS);
AutoTimeDelay[2,2](IN:=Auto[2].Step=220,PT:=T#0.5S);
AutoTimeDelay[2,3]();
AutoTimeDelay[2,4]();
AutoTimeDelay[2,5]();

//交互信号
Auto[2].InterFace_IN[0]:=FALSE;
Auto[2].InterFace_IN[1]:=FALSE;
Auto[2].InterFace_IN[2]:=FALSE;
Auto[2].InterFace_IN[3]:=FALSE;
Auto[2].InterFace_IN[4]:=FALSE;
Auto[2].InterFace_IN[5]:=FALSE;
Auto[2].InterFace_IN[6]:=FALSE;
Auto[2].InterFace_IN[7]:=FALSE;
Auto[2].InterFace_IN[8]:=FALSE;
Auto[2].InterFace_IN[9]:=FALSE;


//清除流程步
IF NOT DB8000_Control.Mode.Status.HomeOK THEN
	Auto[2].Step:=0;
	Auto[2].Running:=FALSE;
END_IF

//单元周期计时
IF Auto[2].Running AND CPU_Clock.Clock_100ms_R THEN
	Auto[2].CycleTime:=Auto[2].CycleTime+1;
END_IF

//工程启动条件
Start[2]:=TRUE;


//工程启动
IF DB8000_Control.Mode.Status.AutoRunning AND DB8000_Control.Mode.Status.HomeOK AND Init[2].Complete AND NOT Auto[2].Running AND NOT Auto[2].Disable  THEN
	IF (Start[2] AND NOT DB8000_Control.Mode.Status.StationMode) OR 
		(Auto[2].Start AND DB8000_Control.Mode.Status.StationMode) THEN
		Auto[2].Running:=TRUE;
		Auto[2].Start:=FALSE;
		Auto[2].Step:=5;
		Auto[2].CycleTime:=0;
		Auto[2].Comment:="工程启动";
	END_IF
END_IF

RunAgin: //再次执行Case条件命令，节省一个扫描周期
Auto[2].StepBefor := Auto[2].Step;

//流程不暂停条件
Auto[2].NoPausedRunning:=Auto[2].Step=50 OR Auto[2].Step=60 OR Auto[2].Step=90 OR Auto[2].Step=160;

//工程运转中
IF ((DB8000_Control.Mode.Status.AutoRunning AND DB8000_Control.Mode.Status.StepRunning) OR Auto[2].NoPausedRunning) AND NOT Auto[2].Disable   THEN
	CASE Auto[2].Step OF
		5:
			Auto[2].Comment:="工程开始";
		 
				IF DB8050_DriveControl.Sensor[Enum_OP80_Sensor.传感器1].Status._ON   THEN
					Auto[2].Step:=10;
				ELSIF NOT DB8050_DriveControl.Sensor[Enum_OP80_Sensor.传感器1].Status._ON THEN
					;//物料未检测到		
				
				END_IF		
		 
		
		10:
			Auto[2].Comment:="定位气缸伸出";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[2].Step:=20;
			END_IF
			
		20:
			Auto[2].Comment:="产品固定气缸旋转压紧"; 
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=DB8090_Other.Cyl_B_Sport;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[2].Step:=30;
			END_IF	
			
		30:
			Auto[2].Comment:="产品封堵B上下气缸_上升";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE; 
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork  THEN
				Auto[2].Step:=35;
			END_IF			
			
		35:
			Auto[2].Comment:="驱动齿轮S2轴回原";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S2].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S2].Status.InPoint[0] THEN
				Auto[2].Step:=40;
			END_IF			
			
		40:
			Auto[2].Comment:="驱动齿轮气缸_伸出";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[2].Step:=50;
			END_IF	
			
		50:
			Auto[2].Comment:="驱动齿轮S2轴旋转";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S2].Cmd.Torque:=1;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S2].Status.InTorque[1] 
				AND DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S2].Status.ActPosition > 500 THEN
				Auto[2].Step:=1000;
			END_IF

	 

		1000:
			Auto[2].Comment:="工程结束";
			Auto[2].Running:=FALSE;
			Auto[2].Step:=0;
	ELSE
		;
	END_CASE

END_IF

//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[2].StepBefor <> Auto[2].Step THEN
	JMP RunAgin;
END_IF


