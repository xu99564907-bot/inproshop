FUNCTION_BLOCK FB_Axis_V1_3
VAR_IN_OUT
	ioAxis:AXIS_REF_SM3;
	ioAxisCtrl:Str_Axis;
END_VAR

VAR_INPUT
	iName:WSTRING(40);//轴名称
	iEstop:BOOL;//急停
	iSafeDoor:BOOL;//安全门信号
	iLightCurtain:BOOL;//光栅信号
	iMode:Str_Mode;//设备模式
	iSpeed:REAL;//设备运行速率
	iIntermediateStop:BOOL;//轴暂停功能[=0暂停禁用，=1暂停启用
	iIC_Home:BOOL;//回原互锁条件
	iIC_ABS:BOOL;//定位互锁条件
	iIC_JOG:BOOL;//点动互锁条件
	iManuCheck:BOOL;//手自动切换检查状态=0检查，=1不检查
END_VAR

VAR
	i:INT;//循环数据用
	En_Control:BOOL;//轴控制条件
	Speed:REAL;//速率换算
	MC_Power_instance: MC_Power;
	MC_Reset_instance: MC_Reset;
	MC_Jog_instance: MC_Jog;
	MC_Home_instance: MC_Home;
	MC_MoveAbsolute_instance: MC_MoveAbsolute;
	MC_MoveRelative_instance: MC_MoveRelative;
	MC_MoveVelocity_instance: MC_MoveVelocity;
	MC_Stop_instance: MC_Stop;	
	SMC_SetControllerMode_instance: SMC_SetControllerMode;
	MC_TorqueControl_instance: MC_TorqueControl;
END_VAR

VAR
	ManuPoint_F:F_TRIG;//手动运动按钮下降沿
	VelocityControl_F:F_TRIG;//速度模式控制下降沿
	TorqueControl_F:F_TRIG;//扭矩模式控制下降沿
	
	Busy_R:R_TRIG;//获取状态上升沿
	Auto_R:R_TRIG;//自动模式上升沿
	Auto_F:F_TRIG;//自动模式下降沿
	TON_Sp_Time	:TON;//	动作计时
	LastPoint:ARRAY[0..50] OF BOOL;//停止点位记忆
	Remem_Manu:BOOL;//手动后状态记忆
	IntermediateStop:BOOL;//暂停动作控制
	CancelTraversing:BOOL;//取消动作控制
	PositionModeDelay:TON;//定位模式延时
	TorqueModeDelay:TON;//扭矩模式切换延时
	MoveControlTimeOut:TON;//定位后未移动超时
END_VAR



(*版本V1:
	功能块建立
*)


(*版本V1.1:
	增加互锁条件接口，互锁条件直接填到块输入引脚
*)

(*版本V1.2:
	停止功能做进功能块，优化引脚
*)

(*版本V1.3:
	1、增加扭矩控制模式-PDO报文需包含6071和607A
	2、优化暂停控制条件-解决暂停后直接初始化轴不动作问题
	3、优化停止功能块触发标志位复位条件-解决部分控制模式下报错功能块未在总线周期内调用
	4、点动模式增加手动条件限制-解决自动运转中触摸屏扔能操作点动问题(如需在自动模式下点动，用速度模式控制)
	5、绝对定位执行条件增加不在运转中、不在目标点位、在位置控制模式条件
	6、相对定位执行条件增加不在运转中、在位置控制模式条件
	7、优化功能块逻辑执行顺序
	8、其他细节优化
*)





//轴暂停
IF iMode.Status.AutoMode THEN
	IF iMode.Status.AutoRunning OR iMode.Out.HomeStart THEN
		IntermediateStop:=TRUE;
	END_IF
ELSE
	IntermediateStop:=TRUE;
END_IF

IF (iMode.Out.AutoRun_F OR NOT iSafeDoor OR NOT iLightCurtain) AND iIntermediateStop THEN
	IntermediateStop:=FALSE;
END_IF

//轴停止
CancelTraversing:=TRUE;
IF NOT iEstop OR ioAxisCtrl.Cmd.Stop OR iMode.Out.HomeOK_F OR (NOT iMode.Status.HomeOK AND iMode.Out.HomeStart_F)
	 THEN
	CancelTraversing:=FALSE;
