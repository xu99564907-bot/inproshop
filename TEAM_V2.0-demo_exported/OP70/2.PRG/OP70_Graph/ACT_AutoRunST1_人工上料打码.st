
//延时时间
AutoTimeDelay[1,0](IN:=Auto[1].Step=5,PT:=T#500MS);
AutoTimeDelay[1,1](IN:=Auto[1].Step=60,PT:=T#3000MS);
AutoTimeDelay[1,2]();
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
IF NOT DB7000_Control.Mode.Status.HomeOK THEN
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
IF DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.HomeOK AND Init[1].Complete AND NOT Auto[1].Running THEN
	IF (Start[1] AND NOT DB7000_Control.Mode.Status.StationMode) OR 
		(Auto[1].Start AND DB7000_Control.Mode.Status.StationMode) THEN
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
Auto[1].NoPausedRunning:=TRUE;//打码流程不暂停


//工程运转中
IF (DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.StepRunning) OR Auto[1].NoPausedRunning   THEN
	CASE Auto[1].Step OF 
		
		5 :
			Auto[1].Comment:="上料完成等待启动"; 
			IF DB7050_DriveControl.Sensor[Enum_OP70_Sensor.传感器1].Status._ON   THEN
				DB7090_Other.StationData[1].Num:=1;
				Auto[1].Step:=20;
			ELSE
				 ;//物料检测不在位
			END_IF

         10:			
	   		Auto[1].Comment:="上料侧边定位气缸CY01_伸出";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				 Auto[1].Step:=20;
			END_IF	
		
		20:
			Auto[1].Comment:="等待X2轴在安全位置";
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome   THEN
				 Auto[1].Step:=30;
			END_IF


         30:
			Auto[1].Comment:="前往打标位置";
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X1].Cmd.AutoABS:=2;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X1].Status.InPoint[2] THEN
				Auto[1].Step:=40;
			END_IF

         40:			
	   		Auto[1].Comment:="上料避位升降气缸-CY02_上升";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				IF DB7090_Other.StationData[1].CodeStatus=1 THEN//判定是否已打标
					Auto[1].Step:=80;
				ELSE
					Auto[1].Step:=50;
				END_IF				 
			END_IF	
			
		 50:			
	   		Auto[1].Comment:="触发打标";
			DB7050_DriveControl.PrintCtrl[1].Cmd.Execute:=TRUE;		
			IF DB7050_DriveControl.PrintCtrl[1].Status.Busy THEN
				DB7090_Other.StationData[1].ProductCode:='';//确认打码规则后填入
				Auto[1].Step:=60;
			END_IF

		 60:			
	   		Auto[1].Comment:="等待打标完成";
			IF DB7050_DriveControl.PrintCtrl[1].Status.Done AND AutoTimeDelay[1,1].Q THEN	
				Auto[1].Step:=80;
			END_IF;	 
			
         80:			
	   		Auto[1].Comment:="上料侧边定位气缸CY01_缩回";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToHome :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				DB7090_Other.StationData[1].CodeStatus:=1;							
				 Auto[1].Step:=90;
			END_IF	
			
		90:
	   		Auto[1].Comment:="等待产品取走";
			IF  DB7090_Other.StationData[1].Num=0
				AND DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InHome  THEN
				 Auto[1].Step:=100;
			END_IF				
			
		100:
	   		Auto[1].Comment:="出料完成判断";
			IF DB7050_DriveControl.Sensor[Enum_OP70_Sensor.传感器1].Status._OFF   THEN
				 Auto[1].Step:=200;
			ELSE
				 ;//物料残留报警
			END_IF	
 
        200:
			Auto[1].Comment:="前往上料位置";
			DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X1].Cmd.AutoABS:=1;
			IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.X1].Status.InPoint[1] THEN
				Auto[1].Step:=210;
			END_IF
			
			
	    210:			
	   		Auto[1].Comment:="上料避位升降气缸-CY02_上升";
			DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Cmd.AutoToWork :=TRUE;
			IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.气缸1].Status.InWork  THEN
				 Auto[1].Step:=1000;
			END_IF			

 
		1000:
			Auto[1].Comment:="工程结束";
			Auto[1].Running:=FALSE;
			Auto[1].Step:=0;

	END_CASE

END_IF

//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[1].StepBefor <> Auto[1].Step THEN
	JMP RunAgin;
END_IF


