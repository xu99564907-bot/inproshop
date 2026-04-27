
//延时时间
AutoTimeDelay[6,0](IN:=Auto[6].Step=5,PT:=T#100MS);
AutoTimeDelay[6,1](IN:=Auto[6].Step=50,PT:=T#2S);
AutoTimeDelay[6,2]();
AutoTimeDelay[6,3]();
AutoTimeDelay[6,4]();
AutoTimeDelay[6,5]();
AutoTimeDelay[6,6]();



//交互信号
//Auto[6].InterFace_IN[0]:=FALSE;//人工下料按钮
Auto[6].InterFace_IN[1]:=FALSE;//
Auto[6].InterFace_IN[2]:=Auto[7].InterFace_OUT[3];//包装搬运机构放料到位
Auto[6].InterFace_IN[3]:=FALSE;
Auto[6].InterFace_IN[4]:=FALSE;
Auto[6].InterFace_IN[5]:=FALSE;
Auto[6].InterFace_IN[6]:=FALSE;
Auto[6].InterFace_IN[7]:=FALSE;
Auto[6].InterFace_IN[8]:=FALSE;
Auto[6].InterFace_IN[9]:=FALSE;


//清除流程步
IF NOT DB7000_Control.Mode.Status.HomeOK THEN
	Auto[6].Step:=0;
	Auto[6].Running:=FALSE;
	FOR i:=0 TO 9 BY 1 DO
		Auto[6].InterFace_OUT[i]:=FALSE;
	END_FOR
END_IF

//单元周期计时
IF Auto[6].Running AND CPU_Clock.Clock_100ms_R THEN
	Auto[6].CycleTime:=Auto[6].CycleTime+1;
END_IF

//工程启动条件
Start[6]:=TRUE;


//工程启动
IF DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.HomeOK AND NOT Auto[6].Running THEN
	IF (Start[6] AND NOT DB7000_Control.Mode.Status.StationMode) OR 
		(Auto[6].Start AND DB7000_Control.Mode.Status.StationMode) THEN
		Auto[6].Running:=TRUE;
		Auto[6].Start:=FALSE;
		Auto[6].Step:=5;
		Auto[6].CycleTime:=0;
		Auto[6].Comment:="工程启动";
	END_IF
END_IF

//RunAgin: //再次执行Case条件命令，节省一个扫描周期
Auto[6].StepBefor := Auto[6].Step;

//流程不暂停条件
Auto[6].NoPausedRunning:=FALSE ;


//工程运转中
IF (DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.StepRunning) OR Auto[6].NoPausedRunning THEN
	CASE Auto[6].Step OF
		5 :
			Auto[6].Comment:="工程开始";
			IF DB7050_DriveControl.Sensor[Enum_OP70_Sensor.传感器1].Status._ON  THEN
				Auto[6].Step:=10;
			ELSE
				 ;//物料未检测到异常
			END_IF	

		10:
			Auto[6].Comment:="定位XY伸出";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome   THEN
				Auto[6].Step:=20;
			END_IF

		20:
			Auto[6].Comment:="避位气缸下降";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome THEN
				Auto[6].Step:=30;
			END_IF
			
		30:
			Init[6].Comment:="旋转气缸取料位置";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Auto[6].Step:=50;
			END_IF	

		50:
			Auto[6].Comment:="触发扫码";
			DB7050_DriveControl.CodeCtrl[4].Cmd.Execute:=TRUE;
			IF DB7050_DriveControl.CodeCtrl[4].Status.Result=DB7090_Other.StationData[7].ProductCode THEN
				Auto[6].Step:=100;
			ELSIF DB7050_DriveControl.PrintCtrl[1].Cmd.Disable THEN
				Auto[6].Step:=100;
			ELSIF AutoTimeDelay[6,1].Q THEN
				 ;//扫码失败报警
			END_IF
			
		100:			
			Auto[6].Comment:="定位X缩回";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork THEN
				IF DB7000_Control.Mode.Status.OfflineMode THEN
					Auto[6].Step:=105;
				ELSE
					Auto[6].Step:=110;
				END_IF
				
			END_IF			

		105:
			Auto[6].Comment:="离线模式，等人工取走后点击触摸屏取料按钮";
			IF Auto[6].InterFace_IN[0] THEN
				Auto[6].Step:=150;
			END_IF
			

		110:
			Auto[6].Comment:="发出取料许可,等待取料完成";
			 
				Auto[6].Step:=150;
			 
			
		150:
			Auto[6].Comment:="等待取料完成OFF";
			IF NOT Auto[6].InterFace_IN[1] AND NOT NOT Auto[6].InterFace_IN[0] THEN
				Auto[6].Step:=200;				
			END_IF;

		200:
			Auto[6].Comment:="定位XY伸出";
			 
				Auto[6].Step:=220;
		 
			
		220:
			Auto[6].Comment:="旋转气缸取料位置";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				Auto[6].Step:=230;
			END_IF				
			
		230:			
			Auto[6].Comment:="定位Y缩回";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork:=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork THEN
				Auto[6].Step:=240;
			END_IF			
			
		240:
			Auto[6].Comment:="判定是否有物料残留";
			IF DB7050_DriveControl.Sensor[Enum_OP70_Sensor.传感器1].Status._OFF  THEN
				Auto[6].Step:=1000;
			ELSE
				 ;//物料未检测到异常
			END_IF	


		1000:
			Auto[6].Comment:="工程结束";
			DB7090_Other.StationData[9].Num := 0;
			Auto[6].Running:=FALSE;
			Auto[6].Step:=0;
		;
	ELSE
		;
	END_CASE

	;
END_IF

//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[6].StepBefor <> Auto[6].Step THEN
	;//JMP RunAgin;
END_IF

 