END_IF

//互锁条件映射
ioAxisCtrl.Parm.IC_JOG:=iIC_JOG;
ioAxisCtrl.Parm.IC_Home:=iIC_Home;
ioAxisCtrl.Parm.IC_ABS:=iIC_ABS;
//轴名称
ioAxisCtrl.Parm.Comment:=iName;

(*********数据参数初始化**********)
FOR i:=0 TO 49 BY 1 DO
	//初始速度设定
	IF ioAxisCtrl.Parm._ABS[i].Velocity <= 0 THEN
		ioAxisCtrl.Parm._ABS[i].Velocity:=1000;
	END_IF
	//加减速设定
	ioAxisCtrl.Parm._ABS[i].Acc:=ioAxisCtrl.Parm._ABS[i].Velocity*10;
	ioAxisCtrl.Parm._ABS[i].Dec:=ioAxisCtrl.Parm._ABS[i].Velocity*10;

END_FOR
FOR i:=0 TO 10 BY 1 DO
	//加减速设定
	ioAxisCtrl.Parm._INC[i].Acc:=ioAxisCtrl.Parm._ABS[i].Velocity*10;
	ioAxisCtrl.Parm._INC[i].Dec:=ioAxisCtrl.Parm._ABS[i].Velocity*10;	

END_FOR
FOR i:=0 TO 10 BY 1 DO
	//相对运动速度设定
	IF ioAxisCtrl.Parm._INC[i].Velocity <= 0 THEN
		ioAxisCtrl.Parm._INC[i].Velocity:=1000;
	END_IF	
	IF ioAxisCtrl.Parm._Torque[i].Velocity <= 0 THEN
		ioAxisCtrl.Parm._Torque[i].Velocity:=500;
	END_IF		
END_FOR

//手动速度限制
IF ioAxisCtrl.Parm.ManuVelocity<=0 OR ioAxisCtrl.Parm.ManuVelocity>100 THEN
	ioAxisCtrl.Parm.ManuVelocity:=20;
END_IF	

//速率设定
IF iSpeed>0 THEN
	Speed:=iSpeed/100;
ELSE
	Speed:=0.1;
END_IF	


(*********轴运行条件**********)
En_Control:=iEstop AND IntermediateStop AND CancelTraversing AND ioAxisCtrl.Status.PowerON AND ioAxisCtrl.DevStatus.oPowerOn ;



(*********轴状态获取**********)
ioAxisCtrl.Status.ActPosition:=LREAL_TO_REAL(ioAxis.fActPosition);//实际位置
ioAxisCtrl.Status.ActVelocity:=LREAL_TO_REAL(ioAxis.fActVelocity);//实际速度
ioAxisCtrl.Status.ActTorque:=LREAL_TO_REAL(ioAxis.fActTorque);//实际扭矩
ioAxisCtrl.Status.Busy:=MC_Home_instance.Busy 
						OR MC_Jog_instance.Busy 
						OR MC_MoveAbsolute_instance.Busy 
						OR MC_MoveRelative_instance.Busy 
						OR MC_MoveVelocity_instance.Busy 
						OR MC_Stop_instance.Busy 
						OR MC_TorqueControl_instance.Busy;
