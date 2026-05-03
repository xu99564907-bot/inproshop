
//延时时间
AutoTimeDelay[7,0](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[7,1](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[7,2](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[7,3](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[7,4](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[7,5](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[7,6](IN:=FALSE,PT:=T#100MS);

//交互信号
Auto[7].InterFace_IN[0]:=Auto[4].InterFace_OUT[1];//打印机打印完成
Auto[7].InterFace_IN[1]:=Auto[5].InterFace_OUT[1];//装袋部装包完成
Auto[7].InterFace_IN[2]:=Auto[5].InterFace_OUT[2];//装袋部固定完成
Auto[7].InterFace_IN[3]:=Auto[6].InterFace_OUT[2];//热封部固定完成
Auto[7].InterFace_IN[4]:=FALSE;
Auto[7].InterFace_IN[5]:=FALSE;
Auto[7].InterFace_IN[6]:=FALSE;
Auto[7].InterFace_IN[7]:=FALSE;
Auto[7].InterFace_IN[8]:=FALSE;
Auto[7].InterFace_IN[9]:=FALSE;


//清除流程步
IF NOT DB7000_Control.Mode.Status.HomeOK THEN
	Auto[7].Step:=0;
	Auto[7].Running:=FALSE;
	FOR i:=0 TO 9 BY 1 DO
		Auto[7].InterFace_OUT[i]:=FALSE;
	END_FOR
END_IF

//单元周期计时
IF Auto[7].Running AND CPU_Clock.Clock_100ms_R THEN
	Auto[7].CycleTime:=Auto[7].CycleTime+1;
END_IF

//工程启动条件
Start[7]:= Auto[4].InterFace_IN[0];

//流程不暂停条件
Auto[7].NoPausedRunning:=FALSE ;

//工程启动
IF DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.HomeOK AND NOT Auto[7].Running THEN
	IF (Start[7] AND NOT DB7000_Control.Mode.Status.StationMode) OR 
		(Auto[7].Start AND DB7000_Control.Mode.Status.StationMode) THEN
		Auto[7].Running:=TRUE;
		Auto[7].Start:=FALSE;
		Auto[7].Step:=5;
		Auto[7].CycleTime:=0;
		Auto[7].Comment:="工程启动";
	END_IF
END_IF

//RunAgin: //再次执行Case条件命令，节省一个扫描周期
Auto[7].StepBefor := Auto[7].Step;

//工程运转中
IF DB7000_Control.Mode.Status.AutoRunning OR Auto[7].NoPausedRunning THEN
	CASE Auto[7].Step OF
		5 :
			Auto[7].Comment:="工程开始";
			IF TRUE THEN
				Auto[7].Step:=10;
			END_IF;

		200:
			Auto[7].Comment:="工程结束";
			Auto[7].Step:=1000;

		1000:
			Auto[7].Comment:="工程结束";
			Auto[7].Running:=FALSE;
			Auto[7].Step:=0;
		;
	ELSE
		;
	END_CASE

	;
END_IF

//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[7].StepBefor <> Auto[7].Step THEN
	;//JMP RunAgin;
END_IF




//











