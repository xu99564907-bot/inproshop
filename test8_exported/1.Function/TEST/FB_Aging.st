FUNCTION_BLOCK FB_Aging
VAR_INPUT
	iButton_Start:BOOL;//手动启动测试
	iRobot_Start:BOOL;//自动启动测试
	iRobot_PickOut:BOOL;//机械手取出
	iClock:BOOL;//计时脉冲
	iAutoMode:BOOL;//自动
	iReset:BOOL;//报警复位
	iStartIC:BOOL;//启动条件同组的5个互锁
	iEstop:BOOL;//紧急停止
	iSensor:BOOL;//物料到位检测传感器
	icurrentUp:REAL;//上电机电流
	icurrentDown:REAL;//下电机电流
	icurrentUpSet:REAL := 1.0;//上电机堵转电流
	icurrentDownSet:REAL := 2.0;//下电机堵转电流	
END_VAR

VAR_OUTPUT
	oRedLamp:BOOL;//红色指示灯
	oYelLamp:BOOL;//黄色指示灯
	oGrnLamp:BOOL;//绿色指示灯
	oMotorUpFor:BOOL;//上电机正转
	oMotorUpBak:BOOL;//上电机反转
	oMotorDownFor:BOOL;//下电机正转
	oMotorDownBak:BOOL;//下电机反转	
	oPower:BOOL;//控制电源
END_VAR

VAR_IN_OUT
	ioAging:Str_Aging;
END_VAR

VAR
	i:INT;//循环用
	Step:INT;//测试步骤
	NotPause:BOOL;//步序不暂停
	TestTime:TON;//累计老化时间;
	IntervalTime:TON;//老化间隔时间
	LastTimeDelay:TON;//最后上升时间控制
	UpMotorForDelay:TON;//上电机正转计时
	UpMotorBakDelay:TON;//上电机反转计时
	DownMotorForDelay:TON;//下电机正转计时
	DownMotorBakDelay:TON;//下电机反转计时
	UpMotorcurrentLimit:TON;//上电机堵转计时
	DownMotorcurrentLimit:TON;//上电机堵转计时
	StepDelay:ARRAY[1..20] OF TON;//步序延时
END_VAR
//电机复位
ioAging.Cmd.AutoMotorUpFor:=FALSE;
ioAging.Cmd.AutoMotorUpBak:=FALSE;
ioAging.Cmd.AutoMotorDownFor:=FALSE;
ioAging.Cmd.AutoMotorDownBak:=FALSE;

//开始计时-测试时间
TestTime(IN:= Step<>0 AND (iEstop AND NOT ioAging.Status.Error) , PT:= DINT_TO_TIME(INT_TO_DINT(ioAging.Parm.AgingTime)*1000), Q=> , ET=> );
//计时-间隔时间
IntervalTime(IN:= Step=60 , PT:= INT_TO_TIME(ioAging.Parm.AgingInterval*1000), Q=> , ET=> );
//最后定位时间
LastTimeDelay(IN:=Step=120 , PT:= ioAging.Parm.LastTime, Q=> , ET=> );

//工程启动
IF ioAging.Cmd.Excute OR iButton_Start THEN
	Step:=5;
	ioAging.Cmd.Excute:=FALSE;
END_IF

//停止测试
IF ioAging.Cmd.Stop THEN
	ioAging.Cmd.Stop:=0;
	Step:=0;
	IF ioAging.Status.State <>3 THEN
		IF iSensor THEN
			ioAging.Status.State:=4;
		ELSE
			ioAging.Status.State:=0;
		END_IF
	END_IF
END_IF

//空闲状态判定
// IF  iRobot_PickOut  THEN
// 	IF iSensor THEN
// 		ioAging.Status.Error:=TRUE;//物料残留
// 		ioAging.Status.ErrorID:=2;
// 	
// 	ELSE
// 		ioAging.Status.State:=0;//空闲
// 	END_IF
// END_IF

//测试中
ioAging.Status.Busy:=Step<>0;

