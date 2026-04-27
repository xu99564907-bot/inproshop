
//延时时间
AutoTimeDelay[1,0](IN:=Auto[1].Step=5,PT:=T#500MS);
AutoTimeDelay[1,1](IN:=Auto[1].Step=200,PT:=T#500MS);
AutoTimeDelay[1,2](IN:=Auto[1].Step=220,PT:=T#0.5S);
AutoTimeDelay[1,3]();
AutoTimeDelay[1,4]();
AutoTimeDelay[1,5]();

//交互信号
Auto[1].InterFace_IN[0]:=FALSE;
Auto[1].InterFace_IN[1]:=FALSE;
Auto[1].InterFace_IN[2]:=FALSE;
Auto[1].InterFace_IN[3]:=FALSE;
Auto[1].InterFace_IN[4]:=FALSE;
Auto[1].InterFace_IN[5]:=FALSE;
Auto[1].InterFace_IN[6]:=FALSE;
Auto[1].InterFace_IN[7]:=FALSE;
Auto[1].InterFace_IN[8]:=FALSE;
Auto[1].InterFace_IN[9]:=FALSE;


//清除流程步
IF NOT DB8000_Control.Mode.Status.HomeOK THEN
	Auto[1].Step:=0;
	Auto[1].Running:=FALSE;
END_IF

//单元周期计时
IF Auto[1].Running AND CPU_Clock.Clock_100ms_R THEN
	Auto[1].CycleTime:=Auto[1].CycleTime+1;
END_IF

//工程启动条件
Start[1]:=TRUE;


//工程启动
IF DB8000_Control.Mode.Status.AutoRunning AND DB8000_Control.Mode.Status.HomeOK AND Init[1].Complete AND NOT Auto[1].Running AND NOT Auto[1].Disable  THEN
	IF (Start[1] AND NOT DB8000_Control.Mode.Status.StationMode) OR 
		(Auto[1].Start AND DB8000_Control.Mode.Status.StationMode) THEN
		Auto[1].Running:=TRUE;
		Auto[1].Start:=FALSE;
		Auto[1].Step:=5;
		Auto[1].CycleTime:=0;
		Auto[1].Comment:="工程启动";
	END_IF
END_IF

RunAgin: //再次执行Case条件命令，节省一个扫描周期
Auto[1].StepBefor := Auto[1].Step;

//流程不暂停条件
Auto[1].NoPausedRunning:= FALSE;

//工程运转中
IF ((DB8000_Control.Mode.Status.AutoRunning AND DB8000_Control.Mode.Status.StepRunning) OR Auto[1].NoPausedRunning) AND NOT Auto[1].Disable  THEN
	CASE Auto[1].Step OF
		5:
			Auto[1].Comment:="工程开始";
		 			
				IF DB8050_DriveControl.Sensor[Enum_OP80_Sensor.传感器1].Status._ON    THEN
					Auto[1].Step:=10;
				ELSIF NOT DB8050_DriveControl.Sensor[Enum_OP80_Sensor.传感器1].Status._ON THEN
					 ;//物料未检测到		
				 
				END_IF
			 
		10:
			Auto[1].Comment:="定位气缸伸出";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[1].Step:=20;
			END_IF
			
		20:
			Auto[1].Comment:="产品固定气缸旋转压紧";

			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=DB8090_Other.Cyl_B_Sport;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork  THEN
				Auto[1].Step:=30;
			END_IF	
			
		30:
			Auto[1].Comment:="产品封堵B上下气缸_上升";
			 
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=DB8090_Other.Cyl_B_Sport;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork  THEN
				Auto[1].Step:=35;
			END_IF		
			
		35:
			Auto[1].Comment:="驱动齿轮S1轴回原";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S1].Status.InPoint[0] THEN
				Auto[1].Step:=40;
			END_IF			
			
		40:
			Auto[1].Comment:="驱动齿轮气缸_伸出";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[1].Step:=50;
			END_IF	
			
		50:
			Auto[1].Comment:="驱动齿轮S1轴旋转";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S1].Cmd.Torque:=1;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S1].Status.InTorque[1] 
				AND DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S1].Status.ActPosition > 500 THEN
				Auto[1].Step:=60;
			END_IF

		60:
			Auto[1].Comment:="驱动齿轮Z1轴旋转到感应到物料";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.Z1].Cmd.VelocityControl:=1;
			IF DB8050_DriveControl.Sensor[Enum_OP80_Sensor.传感器1].Status._ON THEN
				Auto[1].Step:=70;
			ELSIF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.Z1].Status.ActPosition>DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.Z1].Parm._ABS[2].Position THEN
				Auto[1].Step:=100;
				DB8090_Other.StationData[7].NowStatus:=3;//寻螺杆超行程 
			END_IF

		70:
			Auto[1].Comment:="夹爪夹料";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[1].Step:=80;
			END_IF
			
		80:			
			Auto[1].Comment:="插管测试气缸上升";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[1].Step:=90;
			END_IF			
			
		90:
			Auto[1].Comment:="启动测试，等待测试开始";
			DB8050_DriveControl.AirLeakCtrl[1].Cmd.A_Start:=TRUE;
			IF DB8050_DriveControl.AirLeakCtrl[1].Status.ABusy AND NOT DB8050_DriveControl.AirLeakCtrl[1].Status.ADone THEN
				Auto[1].Step:=95;
			END_IF

		95:
			Auto[1].Comment:="等待测试完成";
			IF DB8050_DriveControl.AirLeakCtrl[1].Status.ADone THEN
				IF DB8050_DriveControl.AirLeakCtrl[1].Status.AResult.TestResult = 1 THEN
					DB8090_Other.StationData[7].NowStatus:=1;
				ELSE
					DB8090_Other.StationData[7].NowStatus:=3;
				END_IF
				 
				Auto[1].Step:=100;
			END_IF			

		100:
			Auto[1].Comment:="拔管解扣气缸上升";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InWork THEN
				Auto[1].Step:=110;
			END_IF
			
		110:			
			Auto[1].Comment:="插管测试气缸下降";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[1].Step:=120;
			END_IF	
			
		120:
			Auto[1].Comment:="拔管解扣气缸下降";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[1].Step:=130;
			END_IF	

		130:
			Auto[1].Comment:="夹爪夹料松开";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[1].Step:=140;
			END_IF			

		140:
			Auto[1].Comment:="Z1轴下降";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.Z1].Cmd.AutoABS:=1;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.Z1].Status.InPoint[1] THEN
				Auto[1].Step:=160;
			END_IF

		160:
			Auto[1].Comment:="驱动齿轮S1轴旋转打开";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S1].Cmd.Torque:=2;
			IF DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S1].Status.InTorque[2]
				AND DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S1].Status.ActPosition < 100 THEN
				Auto[1].Step:=180;
			END_IF
			
		180:
			Auto[1].Comment:="产品封堵B上下气缸_下降"; 
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome  THEN
				Auto[1].Step:=200;
			END_IF	
			
		200:
			Auto[1].Comment:="延时";
			IF AutoTimeDelay[1,1].Q THEN
				Auto[1].Step:=220;
			END_IF
			
		220:
			Auto[1].Comment:="延时";
			DB8050_DriveControl.AxisCtrl[Enum_OP80_Axis.S1].Cmd.Torque:=1;			
			IF AutoTimeDelay[1,2].Q THEN
				Auto[1].Step:=230;
			END_IF

		230:
			Auto[1].Comment:="驱动齿轮气缸_缩回";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[1].Step:=300;
			END_IF

		300:
			Auto[1].Comment:="产品固定气缸旋转松开";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE; 
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome  THEN
				Auto[1].Step:=400;
			END_IF

		400:
			Auto[1].Comment:="定位气缸松开";
			DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB8050_DriveControl.CylCtrl[Enum_OP80_Cyl.气缸1].Status.InHome THEN
				Auto[1].Step:=1000;
			END_IF

		1000:
			Auto[1].Comment:="工程结束";
			Auto[1].Running:=FALSE;
			Auto[1].Step:=0;
	ELSE
		;
	END_CASE

END_IF

//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[1].StepBefor <> Auto[1].Step THEN
	JMP RunAgin;
END_IF


