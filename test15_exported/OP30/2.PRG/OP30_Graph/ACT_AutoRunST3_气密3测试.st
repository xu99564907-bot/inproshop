
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
IF NOT DB3000_Control.Mode.Status.HomeOK THEN
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
IF DB3000_Control.Mode.Status.AutoRunning AND DB3000_Control.Mode.Status.HomeOK AND Init[3].Complete AND NOT Auto[3].Running AND NOT Auto[3].Disable THEN
	IF (Start[3] AND NOT DB3000_Control.Mode.Status.StationMode) OR 
		(Auto[3].Start AND DB3000_Control.Mode.Status.StationMode) THEN
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
IF ((DB3000_Control.Mode.Status.AutoRunning AND DB3000_Control.Mode.Status.StepRunning) OR Auto[3].NoPausedRunning) AND NOT Auto[3].Disable THEN
	CASE Auto[3].Step OF
		5:
			Auto[3].Comment:="工程开始";
			DB3050_DriveControl.CylCtrl[Enum_OP30_Cyl.气缸1].Cmd.AutoToHome:=TRUE;
			IF DB3050_DriveControl.CylCtrl[Enum_OP30_Cyl.气缸1].Status.InHome THEN
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


