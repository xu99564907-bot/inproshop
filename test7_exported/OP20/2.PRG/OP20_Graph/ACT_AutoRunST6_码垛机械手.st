
//延时时间
AutoTimeDelay[6,0](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[6,1](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[6,2](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[6,3](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[6,4](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[6,5](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[6,6](IN:=FALSE,PT:=T#100MS);


//交互信号
Auto[6].InterFace_IN[0]:=FALSE;
Auto[6].InterFace_IN[1]:=FALSE;
Auto[6].InterFace_IN[2]:=FALSE;
Auto[6].InterFace_IN[3]:=FALSE;
Auto[6].InterFace_IN[4]:=FALSE;
Auto[6].InterFace_IN[5]:=FALSE;
Auto[6].InterFace_IN[6]:=FALSE;
Auto[6].InterFace_IN[7]:=FALSE;
Auto[6].InterFace_IN[8]:=FALSE;
Auto[6].InterFace_IN[9]:=FALSE;


//清除流程步
IF NOT DB2000_Control.Mode.Status.HomeOK THEN
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
Start[6]:= FALSE;


//工程启动
IF DB2000_Control.Mode.Status.AutoRunning AND DB2000_Control.Mode.Status.HomeOK AND NOT Auto[6].Running AND NOT Auto[6].Disable THEN
	IF (Start[6] AND NOT DB2000_Control.Mode.Status.StationMode) OR 
		(Auto[6].Start AND DB2000_Control.Mode.Status.StationMode) THEN
		Auto[6].Running:=TRUE;
		Auto[6].Start:=FALSE;
		Auto[6].Step:=5;
		Auto[6].CycleTime:=0;
		Auto[6].Comment:="工程启动";
	END_IF
END_IF

RunAgin: //再次执行Case条件命令，节省一个扫描周期
Auto[6].StepBefor := Auto[6].Step;

//流程不暂停条件
Auto[6].NoPausedRunning:=FALSE ;

//工程运转中
IF ((DB2000_Control.Mode.Status.AutoRunning AND DB2000_Control.Mode.Status.StepRunning) OR Auto[6].NoPausedRunning) AND NOT Auto[6].Disable THEN
	CASE Auto[6].Step OF
		5 :
			Auto[6].Comment:="工程启动";
			Auto[6].Step:=0;			

		1000:
			Auto[6].Comment:="工程结束";
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
	JMP RunAgin;
END_IF

 