ioAxisCtrl.Status.HmiPosition:=ioAxisCtrl.Parm._ABS[ioAxisCtrl.Cmd.PointSelect].Position;//触摸屏显示选择的绝对点位
ioAxisCtrl.Status.PosOK:=ioAxisCtrl.Status.State=3;//定位完成
//轴状态机映射
ioAxisCtrl.Status.State:=ioAxis.nAxisState;
//轴控制模式映射
ioAxisCtrl.Status.ActMode:=ioAxis.byControllerMode;
PositionModeDelay(IN:= ioAxisCtrl.Status.ActMode=3, PT:= T#100MS, Q=> , ET=> );
TorqueModeDelay(IN:= ioAxisCtrl.Status.ActMode=1, PT:= T#100MS, Q=> , ET=> );

//使能状态获取
IF MC_Power_instance.Status THEN
	ioAxisCtrl.Status.PowerON:=TRUE;
	ioAxisCtrl.DevStatus.oPowerOn:=TRUE;	
ELSE
	ioAxisCtrl.Status.PowerON:=FALSE;
	ioAxisCtrl.DevStatus.oPowerOn:=FALSE;		
END_IF



(*********轴使能**********)
//自动模式下，急停按钮正常使能ON
IF iMode.Status.AutoMode AND iEstop THEN
	ioAxisCtrl.Cmd.Power:=TRUE;
END_IF
//急停按钮按下，轴不在运转中使能OFF
IF NOT iEstop AND NOT ioAxisCtrl.Status.Busy THEN
	ioAxisCtrl.Cmd.Power:=FALSE;
END_IF

//使能功能块实例化
MC_Power_instance(
	Axis:= ioAxis, 
	Enable:= TRUE, 
	bRegulatorOn:= ioAxisCtrl.Cmd.Power, 
	bDriveStart:= TRUE, 
	Status=> , 
	bRegulatorRealState=> , 
	bDriveStartRealState=> , 
	Busy=> , 
	Error=> , 
	ErrorID=> );

(*********轴停止**********)
ManuPoint_F(CLK:=ioAxisCtrl.Cmd.ManuPosition);//获取手动触发定位下降沿
VelocityControl_F(CLK:= ioAxisCtrl.Cmd.VelocityControl);//获取速度模式触发定位下降沿
TorqueControl_F(CLK:= ioAxisCtrl.Cmd.Torque<>0);

IF ioAxisCtrl.Status.Busy AND ioAxisCtrl.Status.State > 3 
	AND( NOT CancelTraversing OR NOT IntermediateStop OR ManuPoint_F.Q OR VelocityControl_F.Q OR TorqueControl_F.Q OR NOT ioAxisCtrl.Cmd.Power)THEN
	MC_Stop_instance.Execute:=TRUE;
ELSIF MC_Stop_instance.Done OR MC_Stop_instance.Error THEN
	MC_Stop_instance.Execute:=FALSE;
END_IF;
//停止功能块实例化
MC_Stop_instance(
	Axis:= ioAxis, 
	Execute:= , 
	Deceleration:= ABS(ioAxisCtrl.Status.ActVelocity*10), 
	Jerk:= , 
	Done=> , 
	Busy=> , 
	Error=> , 
	ErrorID=> );


(*********轴复位**********)

MC_Reset_instance(
	Axis:= ioAxis, 
	Execute:= iMode.Out.ErrorReset, 
	Done=> , 
	Busy=> , 
	Error=> , 
	ErrorID=> );

//复位状态映射
ioAxisCtrl.DevStatus.oReset:=iMode.Out.ErrorReset;


(*********轴点动**********)
IF En_Control AND ioAxisCtrl.Parm.IC_JOG AND ioAxisCtrl.Status.ActMode = 3 THEN
	IF ioAxisCtrl.Cmd.ManuJogFoward THEN		
		MC_Jog_instance.JogForward:=TRUE;
		MC_Jog_instance.JogBackward:=FALSE;		
	ELSIF ioAxisCtrl.Cmd.ManuJogBackward THEN
		MC_Jog_instance.JogForward:=FALSE;
		MC_Jog_instance.JogBackward:=TRUE;
	ELSE
		MC_Jog_instance.JogForward:=FALSE;
		MC_Jog_instance.JogBackward:=FALSE;		
	END_IF
ELSE
	MC_Jog_instance.JogForward:=FALSE;
	MC_Jog_instance.JogBackward:=FALSE;
END_IF

//点动功能块实例化
MC_Jog_instance(
	Axis:= ioAxis, 
	JogForward:= , 
	JogBackward:= , 
	Velocity:= ioAxisCtrl.Parm.ManuVelocity, 
	Acceleration:= ioAxisCtrl.Parm.ManuVelocity*10, 
	Deceleration:= ioAxisCtrl.Parm.ManuVelocity*10, 
	Jerk:= , 
	Busy=> , 
	CommandAborted=> , 
	Error=> , 
	ErrorId=> );


(*********轴回原**********)
IF En_Control AND ioAxisCtrl.Parm.IC_Home AND ioAxisCtrl.Status.ActMode = 3 THEN
	IF iMode.Status.AutoMode AND ioAxisCtrl.Cmd.AutoToHome THEN
		MC_Home_instance.Execute:=TRUE;
	ELSIF NOT iMode.Status.AutoMode AND ioAxisCtrl.Cmd.ManuToHome THEN
		MC_Home_instance.Execute:=TRUE;
	ELSE
		MC_Home_instance.Execute:=FALSE;
	END_IF
ELSE
	MC_Home_instance.Execute:=FALSE;
END_IF;

//回原实例化
MC_Home_instance(
	Axis:= ioAxis, 
	Execute:= , 
	Position:= , 
	Done=> , 
	Busy=> , 
	CommandAborted=> , 
	Error=> , 
	ErrorID=> );

//回原完成状态
IF MC_Home_instance.Done THEN
	ioAxisCtrl.Status.Intialed:=TRUE;
END_IF


(*********轴绝对定位**********)
FOR i:=1 TO 49 BY 1 DO
	IF En_Control AND ioAxisCtrl.Parm.IC_ABS AND ioAxisCtrl.Status.Intialed AND NOT ioAxisCtrl.Status.Busy AND NOT ioAxisCtrl.Status.InPoint[i] AND ioAxisCtrl.Status.ActMode = 3 THEN
		IF iMode.Status.AutoMode AND ioAxisCtrl.Cmd.AutoABS=i THEN
			MC_MoveAbsolute_instance.Position:=ioAxisCtrl.Parm._ABS[i].Position;
			MC_MoveAbsolute_instance.Velocity:=ioAxisCtrl.Parm._ABS[i].Velocity*Speed;
			MC_MoveAbsolute_instance.Acceleration:=ioAxisCtrl.Parm._ABS[i].Acc*Speed;
			MC_MoveAbsolute_instance.Deceleration:=ioAxisCtrl.Parm._ABS[i].Dec*Speed;
			MC_MoveAbsolute_instance.Execute:=TRUE;
			EXIT;
		ELSIF NOT iMode.Status.AutoMode AND ioAxisCtrl.Cmd.PointSelect=i AND ioAxisCtrl.Cmd.ManuPoint THEN
			MC_MoveAbsolute_instance.Position:=ioAxisCtrl.Parm._ABS[i].Position;
			MC_MoveAbsolute_instance.Velocity:=ioAxisCtrl.Parm.ManuVelocity;
			MC_MoveAbsolute_instance.Acceleration:=ioAxisCtrl.Parm._ABS[i].Acc;
			MC_MoveAbsolute_instance.Deceleration:=ioAxisCtrl.Parm._ABS[i].Dec;
			MC_MoveAbsolute_instance.Execute:=TRUE;
			EXIT;
		ELSIF NOT iMode.Status.AutoMode AND ioAxisCtrl.Cmd.ManuPosition THEN
			MC_MoveAbsolute_instance.Position:=ioAxisCtrl.Parm.ManuPosition;
			MC_MoveAbsolute_instance.Velocity:=ioAxisCtrl.Parm.ManuVelocity;
			MC_MoveAbsolute_instance.Acceleration:=ioAxisCtrl.Parm.ManuVelocity*10;
			MC_MoveAbsolute_instance.Deceleration:=ioAxisCtrl.Parm.ManuVelocity*10;
			MC_MoveAbsolute_instance.Execute:=TRUE;
			EXIT;
		ELSE
			MC_MoveAbsolute_instance.Execute:=FALSE;
		END_IF
	ELSE
		MC_MoveAbsolute_instance.Execute:=FALSE;
	END_IF
END_FOR


//绝对定位功能块实例化
MC_MoveAbsolute_instance(
	Axis:= ioAxis, 
	Execute:= , 
	Position:= , 
	Velocity:= , 
	Acceleration:= , 
	Deceleration:= , 
	Jerk:= , 
	Direction:= , 
	BufferMode:= , 
	Done=> , 
	Busy=> , 
	Active=> , 
	CommandAborted=> , 
	Error=> , 
	ErrorID=> );

(*********轴相对定位**********)
FOR i:=1 TO 10 BY 1 DO
	IF En_Control AND ioAxisCtrl.Parm.IC_ABS AND NOT ioAxisCtrl.Status.Busy AND ioAxisCtrl.Status.ActMode = 3 THEN
		IF iMode.Status.AutoMode AND ioAxisCtrl.Cmd.AutoINC=i THEN
			MC_MoveRelative_instance.Distance:=ioAxisCtrl.Parm._INC[i].Position;
			MC_MoveRelative_instance.Velocity:=ioAxisCtrl.Parm._INC[i].Velocity*Speed;
			MC_MoveRelative_instance.Acceleration:=ioAxisCtrl.Parm._INC[i].Acc*Speed;
			MC_MoveRelative_instance.Deceleration:=ioAxisCtrl.Parm._INC[i].Dec*Speed;
			MC_MoveRelative_instance.Execute:=TRUE;
			EXIT;
		ELSE
			MC_MoveRelative_instance.Execute:=FALSE;
		END_IF
	ELSE
		MC_MoveRelative_instance.Execute:=FALSE;
	END_IF
END_FOR

//相对定位功能块实例化
MC_MoveRelative_instance(
	Axis:= ioAxis, 
	Execute:= , 
	Distance:= , 
	Velocity:= , 
	Acceleration:= , 
	Deceleration:= , 
	Jerk:= , 
	BufferMode:= , 
	Done=> , 
	Busy=> , 
	Active=> , 
	CommandAborted=> , 
	Error=> , 
	ErrorID=> );

(*********速度模式**********)
IF En_Control AND ioAxisCtrl.Parm.IC_ABS AND ioAxisCtrl.Status.ActMode = 3 THEN
	IF iMode.Status.AutoMode AND ioAxisCtrl.Cmd.VelocityControl AND NOT ioAxisCtrl.Cmd.VelocityChange THEN
		IF ioAxisCtrl.Parm.VelModeVelocity>0 THEN
			MC_MoveVelocity_instance.Velocity:=ioAxisCtrl.Parm.VelModeVelocity*Speed;
			MC_MoveVelocity_instance.Acceleration:=ioAxisCtrl.Parm.VelModeVelocity*10;
			MC_MoveVelocity_instance.Deceleration:=ioAxisCtrl.Parm.VelModeVelocity*10;
			MC_MoveVelocity_instance.Direction:=positive;//正向
		ELSE
			MC_MoveVelocity_instance.Velocity:=ioAxisCtrl.Parm.VelModeVelocity*-1*Speed;
			MC_MoveVelocity_instance.Acceleration:=ioAxisCtrl.Parm.VelModeVelocity*-10;
			MC_MoveVelocity_instance.Deceleration:=ioAxisCtrl.Parm.VelModeVelocity*-10;
			MC_MoveVelocity_instance.Direction:=negative;//反向
		END_IF
		MC_MoveVelocity_instance.Execute:=TRUE;
	ELSE
		MC_MoveVelocity_instance.Execute:=FALSE;
	END_IF
ELSE
	MC_MoveVelocity_instance.Execute:=FALSE;
END_IF

//速度模式定位功能块实例化
MC_MoveVelocity_instance(
	Axis:= ioAxis, 
	Execute:= , 
	Velocity:= , 
	Acceleration:= , 
	Deceleration:= , 
	Jerk:= , 
	Direction:= , 
	BufferMode:= , 
	InVelocity=> , 
	Busy=> , 
	Active=> , 
	CommandAborted=> , 
	Error=> , 
	ErrorID=> );


//扭矩控制
FOR i:=1 TO 10 BY 1 DO
	IF En_Control AND ioAxisCtrl.Parm.IC_ABS  AND TorqueModeDelay.Q THEN
		IF  ioAxisCtrl.Cmd.Torque=i THEN
			MC_TorqueControl_instance.Torque:=ioAxisCtrl.Parm._Torque[i].Torque;
			MC_TorqueControl_instance.Velocity:=ioAxisCtrl.Parm._Torque[i].Velocity;
			MC_TorqueControl_instance.Execute:=TRUE;
			EXIT;
		ELSE
			MC_TorqueControl_instance.Execute:=FALSE;
		END_IF
	ELSE
		MC_TorqueControl_instance.Execute:=FALSE;
	END_IF
END_FOR

//扭矩控制模式功能块实例化
MC_TorqueControl_instance(
	Axis:= ioAxis, 
	Execute:= , 
	Torque:= , 
	TorqueRamp:=ABS( MC_TorqueControl_instance.Torque), 
	Velocity:= , 
	InTorque=> , 
	Busy=> , 
	CommandAborted=> , 
	Error=> , 
	ErrorID=> );












//轴控制模式切换
IF En_Control THEN
	IF ioAxisCtrl.Cmd.Torque<>0 AND ioAxisCtrl.Status.ActMode<>1 THEN
		SMC_SetControllerMode_instance.bExecute:=TRUE;
		SMC_SetControllerMode_instance.nControllerMode:=SMC_torque;
	ELSIF  (ioAxisCtrl.Cmd.AutoABS<>0 OR  ioAxisCtrl.Cmd.AutoToHome OR  ioAxisCtrl.Cmd.AutoINC<>0 OR  ioAxisCtrl.Cmd.ManuJogBackward 
			OR  ioAxisCtrl.Cmd.ManuJogFoward OR  ioAxisCtrl.Cmd.ManuPosition OR  ioAxisCtrl.Cmd.ManuPoint OR  ioAxisCtrl.Cmd.ManuToHome)
			 AND ioAxisCtrl.Status.ActMode<>3 THEN
		SMC_SetControllerMode_instance.bExecute:=TRUE;
		SMC_SetControllerMode_instance.nControllerMode:=SMC_position;
  	ELSE
 		SMC_SetControllerMode_instance.bExecute:=FALSE;
 	END_IF
 ELSE
 	SMC_SetControllerMode_instance.bExecute:=FALSE;
END_IF
//轴控制模式切换实例化
SMC_SetControllerMode_instance(
	Axis:= ioAxis, 
	bExecute:= , 
	nControllerMode:= , 
	bDone=> , 
	bBusy=> , 
	bError=> , 
	nErrorID=> );





//动作时间
TON_Sp_Time(IN:= ioAxisCtrl.Status.Busy, PT:= T#99S, Q=> , ET=> );
IF ioAxisCtrl.Status.Busy THEN
	ioAxisCtrl.Status.SpTime:=TIME_TO_UINT(TON_Sp_Time.ET);
END_IF

//定位达到信号判定
FOR i:=0 TO 49 BY 1 DO
	IF ABS(ioAxisCtrl.Status.ActPosition-ioAxisCtrl.Parm._ABS[i].Position)<=0.1 AND NOT ioAxisCtrl.Status.Busy AND ioAxisCtrl.Status.Intialed THEN
		ioAxisCtrl.Status.InPoint[i]:=TRUE;
	ELSE
		ioAxisCtrl.Status.InPoint[i]:=FALSE;
	END_IF
END_FOR

//扭力到达
FOR i:=0 TO 10 BY 1 DO
	IF ABS(ioAxisCtrl.Status.ActTorque-ioAxisCtrl.Parm._Torque[i].Torque) <=2 AND ABS(ioAxisCtrl.Status.ActVelocity) <= 1 THEN
		ioAxisCtrl.Status.InTorque[i]:=TRUE;
	ELSE
		ioAxisCtrl.Status.InTorque[i]:=FALSE;
	END_IF
END_FOR




(*********点位示教**********)
IF ioAxisCtrl.Cmd.TeachOn AND ioAxisCtrl.Cmd.Teach THEN
	ioAxisCtrl.Parm._ABS[ioAxisCtrl.Cmd.PointSelect].Position:=ioAxisCtrl.Status.ActPosition;
	ioAxisCtrl.Cmd.Teach:=FALSE;
END_IF



(***************手自动切换*************)
//停止位置获取
Busy_R(CLK:=NOT ioAxisCtrl.Status.Busy AND NOT iMode.Status.AutoMode);
IF Busy_R.Q AND NOT Remem_Manu THEN
	ioAxisCtrl.Status.StopPositon:=ioAxisCtrl.Status.ActPosition;
	LastPoint:=ioAxisCtrl.Status.InPoint;
	Remem_Manu:=TRUE;
END_IF

//手自动切换后状态判定
IF iMode.Status.AutoMode AND Remem_Manu THEN
	FOR i:=0 TO 49 BY 1 DO	
		IF NOT iMode.Status.HomeOK OR iManuCheck OR (LastPoint[i] AND ioAxisCtrl.Status.InPoint[i]) OR ABS(ioAxisCtrl.Status.StopPositon-ioAxisCtrl.Status.ActPosition)<0.1 THEN
			Remem_Manu:=FALSE;
			EXIT;
		END_IF
	END_FOR
END_IF


//触发定位，实际未动作计时
MoveControlTimeOut(IN:= NOT ioAxisCtrl.Status.Busy AND (ioAxisCtrl.Cmd.AutoABS<>0 OR ioAxisCtrl.Cmd.AutoINC<>0 OR ioAxisCtrl.Cmd.AutoToHome<>0), PT:= T#30S, Q=> , ET=> );


(*报警汇总*)
IF ioAxis.nAxisState = 1 THEN
	ioAxisCtrl.Status.Error:=TRUE;
	ioAxisCtrl.Status.ErrorID:=DWORD_TO_WORD( ioAxis.dwErrorID);
ELSIF (ioAxisCtrl.Cmd.AutoToHome OR ioAxisCtrl.Cmd.ManuToHome) AND NOT ioAxisCtrl.Parm.IC_Home THEN
	ioAxisCtrl.Status.Error:=TRUE;
	ioAxisCtrl.Status.ErrorID:=1;//回原互锁报警
ELSIF (ioAxisCtrl.Cmd.ManuJogBackward OR ioAxisCtrl.Cmd.ManuJogFoward) AND NOT ioAxisCtrl.Parm.IC_JOG THEN
	ioAxisCtrl.Status.Error:=TRUE;
	ioAxisCtrl.Status.ErrorID:=2;//点动互锁报警
ELSIF ioAxisCtrl.Cmd.AutoINC<>0 AND NOT ioAxisCtrl.Parm.IC_ABS THEN
	ioAxisCtrl.Status.Error:=TRUE;
	ioAxisCtrl.Status.ErrorID:=3;//相对运动互锁报警
ELSIF ioAxisCtrl.Cmd.AutoABS<>0 AND NOT ioAxisCtrl.Parm.IC_ABS THEN
	ioAxisCtrl.Status.Error:=TRUE;
	ioAxisCtrl.Status.ErrorID:=4;//绝对运动互锁报警	
ELSIF ioAxisCtrl.Cmd.VelocityControl AND NOT ioAxisCtrl.Parm.IC_ABS THEN
	ioAxisCtrl.Status.Error:=TRUE;
	ioAxisCtrl.Status.ErrorID:=5;//速度模式运动互锁报警		
ELSIF MoveControlTimeOut.Q THEN
	ioAxisCtrl.Status.Error:=TRUE;
	ioAxisCtrl.Status.ErrorID:=6;//定位超时
ELSIF iMode.Status.AutoMode AND Remem_Manu THEN
	ioAxisCtrl.Status.Error:=TRUE;
	ioAxisCtrl.Status.ErrorID:=7;//切换手动后未恢复原位置
ELSIF iMode.Out.ErrorReset THEN
	ioAxisCtrl.Status.Error:=FALSE;
	ioAxisCtrl.Status.ErrorID:=0;
END_IF


//控制字清零
ioAxisCtrl.Cmd.AutoABS:=0;
ioAxisCtrl.Cmd.AutoINC:=0;
ioAxisCtrl.Cmd.AutoToHome:=FALSE;
ioAxisCtrl.Cmd.ManuToHome:=FALSE;
ioAxisCtrl.Cmd.ManuPoint:=FALSE;
ioAxisCtrl.Cmd.VelocityControl:=FALSE;
ioAxisCtrl.Cmd.VelocityChange:=FALSE;
ioAxisCtrl.Cmd.Torque:=0;
ioAxisCtrl.Cmd.Stop:=FALSE;
IF iMode.Status.AutoMode  THEN
	ioAxisCtrl.Cmd.TeachOn:=FALSE;
END_IF

