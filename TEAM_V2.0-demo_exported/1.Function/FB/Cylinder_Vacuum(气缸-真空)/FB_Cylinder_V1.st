FUNCTION_BLOCK FB_Cylinder_V1

VAR_INPUT
	iEnable:BOOL;//气缸使能
	iName:WSTRING(40);//气缸名称
	iMode:Str_Mode;//设备运行模式
	iEstop:BOOL;//急停
	iSafeDoor:BOOL;//安全门信号
	iLightCurtain:BOOL;//光栅信号
	iClock_100ms:BOOL;//100MS脉冲信号
	iSensor_Work:BOOL;//工作位感应器
	iSensor_Home:BOOL;//初始位感应器
	iIC_Home:BOOL;//初始位互锁
	iIC_Work:BOOL;//工作位互锁
	iValveModel:INT;//电磁阀型号[=0单电控，=1双电控普通，=2中封，=3中泄
	iManuCheck:BOOL;//手自动切换检查状态=0检查，=1不检查
END_VAR

VAR_IN_OUT
	ioCylinder:Str_Cylinder;
END_VAR
VAR_OUTPUT RETAIN PERSISTENT
	oValve_Work:BOOL;//工作位电磁阀
	oValve_Home:BOOL;//初始位电磁阀
END_VAR
VAR
	TON_HomeDelay	:TON;//初始位感应器延时
	TON_WorkDelay	:TON;//动作位感应器延时
	TON_ErrorDelay	:TON;//报警延时
	TON_HomeOffDelay	:TON;//吸真空电磁阀破真空延时
	Change	:BOOL;//手动下状态记忆
	Valve_Home_P	:R_TRIG;//初始位电磁阀上升沿
	Valve_Work_P	:R_TRIG	;//动作位电磁阀上升沿
	Sp_Time	:BOOL;//计时标志位
	TON_Sp_Time	:TON;//动作计时
	i	:INT;//
	Errror	:BOOL;//报错
	Error_P	:R_TRIG	;//	
END_VAR

//气缸未使能，复位报警，跳过程序
IF NOT iEnable THEN
	ioCylinder.Status.Error:=FALSE;
	ioCylinder.Status.ErrorID:=0;
	RETURN;
END_IF;
//硬件映射
ioCylinder.DevStatus.Sensor_Work:=iSensor_Work;
ioCylinder.DevStatus.Sensor_Home:=iSensor_Home;
ioCylinder.DevStatus.Valve_Work:=oValve_Work;
ioCylinder.DevStatus.Valve_Home:=oValve_Home;
//气缸互锁状态映射
ioCylinder.Parm.IC_Home:=iIC_Home OR iMode.Cmd.ManUnlock;
ioCylinder.Parm.IC_Work:=iIC_Work OR iMode.Cmd.ManUnlock;

//气缸名称赋值
ioCylinder.Parm.Comment:=iName;

//初始值赋值
IF ioCylinder.Parm.Error_Delay=0 THEN
	ioCylinder.Parm.Error_Delay:=50;
END_IF;


//******************报警复位************************
IF iMode.Out.ErrorReset THEN
	Errror:=FALSE;
	ioCylinder.Status.Error:=FALSE;
	ioCylinder.Status.ErrorID:=0;
END_IF;

//************************************************气缸动作**************************************************
IF iMode.Status.AutoMode THEN//自动模式
	
	IF ioCylinder.Parm.IC_Home AND ioCylinder.Cmd.AutoToHome AND iEstop AND iSafeDoor AND iLightCurtain THEN//自动前往初始位
		oValve_Home:=TRUE;
		oValve_Work:=FALSE;	
	ELSIF ioCylinder.Parm.IC_Work AND ioCylinder.Cmd.AutoToWork AND iEstop AND iSafeDoor AND iLightCurtain THEN//自动前往动作位
		oValve_Work:=TRUE ;
		oValve_Home:=FALSE;	
	END_IF;
	
ELSIF iMode.Status.ManualMode THEN//手动模式
	
	IF ioCylinder.Parm.IC_Home AND ioCylinder.Cmd.ManuToHome AND iEstop AND iSafeDoor AND iLightCurtain THEN//手动前往初始位
		oValve_Home:=TRUE;
		oValve_Work:=FALSE;	
	ELSIF ioCylinder.Parm.IC_Work AND ioCylinder.Cmd.ManuToWork AND iEstop AND iSafeDoor AND iLightCurtain THEN//手动前往动作位
		oValve_Work:=TRUE ;
		oValve_Home:=FALSE;	
	END_IF;
END_IF;

//************************************************************************延时到位********************************************************
//初始位延时到位信号（1、感应器未屏蔽，感应器延时；2、感应器屏蔽，电磁阀输出延时）
TON_HomeDelay(In:=(iSensor_Home AND NOT ioCylinder.Parm.DisableHome)OR(oValve_Home AND ioCylinder.Parm.DisableHome), PT:=UINT_TO_TIME(ioCylinder.Parm.Home_Delay*100), Q=>ioCylinder.Status.InHome);
//动作位延时到位信号（1、感应器未屏蔽，感应器延时；2、感应器屏蔽，电磁阀输出延时）
TON_WorkDelay(In:=(iSensor_Work AND NOT ioCylinder.Parm.DisableWork)OR(oValve_Work AND ioCylinder.Parm.DisableWork), PT:=UINT_TO_TIME(ioCylinder.Parm.Work_Delay*100), Q=>ioCylinder.Status.InWork);

