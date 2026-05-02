
//延时时间
AutoTimeDelay[3,0](IN:=Auto[3].Step=5,PT:=T#500MS);
AutoTimeDelay[3,1](IN:=Auto[3].Step=200,PT:=T#500MS);
AutoTimeDelay[3,2](IN:=Auto[3].Step=220,PT:=T#0.5S);
AutoTimeDelay[3,3]();
AutoTimeDelay[3,4]();
AutoTimeDelay[3,5]();

//交互信号
Auto[3].InterFace_IN[0]:=FALSE;
Auto[3].InterFace_IN[1]:=FALSE;
Auto[3].InterFace_IN[2]:=FALSE;
Auto[3].InterFace_IN[3]:=FALSE;
Auto[3].InterFace_IN[4]:=FALSE;
Auto[3].InterFace_IN[5]:=FALSE;
Auto[3].InterFace_IN[6]:=FALSE;
Auto[3].InterFace_IN[7]:=FALSE;
Auto[3].InterFace_IN[8]:=FALSE;
Auto[3].InterFace_IN[9]:=FALSE;


//清除流程步
IF NOT DB8000_Control.Mode.Status.HomeOK THEN
	Auto[3].Step:=0;
	Auto[3].Running:=FALSE;
END_IF

//单元周期计时
IF Auto[3].Running AND CPU_Clock.Clock_100ms_R THEN
	Auto[3].CycleTime:=Auto[3].CycleTime+1;
END_IF

//工程启动条件
Start[3]:=TRUE;


//工程启动
IF DB8000_Control.Mode.Status.AutoRunning AND DB8000_Control.Mode.Status.HomeOK AND Init[3].Complete AND NOT Auto[3].Running AND NOT Auto[3].Disable THEN
	IF (Start[3] AND NOT DB8000_Control.Mode.Status.StationMode) OR 
		(Auto[3].Start AND DB8000_Control.Mode.Status.StationMode) THEN
		Auto[3].Running:=TRUE;
		Auto[3].Start:=FALSE;
		Auto[3].Step:=5;
		Auto[3].CycleTime:=0;
		Auto[3].Comment:="工程启动";
	END_IF
END_IF

RunAgin: //再次执行Case条件命令，节省一个扫描周期
Auto[3].StepBefor := Auto[3].Step;

//流程不暂停条件
Auto[3].NoPausedRunning:=FALSE;

//工程运转中
IF ((DB8000_Control.Mode.Status.AutoRunning AND DB8000_Control.Mode.Status.StepRunning) OR Auto[3].NoPausedRunning) AND NOT Auto[3].Disable THEN
	CASE Auto[3].Step OF
		5:
			Auto[3].Comment:="工程开始";
		 
				 
					Auto[3].Step:=10;
				 		
		 
			
		10:
			Auto[3].Comment:="定位气缸伸出";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[3].Step:=20;
			END_IF
			
		20:
			Auto[3].Comment:="产品固定气缸旋转压紧";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE; 
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork  THEN
				Auto[3].Step:=30;
			END_IF	
			
		30:
			Auto[3].Comment:="产品封堵B上下气缸_上升";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			 
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork  THEN
				Auto[3].Step:=35;
			END_IF		
		35:
			Auto[3].Comment:="驱动齿轮S3轴回原";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S3].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S3].Status.InPoint[0] THEN
				Auto[3].Step:=40;
			END_IF			
			
		40:
			Auto[3].Comment:="驱动齿轮气缸_伸出";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[3].Step:=50;
			END_IF	
			
		50:
			Auto[3].Comment:="驱动齿轮S3轴旋转";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S3].Cmd.Torque:=1;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S3].Status.InTorque[1] 
				AND DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S3].Status.ActPosition > 500 THEN
				Auto[3].Step:=60;
			END_IF

		60:
			Auto[3].Comment:="驱动齿轮Z3轴旋转到感应到物料";
			 
			 
				Auto[3].Step:=100;
		 

		70:
			Auto[3].Comment:="夹爪夹料";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[3].Step:=80;
			END_IF
			
		80:			
			Auto[3].Comment:="插管测试气缸上升";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[3].Step:=90;
			END_IF			
			
		90:
			Auto[3].Comment:="启动测试，等待测试开始";
			DB8050_DriveControl.AirLeakCtrl[2].Cmd.A_Start:=TRUE;
			IF DB8050_DriveControl.AirLeakCtrl[2].Status.ABusy AND NOT DB8050_DriveControl.AirLeakCtrl[2].Status.ADone THEN
				Auto[3].Step:=95;
			END_IF

		95:
			Auto[3].Comment:="等待测试完成";
		 
			 
				Auto[3].Step:=100;
		 		

		100:
			Auto[3].Comment:="拔管解扣气缸上升";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[3].Step:=110;
			END_IF
			
		110:			
			Auto[3].Comment:="插管测试气缸下降";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[3].Step:=120;
			END_IF	
			
		120:
			Auto[3].Comment:="拔管解扣气缸下降";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[3].Step:=130;
			END_IF	

		130:
			Auto[3].Comment:="夹爪夹料松开";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[3].Step:=140;
			END_IF			

		140:
			Auto[3].Comment:="Z3轴下降";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.Z3].Cmd.AutoABS:=1;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.Z3].Status.InPoint[1] THEN
				Auto[3].Step:=160;
			END_IF

		160:
			Auto[3].Comment:="驱动齿轮S3轴旋转打开";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S3].Cmd.Torque:=2;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S3].Status.InTorque[2]
				AND DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S3].Status.ActPosition < 100 THEN
				Auto[3].Step:=180;
			END_IF
			
		180:
			Auto[3].Comment:="产品封堵B上下气缸_下降";
			 
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome  THEN
				Auto[3].Step:=200;
			END_IF				
			
		200:
			Auto[3].Comment:="延时";
			IF AutoTimeDelay[3,1].Q THEN
				Auto[3].Step:=220;
			END_IF
			
		220:
			Auto[3].Comment:="延时";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S3].Cmd.Torque:=1;			
			IF AutoTimeDelay[3,2].Q THEN
				Auto[3].Step:=230;
			END_IF	
			
		230:
			Auto[3].Comment:="驱动齿轮气缸_缩回";
 
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[3].Step:=300;
			END_IF

			
		300:
			Auto[3].Comment:="产品固定气缸旋转松开";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[3].Step:=400;
			END_IF

		400:
			Auto[3].Comment:="定位气缸松开";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[3].Step:=1000;
			END_IF

		1000:
			Auto[3].Comment:="工程结束";
			Auto[3].Running:=FALSE;
			Auto[3].Step:=0;
	ELSE
		;
	END_CASE

END_IF

//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[3].StepBefor <> Auto[3].Step THEN
	JMP RunAgin;
END_IF


