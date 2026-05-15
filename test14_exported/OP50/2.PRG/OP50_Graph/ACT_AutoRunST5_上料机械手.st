
//延时时间
AutoTimeDelay[5,0](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[5,1](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[5,2](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[5,3](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[5,4](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[5,5](IN:=FALSE,PT:=T#100MS);
AutoTimeDelay[5,6](IN:=FALSE,PT:=T#100MS);

//交互信号
Auto[5].InterFace_IN[0]:=FALSE;
Auto[5].InterFace_IN[1]:=FALSE;
Auto[5].InterFace_IN[2]:=FALSE;
Auto[5].InterFace_IN[3]:=FALSE;
Auto[5].InterFace_IN[4]:=FALSE;
Auto[5].InterFace_IN[5]:=FALSE;
Auto[5].InterFace_IN[6]:=FALSE;
Auto[5].InterFace_IN[7]:=FALSE;
Auto[5].InterFace_IN[8]:=FALSE;
Auto[5].InterFace_IN[9]:=FALSE;


//清除流程步
IF NOT DB5000_Control.Mode.Status.HomeOK THEN
	Auto[5].Step:=0;
	Auto[5].Running:=FALSE;
	FOR i:=0 TO 9 BY 1 DO
		Auto[5].InterFace_OUT[i]:=FALSE;
	END_FOR
END_IF

//单元周期计时
IF Auto[5].Running AND CPU_Clock.Clock_100ms_R THEN
	Auto[5].CycleTime:=Auto[5].CycleTime+1;
END_IF

//工程启动条件
Start[5]:= FALSE;

//工程启动
IF DB5000_Control.Mode.Status.AutoRunning AND DB5000_Control.Mode.Status.HomeOK AND NOT Auto[5].Running AND NOT Auto[5].Disable THEN
	IF (Start[5] AND NOT DB5000_Control.Mode.Status.StationMode) OR 
		(Auto[5].Start AND DB5000_Control.Mode.Status.StationMode) THEN
		Auto[5].Running:=TRUE;
		Auto[5].Start:=FALSE;
		Auto[5].Step:=5;
		Auto[5].CycleTime:=0;
		Auto[5].Comment:="工程启动";
	END_IF
END_IF

RunAgin: //再次执行Case条件命令，节省一个扫描周期
Auto[5].StepBefor := Auto[5].Step;

//流程不暂停条件
Auto[5].NoPausedRunning:=FALSE ;

//工程运转中
IF ((DB5000_Control.Mode.Status.AutoRunning AND DB5000_Control.Mode.Status.StepRunning)  OR Auto[5].NoPausedRunning) AND NOT Auto[5].Disable THEN
	CASE Auto[5].Step OF
		5 :
			Auto[5].Comment:="判定流程";
			 
				Auto[5].Step:=1000;//前往取老化				
			 

		1000:
			Auto[5].Comment:="工程结束";
			Auto[5].Running:=FALSE;
			Auto[5].Step:=0;
		;
	ELSE
		;
	END_CASE

	;
END_IF

//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[5].StepBefor <> Auto[5].Step THEN
	JMP RunAgin;
END_IF
 


