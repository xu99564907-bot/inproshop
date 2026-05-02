FUNCTION_BLOCK FB_Vacuum_V1

VAR_INPUT
	iEnable:BOOL;// 真空使能
	iName:WSTRING(40);// 真空名称
	iEstop:BOOL;//急停
	iReset:BOOL;//报警复位
	iAuto:BOOL;//自动模式
	iHomeOK:BOOL;//设备回原完成
	iClock_100ms:BOOL;//100MS脉冲信号
	iSensor_Work:BOOL;//真空表头感应器
	iIC_Home:BOOL;//破真空互锁	
	iIC_Work:BOOL;//吸真空互锁	
	iManuCheck:BOOL;//手自动切换检查状态=0检查，=1不检查
END_VAR

VAR_IN_OUT
	ioVaccum:Str_Cylinder;
END_VAR

VAR_OUTPUT
	oValve_Work:BOOL;//吸真空电磁阀
	oValve_Home:BOOL;//破真空电磁阀
END_VAR
VAR
	TON_HomeDelay	:TON;//初始位感应器延时
	TON_WorkDelay	:TON;//动作位感应器延时
	TON_CloseDelay	:TON;//破真空延时
	TON_ErrorDelay	:TON;//报警延时
	TON_HomeOffDelay	:TON;//吸真空电磁阀破真空延时
	Change	:BOOL;//手动下状态记忆
	Valve_Work_F	:F_TRIG;//动作位电磁阀下降沿
	Valve_Work_R	:R_TRIG	;//动作位电磁阀上升沿
	Sp_Time	:BOOL;//计时标志位
	TON_Sp_Time	:TON;//动作计时
	i	:INT;//
	Errror	:BOOL;//报错
	Error_P	:R_TRIG	;//	
END_VAR

//气缸未使能，复位报警，跳过程序
IF NOT iEnable THEN
	ioVaccum.Status.Error:=FALSE;
	ioVaccum.Status.ErrorID:=0;
	RETURN;
END_IF;
//硬件映射
ioVaccum.DevStatus.Sensor_Work:=iSensor_Work;
ioVaccum.DevStatus.Sensor_Home:=NOT iSensor_Work;
ioVaccum.DevStatus.Valve_Work:=oValve_Work;
ioVaccum.DevStatus.Valve_Home:=oValve_Home;


//气缸名称赋值
ioVaccum.Parm.Comment:=iName;

//初始值赋值
IF ioVaccum.Parm.Error_Delay=0 THEN
	ioVaccum.Parm.Error_Delay:=50;
END_IF;
IF ioVaccum.Parm.Close_Delay=0 THEN
	ioVaccum.Parm.Close_Delay:=2;
END_IF;

//互锁状态映射
ioVaccum.Parm.IC_Home:=iIC_Home;
ioVaccum.Parm.IC_Work:=iIC_Work;

//******************报警复位************************
IF iReset THEN
	Errror:=FALSE;
	ioVaccum.Status.Error:=FALSE;
	ioVaccum.Status.ErrorID:=0;
END_IF;

//************************************************真空动作**************************************************
IF iAuto THEN//自动模式
	
	IF ioVaccum.Parm.IC_Home AND ioVaccum.Cmd.AutoToHome THEN//自动模式破真空
		oValve_Home:=TRUE;
		oValve_Work:=FALSE;	
	ELSIF ioVaccum.Parm.IC_Work AND ioVaccum.Cmd.AutoToWork THEN//自动模式吸真空
		oValve_Work:=TRUE ;
		oValve_Home:=FALSE;	
	END_IF;
	
ELSE//手动模式
	
	IF ioVaccum.Parm.IC_Home AND ioVaccum.Cmd.ManuToHome THEN//手动模式破真空
		oValve_Home:=TRUE;
		oValve_Work:=FALSE;	
	ELSIF ioVaccum.Parm.IC_Work AND ioVaccum.Cmd.ManuToWork THEN//手动模式吸真空
		oValve_Work:=TRUE ;
		oValve_Home:=FALSE;	
	END_IF;
END_IF;

//破真空延时
TON_CloseDelay(IN:= oValve_Home, PT:= UINT_TO_TIME(ioVaccum.Parm.Close_Delay*100));
IF TON_CloseDelay.Q THEN
	oValve_Home:=FALSE;
END_IF

