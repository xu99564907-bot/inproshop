
//延时时间
AutoTimeDelay[2,0](IN:=Auto[2].Step=5,PT:=T#500MS);
AutoTimeDelay[2,1]();
AutoTimeDelay[2,2]();
AutoTimeDelay[2,3]();
AutoTimeDelay[2,4]();
AutoTimeDelay[2,5]();
//清除流程步
IF NOT DB7000_Control.Mode.Status.HomeOK THEN
	Auto[2].Step:=0;
	Auto[2].Running:=FALSE;
END_IF

//单元周期计时
IF Auto[2].Running AND CPU_Clock.Clock_100ms_R THEN
	Auto[2].CycleTime:=Auto[2].CycleTime+1;
END_IF

IF DB7090_Other.StationData[1].Num=0
	AND DB7090_Other.StationData[2].Num=0
	AND DB7090_Other.StationData[3].Num=0 
	AND DB7090_Other.StationData[4].Num=0 
	AND DB7090_Other.StationData[5].Num=0 
	AND DB7090_Other.StationData[6].Num=0 
	AND DB7090_Other.StationData[7].Num=0 
	AND DB7090_Other.StationData[8].Num=0  THEN
	DB7000_Control.Mode.Status.ClearMode:=FALSE;
END_IF


//工程启动条件
Start[2]:=TRUE;//


//工程启动
IF DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.HomeOK AND Init[2].Complete AND NOT Auto[2].Running THEN
	IF (Start[2] AND NOT DB7000_Control.Mode.Status.StationMode) OR 
		(Auto[2].Start AND DB7000_Control.Mode.Status.StationMode) THEN
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
Auto[2].NoPausedRunning:=Auto[2].Step=5;

//工程运转中
IF (DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.StepRunning) OR Auto[2].NoPausedRunning THEN
	CASE Auto[2].Step OF
		5 :
			Auto[2].Comment:="工程启动";
			Auto[2].Step:=10;

		10:
			Auto[2].Comment:="判断各工位是否完成";
			 
				Auto[2].Step:=20;
			 
			
		20:
	   		Auto[2].Comment:="升降气缸上升位";
			 
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=DB7090_Other.StationData[8].Num = 1;
			IF (DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork OR DB7090_Other.StationData[2].Num <> 1)	 
				AND (DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork OR DB7090_Other.StationData[4].Num <> 1)	 
				AND (DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork OR DB7090_Other.StationData[6].Num <> 1)	 
				AND (DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork OR DB7090_Other.StationData[8].Num <> 1) THEN
				Auto[2].Step:=30;
			END_IF
			
		30:			
	   		Auto[2].Comment:="搬运避让气缸伸出";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE; 
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork   THEN
				Auto[2].Step:=40;
			END_IF	
			
		40:			
	   		Auto[2].Comment:="夹爪气缸夹紧位";
			 
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=DB7090_Other.StationData[7].Num = 1;
			IF  (DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  OR DB7090_Other.StationData[1].Num <> 1)  THEN
				Auto[2].Step:=50;
				
			END_IF	
			
		50:
			Auto[2].Comment:="数据传递";
			DB7090_Other.StationData[2]:=DB7090_Other.StationData[1];
			DB7090_Other.StationData[4]:=DB7090_Other.StationData[3];
			DB7090_Other.StationData[6]:=DB7090_Other.StationData[5];
			DB7090_Other.StationData[8]:=DB7090_Other.StationData[7];
			DB7090_Other.StationData[1]:=DB7090_Other.StationData[0];
			DB7090_Other.StationData[3]:=DB7090_Other.StationData[0];
			DB7090_Other.StationData[5]:=DB7090_Other.StationData[0];
			DB7090_Other.StationData[7]:=DB7090_Other.StationData[0];
			Auto[2].Step:=60;
			
		60:			
	   		Auto[2].Comment:="升降气缸下降位";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			 
			IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome   THEN
				Auto[2].Step:=90;
			END_IF
			

       90:			
	   		Auto[2].Comment:="旋转气缸放料位";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE; 
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				Auto[2].Step:=100;
			END_IF

		100:
			Auto[2].Comment:="等待下料位置空,在接料位置";
			IF DB7090_Other.StationData[9].Num = 0  THEN
				Auto[2].Step:=1000;
			END_IF
			
	 
		 
			
		1000:
			Auto[2].Comment:="工程结束";
			Auto[2].Running:=FALSE;
			Auto[2].Step:=0;

		;
	ELSE
		;
	END_CASE

	;
END_IF

//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[1].StepBefor <> Auto[1].Step THEN
	JMP RunAgin;
END_IF
















