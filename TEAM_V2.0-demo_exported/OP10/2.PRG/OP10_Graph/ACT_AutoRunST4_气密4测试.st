
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
IF NOT DB1000_Control.Mode.Status.HomeOK THEN
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
IF DB1000_Control.Mode.Status.AutoRunning AND DB1000_Control.Mode.Status.HomeOK AND Init[4].Complete AND NOT Auto[4].Running AND NOT Auto[4].Disable THEN
	IF (Start[4] AND NOT DB1000_Control.Mode.Status.StationMode) OR 
		(Auto[4].Start AND DB1000_Control.Mode.Status.StationMode) THEN
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
IF ((DB1000_Control.Mode.Status.AutoRunning AND DB1000_Control.Mode.Status.StepRunning) OR Auto[4].NoPausedRunning) AND NOT Auto[4].Disable THEN
	CASE Auto[4].Step OF
		5:
			Auto[4].Comment:="工程开始";
			 
			IF TRUE THEN
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