//************************************************************************延时到位********************************************************
//初始位延时到位信号（1、感应器未屏蔽，感应器延时；2、感应器屏蔽，电磁阀输出延时）
TON_HomeDelay(In:=(NOT iSensor_Work AND NOT ioVaccum.Parm.DisableWork)OR(oValve_Work AND ioVaccum.Parm.DisableWork), PT:=UINT_TO_TIME(ioVaccum.Parm.Home_Delay*100), Q=>ioVaccum.Status.InHome);
//动作位延时到位信号（1、感应器未屏蔽，感应器延时；2、感应器屏蔽，电磁阀输出延时）
TON_WorkDelay(In:=(iSensor_Work AND NOT ioVaccum.Parm.DisableWork)OR(oValve_Work AND ioVaccum.Parm.DisableWork), PT:=UINT_TO_TIME(ioVaccum.Parm.Work_Delay*100), Q=>ioVaccum.Status.InWork);

//*****************电磁阀输出上升延获取******************
Valve_Work_F(Clk:=oValve_Work);
Valve_Work_R(Clk:=oValve_Work);

//************************手动状态记忆************************
IF NOT iAuto AND( Valve_Work_F.Q OR Valve_Work_R.Q ) THEN
	IF Change THEN
		Change:=FALSE;
	ELSE
		Change:=TRUE;
	END_IF;
END_IF;

//设备未初始化复位标志位
IF NOT iHomeOK OR iManuCheck THEN
	Change:=FALSE;
END_IF;

//******************************真空报警******************************
IF oValve_Home AND iSensor_Work AND NOT ioVaccum.Parm.DisableWork THEN//电磁阀初始位动作，初始位感应器OFF;&初始位感应器未屏蔽
	Errror:=TRUE;
    ioVaccum.Status.ErrorID:=1;//破真空超时报警
	
ELSIF oValve_Work AND NOT iSensor_Work AND NOT ioVaccum.Parm.DisableWork THEN//电磁阀动作位动作，动作位感应器OFF;&动作位感应器未屏蔽
	Errror:=TRUE;
   ioVaccum.Status.ErrorID:=2;//吸真空超时报警
   	
ELSIF NOT ioVaccum.Parm.IC_Home AND (ioVaccum.Cmd.AutoToHome OR ioVaccum.Cmd.ManuToHome) THEN//初始位互锁条件未满足，手动或自动前往初始位
	ioVaccum.Status.Error:=TRUE;
	ioVaccum.Status.ErrorID:=5;//破真空互锁条件未满足报警
	
ELSIF NOT ioVaccum.Parm.IC_Work AND (ioVaccum.Cmd.AutoToWork OR ioVaccum.Cmd.ManuToWork) THEN//动作位互锁条件未满足，手动或自动前往动作位
	ioVaccum.Status.Error:=TRUE;
	ioVaccum.Status.ErrorID:=6;//吸真空互锁条件未满足报警
	
ELSIF iAuto AND Change THEN
	ioVaccum.Status.Error:=TRUE;
	ioVaccum.Status.ErrorID:=7;	//手动操作后真空状态未还原报警
	
ELSE
	Errror:=FALSE;
END_IF;

//1,2,3,4报警延时输出
TON_ErrorDelay(in:=Errror,PT:=UINT_TO_TIME(ioVaccum.Parm.Error_Delay*100));
IF TON_ErrorDelay.Q THEN
	ioVaccum.Status.Error:=TRUE;
END_IF;

//************************气缸动作时间分析************************
//开始条件：电磁阀上升沿信号触发
IF Valve_Work_F.Q OR Valve_Work_R.Q THEN
	Sp_Time:=TRUE;	//计时开始
	FOR i:=9 TO 1 BY -1 DO//循环数据位移，保存上次记录数据
	    ioVaccum.Status.Sp_Time[i]:=ioVaccum.Status.Sp_Time[i-1];
	END_FOR;
	ioVaccum.Status.Sp_Time[0]:=0;
END_IF;

//结束条件：前往初始位，初始位感应器ON；前往动作位，动作位感应器ON
IF (oValve_Home AND ioVaccum.Status.InHome) OR (oValve_Work AND ioVaccum.Status.InWork) THEN
  	Sp_Time:=FALSE;	//计时结束
END_IF;

//100MS脉冲上升沿增加100
IF Sp_Time AND iClock_100ms THEN
	ioVaccum.Status.Sp_Time[0]:=ioVaccum.Status.Sp_Time[0]+1;
END_IF;

//******************************使用寿命计数******************************
IF Valve_Work_F.Q OR Valve_Work_R.Q THEN
	ioVaccum.Status.Sp_Times:=ioVaccum.Status.Sp_Times+1;
END_IF;

//******************************报警计数******************************
Error_P(CLK:=ioVaccum.Status.Error);
IF Error_P.Q THEN
	ioVaccum.Status.Er_Times:=ioVaccum.Status.Er_Times+1;
END_IF;

//************************控制字自复位************************
ioVaccum.Cmd.AutoToHome:=FALSE;
ioVaccum.Cmd.AutoToWork:=FALSE;
ioVaccum.Cmd.ManuToHome:=FALSE;
ioVaccum.Cmd.ManuToWork:=FALSE;