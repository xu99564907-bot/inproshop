
//延时时间
AutoTimeDelay[4,0](IN:=Auto[4].Step=5,PT:=T#500MS);
AutoTimeDelay[4,1](IN:=Auto[4].Step=200,PT:=T#500MS);
AutoTimeDelay[4,2](IN:=Auto[4].Step=220,PT:=T#0.0S);
AutoTimeDelay[4,3]();
AutoTimeDelay[4,4]();
AutoTimeDelay[4,5]();

//交互信号
Auto[4].InterFace_IN[0]:=FALSE;
Auto[4].InterFace_IN[1]:=FALSE;
Auto[4].InterFace_IN[2]:=FALSE;
Auto[4].InterFace_IN[3]:=FALSE;
Auto[4].InterFace_IN[4]:=FALSE;
Auto[4].InterFace_IN[5]:=FALSE;
Auto[4].InterFace_IN[6]:=FALSE;
Auto[4].InterFace_IN[7]:=FALSE;
Auto[4].InterFace_IN[8]:=FALSE;
Auto[4].InterFace_IN[9]:=FALSE;


//清除流程步
IF NOT DB8000_Control.Mode.Status.HomeOK THEN
	Auto[4].Step:=0;
	Auto[4].Running:=FALSE;
END_IF

//单元周期计时
IF Auto[4].Running AND CPU_Clock.Clock_100ms_R THEN
	Auto[4].CycleTime:=Auto[4].CycleTime+1;
END_IF

//工程启动条件
Start[4]:=TRUE;


//工程启动
IF DB8000_Control.Mode.Status.AutoRunning AND DB8000_Control.Mode.Status.HomeOK AND Init[4].Complete AND NOT Auto[4].Running AND NOT Auto[4].Disable THEN
	IF (Start[4] AND NOT DB8000_Control.Mode.Status.StationMode) OR 
		(Auto[4].Start AND DB8000_Control.Mode.Status.StationMode) THEN
		Auto[4].Running:=TRUE;
		Auto[4].Start:=FALSE;
		Auto[4].Step:=5;
		Auto[4].CycleTime:=0;
		Auto[4].Comment:="工程启动";
	END_IF
END_IF

RunAgin: //再次执行Case条件命令，节省一个扫描周期
Auto[4].StepBefor := Auto[4].Step;

//流程不暂停条件
Auto[4].NoPausedRunning:=Auto[4].Step=50 OR Auto[4].Step=60 OR Auto[4].Step=90 OR Auto[4].Step=160;

//工程运转中
IF ((DB8000_Control.Mode.Status.AutoRunning AND DB8000_Control.Mode.Status.StepRunning) OR Auto[4].NoPausedRunning) AND NOT Auto[4].Disable THEN
	CASE Auto[4].Step OF
		5:
			Auto[4].Comment:="工程开始";
		 
					Auto[4].Step:=10;
				 
		10:
			Auto[4].Comment:="定位气缸伸出";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE; 
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork  THEN
				Auto[4].Step:=20;
			END_IF
			
		20:
			Auto[4].Comment:="产品固定气缸旋转压紧";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE; 
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork   THEN
				Auto[4].Step:=30;
			END_IF	
			
		30:
			Auto[4].Comment:="产品封堵B上下气缸_上升";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[4].Step:=35;
			END_IF
			
		35:
			Auto[4].Comment:="驱动齿轮S4轴回原";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S4].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S4].Status.InPoint[0] THEN
				Auto[4].Step:=40;
			END_IF			
			
		40:
			Auto[4].Comment:="驱动齿轮气缸_伸出";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[4].Step:=50;
			END_IF	
			
		50:
			Auto[4].Comment:="驱动齿轮S4轴旋转";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S4].Cmd.Torque:=1;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S4].Status.InTorque[1] 
				AND DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S4].Status.ActPosition > 500 THEN
				Auto[4].Step:=60;
			END_IF

		60:
			Auto[4].Comment:="驱动齿轮Z4轴旋转到感应到物料";
			 
				Auto[4].Step:=100;
				 

	 

	 

		100:
			Auto[4].Comment:="拔管解扣气缸上升";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[4].Step:=110;
			END_IF
			
		110:			
			Auto[4].Comment:="插管测试气缸下降";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[4].Step:=120;
			END_IF	
			
		120:
			Auto[4].Comment:="拔管解扣气缸下降";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[4].Step:=130;
			END_IF	

		130:
			Auto[4].Comment:="夹爪夹料松开";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[4].Step:=140;
			END_IF			

		140:
			Auto[4].Comment:="Z4轴下降";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.Z4].Cmd.AutoABS:=1;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.Z4].Status.InPoint[1] THEN
				Auto[4].Step:=160;
			END_IF

		160:
			Auto[4].Comment:="驱动齿轮S4轴旋转打开";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S4].Cmd.Torque:=2;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S4].Status.InTorque[2]
				AND DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S4].Status.ActPosition < 100 THEN
				Auto[4].Step:=180;
			END_IF
			
		180:
			Auto[4].Comment:="产品封堵B上下气缸_下降";
			 
				Auto[4].Step:=200;
		 
		200:
			Auto[4].Comment:="延时";
			IF AutoTimeDelay[4,1].Q THEN
				Auto[4].Step:=220;
			END_IF
			
		220:
			Auto[4].Comment:="延时";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S4].Cmd.Torque:=1;			
			IF AutoTimeDelay[4,2].Q THEN
				Auto[4].Step:=230;
			END_IF			

		230:
			Auto[4].Comment:="驱动齿轮气缸_缩回";
		 
				Auto[4].Step:=300;
		 
			
		300:
			Auto[4].Comment:="产品固定气缸旋转松开";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[4].Step:=400;
			END_IF

		400:
			Auto[4].Comment:="定位气缸松开";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[4].Step:=1000;
			END_IF

		1000:
			Auto[4].Comment:="工程结束";
			Auto[4].Running:=FALSE;
			Auto[4].Step:=0;
	ELSE
		;
	END_CASE

END_IF

//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[4].StepBefor <> Auto[4].Step THEN
	JMP RunAgin;
END_IF