//进入步延时
FOR i:=1 TO 20 BY 1 DO
	StepDelay[i](IN:= Step=i*10, PT:= T#0.3S );
END_FOR



//不停止步序条件
NotPause:=Step=120;
IF (iEstop AND NOT ioAging.Status.Error ) OR NotPause THEN
	CASE Step OF
		
		5:
			IF iSensor THEN
				Step:=10;
				ioAging.Status.State:=1;
			ELSE				
				ioAging.Status.Error:=TRUE;//未检测到物料
				ioAging.Status.ErrorID:=1;
			END_IF
		
		10 ://上电机旋转到打开位置	
			ioAging.Cmd.AutoMotorUpFor:=TRUE;
			ioAging.Status.State:=2;
			IF icurrentUp > icurrentUpSet AND StepDelay[1].Q THEN
				Step:=20;
			END_IF
		
		20://下电机正转到最下方
			ioAging.Cmd.AutoMotorDownFor:=TRUE;
			IF icurrentDown > icurrentDownSet AND StepDelay[2].Q THEN
				Step:=30;
			END_IF		
		
		30://下电机反转转到最上方
			ioAging.Cmd.AutoMotorDownBak:=TRUE;
			IF icurrentDown < 0-icurrentDownSet AND StepDelay[3].Q THEN
				Step:=40;
			END_IF
			
		40://上电机正转到最里面
			ioAging.Cmd.AutoMotorUpBak:=TRUE;
			IF icurrentUp < 0- icurrentUpSet AND StepDelay[4].Q THEN
				Step:=50;
			END_IF	
		
		50://判定是否到达设定时间
			IF TestTime.Q THEN
				Step:=100;
			ELSE
				Step:=60;
			END_IF
	
		60://延时指定间隔时间
			IF IntervalTime.Q THEN
				Step:=10;
			END_IF			

		
		100://测试结束，上电机转出
			ioAging.Cmd.AutoMotorUpFor:=TRUE;
			IF icurrentUp > icurrentUpSet AND StepDelay[10].Q THEN
				Step:=110;
			END_IF	
			
		110://下电机反转转到负极限位置
			ioAging.Cmd.AutoMotorDownBak:=TRUE;
			IF icurrentDown < icurrentDownSet*-1 AND StepDelay[11].Q THEN
				Step:=120;
			END_IF		
			
		120://测试结束，回到初始状态-向上旋转指定时间		
			ioAging.Cmd.AutoMotorDownFor:=TRUE;
			IF LastTimeDelay.Q THEN
				Step:=200;
			END_IF
		
		200://测试结束，流程完成			
			Step:=0;
			ioAging.Status.Done:=TRUE;
			ioAging.Status.State:=3;
		
	END_CASE

END_IF


//机械手放入产品时，上电机按照时序控制正反转
IF ioAging.Cmd.PutIn THEN	
	IF CPU_Clock.Clock_100ms THEN
		ioAging.Cmd.AutoMotorUpFor:=TRUE;
	ELSE
		ioAging.Cmd.AutoMotorUpBak:=TRUE;
	END_IF
END_IF


//超时计时
UpMotorForDelay(IN:= oMotorUpFor, PT:= T#5S, Q=> , ET=> );
UpMotorBakDelay(IN:= oMotorUpBak, PT:= T#5S, Q=> , ET=> );
DownMotorForDelay(IN:= oMotorDownFor, PT:= T#5S, Q=> , ET=> );
DownMotorBakDelay(IN:= oMotorDownBak, PT:= T#5S, Q=> , ET=> );
UpMotorcurrentLimit(IN:= ABS(icurrentUp) > icurrentUpSet, PT:= T#1S, Q=> , ET=> );
DownMotorcurrentLimit(IN:= ABS(icurrentDown) > icurrentDownSet, PT:= T#1S, Q=> , ET=> );





//报警状态分类
IF icurrentUp > 8.0 THEN//上电机模拟量输入异常-短路
	ioAging.Status.Error:=TRUE;
	ioAging.Status.ErrorID:=11;
ELSIF icurrentUp < -8.0 THEN//上电机模拟量输入异常-断路
	ioAging.Status.Error:=TRUE;
	ioAging.Status.ErrorID:=12;
ELSIF UpMotorcurrentLimit.Q  THEN//上电机堵转超时
	ioAging.Status.Error:=TRUE;
	ioAging.Status.ErrorID:=13;
ELSIF UpMotorForDelay.Q  THEN//上电机正转超时
	ioAging.Status.Error:=TRUE;
	ioAging.Status.ErrorID:=14;
ELSIF UpMotorBakDelay.Q  THEN//上电机反转超时
	ioAging.Status.Error:=TRUE;
	ioAging.Status.ErrorID:=15;


ELSIF icurrentDown > 8.0 THEN//下电机模拟量输入异常-短路
	ioAging.Status.Error:=TRUE;
	ioAging.Status.ErrorID:=21;
ELSIF icurrentDown < -8.0 THEN//下电机模拟量输入异常-短路
	ioAging.Status.Error:=TRUE;
	ioAging.Status.ErrorID:=22;	
ELSIF DownMotorcurrentLimit.Q  THEN//下电机堵转超时
	ioAging.Status.Error:=TRUE;
	ioAging.Status.ErrorID:=23;
ELSIF DownMotorForDelay.Q  THEN//下电机正转超时
	ioAging.Status.Error:=TRUE;
	ioAging.Status.ErrorID:=24;
ELSIF DownMotorBakDelay.Q  THEN//下电机反转超时
	ioAging.Status.Error:=TRUE;
	ioAging.Status.ErrorID:=25;
END_IF

//报警复位
IF iReset OR ioAging.Cmd.Excute OR iButton_Start THEN
	ioAging.Status.Error:=FALSE;
	ioAging.Status.ErrorID:=0;
END_IF

//输出控制
IF iAutoMode THEN
	oMotorUpFor		:=ioAging.Cmd.AutoMotorUpFor;		
	oMotorUpBak		:=ioAging.Cmd.AutoMotorUpBak;		
	oMotorDownFor	:=ioAging.Cmd.AutoMotorDownFor;	
	oMotorDownBak	:=ioAging.Cmd.AutoMotorDownBak;		
ELSE	
	oMotorUpFor		:=ioAging.Cmd.ManuMotorUpFor;		
	oMotorUpBak		:=ioAging.Cmd.ManuMotorUpBak;		
	oMotorDownFor	:=ioAging.Cmd.ManuMotorDownFor;	
	oMotorDownBak	:=ioAging.Cmd.ManuMotorDownBak;		
END_IF

//保护-上电机堵转
IF UpMotorcurrentLimit.Q THEN
	ioAging.Cmd.ManuMotorUpFor:=FALSE;
	ioAging.Cmd.ManuMotorUpBak:=FALSE;
	ioAging.Cmd.AutoMotorUpFor:=FALSE;
	ioAging.Cmd.AutoMotorUpBak:=FALSE;
END_IF

//保护-下电机堵转
IF DownMotorcurrentLimit.Q THEN
	ioAging.Cmd.ManuMotorDownFor:=FALSE;
	ioAging.Cmd.ManuMotorDownBak:=FALSE;
	ioAging.Cmd.AutoMotorDownFor:=FALSE;
	ioAging.Cmd.AutoMotorDownBak:=FALSE;
END_IF


//测试时当前电流最大值记录
IF oMotorUpFor OR oMotorUpBak THEN
	IF ABS(icurrentUp)>ABS(ioAging.Status.Upcurrent) THEN
		ioAging.Status.UpcurrentMAX:=icurrentUp;
	END_IF
END_IF
IF oMotorDownFor OR oMotorDownBak THEN
	IF ABS(icurrentDown)>ABS(ioAging.Status.Downcurrent) THEN
		ioAging.Status.DowncurrentMAX:=icurrentDown;
	END_IF
END_IF


//当前电流值映射
ioAging.Status.Upcurrent:=icurrentUp;
ioAging.Status.Downcurrent:=icurrentDown;

//已测试时间
ioAging.Status.TestTime:=DINT_TO_INT(TIME_TO_DINT(TestTime.ET)/1000);


//输出指示灯
oRedLamp:=FALSE;
oYelLamp:=FALSE;
oGrnLamp:=FALSE;
IF ioAging.Status.Error THEN
	oRedLamp:=CPU_Clock.Clock_1s;
ELSE
	CASE ioAging.Status.State OF
		0 ://空闲
			oGrnLamp:=CPU_Clock.Clock_1s;
		1://待老化
			oYelLamp:=CPU_Clock.Clock_1s;
		2://老化中
			oYelLamp:=TRUE;		
		3://老化OK
			oGrnLamp:=TRUE;						
		4://老化NG
			oRedLamp:=TRUE;			
	END_CASE 
END_IF

//产品取出后状态自动清除
IF (ioAging.Status.State = 3 OR ioAging.Status.State = 4) AND NOT iSensor THEN
	ioAging.Status.State:=0;
END_IF

//控制标志位自复位
ioAging.Cmd.PutIn:=FALSE;