//*****************电磁阀输出上升延获取******************
Valve_Home_P(Clk:=oValve_Home);
Valve_Work_P(Clk:=oValve_Work);

//************************手动状态记忆************************
IF iMode.Status.ManualMode AND( Valve_Home_P.Q OR Valve_Work_P.Q ) THEN
	IF Change THEN
		Change:=FALSE;
	ELSE
		Change:=TRUE;
	END_IF;
END_IF;

//设备未初始化复位标志位
IF NOT iMode.Status.HomeOK OR iManuCheck THEN
	Change:=FALSE;
END_IF;

//******************************气缸报警******************************
IF oValve_Home AND NOT iSensor_Home AND NOT ioCylinder.Parm.DisableHome THEN//电磁阀初始位动作，初始位感应器OFF;&初始位感应器未屏蔽
	Errror:=TRUE;
    ioCylinder.Status.ErrorID:=1;//前往初始位超时报警
	
ELSIF oValve_Work AND NOT iSensor_Work AND NOT ioCylinder.Parm.DisableWork THEN//电磁阀动作位动作，动作位感应器OFF;&动作位感应器未屏蔽
	Errror:=TRUE;
	ioCylinder.Status.ErrorID:=2;//前往动作位超时报警
   
ELSIF  iSensor_Work AND iSensor_Home AND NOT ioCylinder.Parm.DisableHome AND NOT ioCylinder.Parm.DisableWork  THEN //初始位感应器ON,动作位感应器ON;&初始位感应器未屏蔽,动作位感应器未屏蔽
	Errror:=TRUE;
	ioCylinder.Status.ErrorID:=3;//动作位和初始位感应器都ON报警
	
ELSIF NOT  iSensor_Work AND NOT iSensor_Home AND NOT ioCylinder.Parm.DisableHome AND NOT ioCylinder.Parm.DisableWork  THEN//初始位感应器ON,动作位感应器ON;&初始位感应器未屏蔽,动作位感应器未屏蔽
	Errror:=TRUE;
	ioCylinder.Status.ErrorID:=4;//动作位和初始位感应器都OFF报警
	
ELSIF NOT ioCylinder.Parm.IC_Home AND (ioCylinder.Cmd.AutoToHome OR ioCylinder.Cmd.ManuToHome) THEN//初始位互锁条件未满足，手动或自动前往初始位
	ioCylinder.Status.Error:=TRUE;
	ioCylinder.Status.ErrorID:=5;//初始位互锁条件未满足报警
	
ELSIF NOT ioCylinder.Parm.IC_Work AND (ioCylinder.Cmd.AutoToWork OR ioCylinder.Cmd.ManuToWork) THEN//动作位互锁条件未满足，手动或自动前往动作位
	ioCylinder.Status.Error:=TRUE;
	ioCylinder.Status.ErrorID:=6;//动作位互锁条件未满足报警
	
ELSIF iMode.Status.AutoMode AND Change THEN//自动模式下，气缸操作状态未复原
	ioCylinder.Status.Error:=TRUE;
	ioCylinder.Status.ErrorID:=7;	//手动操作后气缸未还原报警
	
ELSE
	Errror:=FALSE;
END_IF;

//1,2,3,4报警延时输出
TON_ErrorDelay(in:=Errror,PT:=UINT_TO_TIME(ioCylinder.Parm.Error_Delay*100));
IF TON_ErrorDelay.Q THEN
	ioCylinder.Status.Error:=TRUE;
END_IF;

//************************气缸动作时间分析************************
//开始条件：电磁阀上升沿信号触发
IF Valve_Home_P.Q OR Valve_Work_P.Q THEN
	Sp_Time:=TRUE;	//计时开始
	FOR i:=9 TO 1 BY -1 DO//循环数据位移，保存上次记录数据
	    ioCylinder.Status.Sp_Time[i]:=ioCylinder.Status.Sp_Time[i-1];
	END_FOR;
	ioCylinder.Status.Sp_Time[0]:=0;
END_IF;

//结束条件：前往初始位，初始位感应器ON；前往动作位，动作位感应器ON
IF (oValve_Home AND ioCylinder.Status.InHome) OR (oValve_Work AND ioCylinder.Status.InWork) THEN
  	Sp_Time:=FALSE;	//计时结束
END_IF;

//100MS脉冲上升沿增加100
IF Sp_Time AND iClock_100ms THEN
	ioCylinder.Status.Sp_Time[0]:=ioCylinder.Status.Sp_Time[0]+1;
END_IF;

//******************************使用寿命计数******************************
IF Valve_Home_P.Q OR Valve_Work_P.Q THEN
	ioCylinder.Status.Sp_Times:=ioCylinder.Status.Sp_Times+1;
END_IF;

//******************************报警计数******************************
Error_P(CLK:=ioCylinder.Status.Error);
IF Error_P.Q THEN
	ioCylinder.Status.Er_Times:=ioCylinder.Status.Er_Times+1;
END_IF;

//************************控制字自复位************************
ioCylinder.Cmd.AutoToHome:=FALSE;
ioCylinder.Cmd.AutoToWork:=FALSE;
ioCylinder.Cmd.ManuToHome:=FALSE;
ioCylinder.Cmd.ManuToWork:=FALSE;