FUNCTION_BLOCK FB_Stopper_V1
VAR_INPUT
	iAuto:BOOL;//自动模式
	iReset:BOOL;//报警复位
	iSensor1:BOOL;//到位检测(靠近挡停感应器)
	iSensor2:BOOL;//到位检测(末尾治具检测感应器)
	iCylFor:BOOL;//挡停气缸伸出感应器，无感应器=1
	iCylBack:BOOL;//挡停气缸缩回感应器，无感应器=1
	iMotor:BOOL;//流线电机运转中信号
	iBuffer:BOOL;//=1缓存工位挡停，不需要流程控制
	iStationHome:BOOL;//当前挡停工位在原位
	iTimes:INT;//流出治具设定数量
	iMode:INT;//放行模式[=0:放行完成结束流程;=1:等待治具流出到下一工位，结束流程;
	iEachTimes:INT;//每次放行治具数量[=0:一次放行完成；=1:放行一次抬起挡停，防止治具多放或者少放
	iGoInOutTogether:INT;//[=0无治具允许上站放行，=1同进同出
	iTimeDelay:TIME;//治具流出延时
END_VAR
VAR_OUTPUT
	oCylFor:BOOL;//挡停气缸伸出电磁阀
	oCylBack:BOOL;//挡停气缸缩回电磁阀
	oTimeOut:BOOL;//治具流出超时异常
END_VAR
VAR_IN_OUT
	ioCurStaData:Str_Stopper;//当前工位挡停
	ioNextStaData:Str_Stopper;//下工位挡停
END_VAR
VAR
	Step:INT;//控制流程步
	Times:INT;//已流出治具个数
	OutTimeDelay:TON;//治具流出延时
	Sensor_F:F_TRIG;//感应器下降沿
	Auto_R:R_TRIG;//自动模式上升沿
END_VAR

//输入输出状态映射
ioCurStaData.DevStatus.Sensor1:=iSensor1;
ioCurStaData.DevStatus.Sensor2:=iSensor2;
ioCurStaData.DevStatus.CylFor_Sensor:=iCylFor;
ioCurStaData.DevStatus.CylBack_Sensor:=iCylBack;
ioCurStaData.DevStatus.CylFor_Valve:=oCylFor;
ioCurStaData.DevStatus.CylBack_Valve:=oCylBack;

(*********************************************************************)
//状态获取
ioCurStaData.Status.PalletArrivalSensor:=iSensor1 AND iSensor2;//托盘位置到达
//放行脉冲信号复位
ioCurStaData.Status.FeedOutPls:=FALSE;
//治具流出延时
OutTimeDelay(IN:= NOT iSensor1, PT:= iTimeDelay);
//治具流出计数
Sensor_F(CLK:= iSensor1, Q=> );
IF Sensor_F.Q AND oCylBack THEN//挡停在下降位置，感应器下降沿计数
	Times:=Times+1;
END_IF

//动作流程
CASE Step OF
	0 :
		ioCurStaData.Status.Comment:="等待治具放行";
		Times:=0;
		IF (ioCurStaData.Cmd.ReleasePallet_Back OR iBuffer) AND ioCurStaData.Status.OKToFeedOut AND
			ioNextStaData.Status.OKToFeedIn AND iMotor THEN			
			Step:=10;
			ioCurStaData.Status.Busy:=TRUE;
		END_IF
	10:
		ioCurStaData.Status.Comment:="治具放行开始";
		oCylBack:=TRUE;
		Step:=20;
	20:
		ioCurStaData.Status.Comment:="判定放行模式";
		IF iEachTimes=0 THEN
			Step:=50;
		ELSIF iEachTimes=1 THEN
			Step:=30;
		END_IF
		
	30:
		ioCurStaData.Status.Comment:="等待治具流出感应器OFF";
		IF OutTimeDelay.Q THEN
			oCylBack:=FALSE;
			Step:=40;
		END_IF
	40:
		ioCurStaData.Status.Comment:="等待治具流出感应器ON或者放行次数到达";
		IF iSensor1 THEN
			Step:=10;
		END_IF
		IF Times>=iTimes THEN
			Step:=50;
		END_IF
	50:		
		ioCurStaData.Status.Comment:="等待放行次数到达";
		IF Times>=iTimes AND OutTimeDelay.Q THEN
			ioCurStaData.Status.FeedOutPls:=TRUE;
			oCylBack:=FALSE;
			Step:=100;
		END_IF
	100:
		ioCurStaData.Status.Comment:="等待治具到达下一工位";
		IF iMode=0 OR (iMode=1 AND ioNextStaData.Status.PalletArrivalSensor) THEN
			ioCurStaData.Status.Busy:=FALSE;
			Step:=0;
		END_IF

END_CASE

//允许上一站放行信号
IF iStationHome AND oCylFor AND NOT iSensor1 AND NOT ioCurStaData.Status.Busy THEN//无治具&工站在原为&挡停伸出&不在运转中
	ioCurStaData.Status.OKToFeedIn:=TRUE;
ELSIF iGoInOutTogether=1 AND ioCurStaData.Status.Busy THEN//同进同出
	ioCurStaData.Status.OKToFeedIn:=TRUE;
ELSE
	ioCurStaData.Status.OKToFeedIn:=FALSE;
END_IF

//本站允许出信号
ioCurStaData.Status.OKToFeedOut:=iSensor1 AND iSensor2;

//挡停块状态复位
IF ioCurStaData.Cmd.Reset THEN
	Times:=0;
	Step:=0;
	oCylBack:=FALSE;
	ioCurStaData.Status.Busy:=FALSE;
	oTimeOut:=FALSE;
END_IF

Auto_R(CLK:= iAuto);

//手动模式挡停气缸控制
IF NOT iAuto THEN
	IF ioCurStaData.Cmd.StopCylinder_Back THEN
		oCylBack:=TRUE;
	ELSIF ioCurStaData.Cmd.StopCylinder_For THEN
		oCylBack:=FALSE;
	END_IF;
ELSIF Auto_R.Q THEN
	oCylBack:=FALSE;
END_IF

//挡停电磁阀控制
oCylFor:=NOT oCylBack;

//控制放行标志位OFF
ioCurStaData.Cmd.ReleasePallet_Back:=FALSE;
ioCurStaData.Cmd.StopCylinder_Back:=FALSE;
ioCurStaData.Cmd.StopCylinder_For:=FALSE;
