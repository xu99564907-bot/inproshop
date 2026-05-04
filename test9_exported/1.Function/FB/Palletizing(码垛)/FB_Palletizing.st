FUNCTION_BLOCK FB_Palletizing
VAR_INPUT
	iClock:Str_Clock;//计时脉冲
	iMode:Str_Mode;//设备模式
	iEstop:BOOL;//紧急停止
	iLightCurtain:BOOL;//安全光栅
	iSensor:BOOL;//托盘到位检测传感器
	iRequestButton:BOOL;//请求进入按钮
	iFinishButton:BOOL;//完成按钮
	iRobotInStep:BOOL;//机械手在取放流程
END_VAR

VAR_OUTPUT
	oRequestButtonLamp:BOOL;//请求进入按钮指示灯
	oFinishButtonLamp:BOOL;//完成按钮指示灯
END_VAR

VAR_IN_OUT
	ioPalletizing:Str_Palletizing;
END_VAR

VAR
	LeaveRequest:BOOL;
END_VAR

//计数
IF ioPalletizing.Cmd.Excute THEN
	ioPalletizing.Cmd.Excute:=FALSE;
	ioPalletizing.Status.PerLayersNum:=ioPalletizing.Status.PerLayersNum+ioPalletizing.Parm.ExcuteNum;
	IF ioPalletizing.Status.PerLayersNum>=ioPalletizing.Parm.PerLayersSetNum THEN
		ioPalletizing.Status.LayersNum:=ioPalletizing.Status.LayersNum+1;
		ioPalletizing.Status.PerLayersNum:=0;
	END_IF
END_IF

//满料状态输出
IF ioPalletizing.Status.LayersNum>ioPalletizing.Parm.LayersSetNum THEN
	ioPalletizing.Status.State := 2;	
END_IF

//请求上下托盘

//无托盘请求进入
IF ioPalletizing.Status.State = 0 AND iRequestButton THEN
	ioPalletizing.Status.State:= 3;
END_IF
//放托盘完成
IF ioPalletizing.Status.State= 3 AND iFinishButton THEN
	IF iSensor THEN
		ioPalletizing.Status.State:=1;
		ioPalletizing.Status.LayersNum:=1;
		ioPalletizing.Status.PerLayersNum:=0;
	ELSE
		ioPalletizing.Status.Error:=TRUE;
		ioPalletizing.Status.ErrorID:=1;;//托盘未放置到位
	END_IF	
END_IF

//有托盘请求离开
IF (ioPalletizing.Status.State = 1 OR ioPalletizing.Status.State = 2) AND iRequestButton THEN
	LeaveRequest:=TRUE;
END_IF

//等待机械手不在取放流程
IF LeaveRequest AND NOT iRobotInStep THEN
	ioPalletizing.Status.State:= 4;
	LeaveRequest:=FALSE;
END_IF

//放托盘完成
IF ioPalletizing.Status.State= 4 AND iFinishButton THEN
	IF NOT iSensor THEN
		ioPalletizing.Status.State:=0;
		ioPalletizing.Status.LayersNum:=0;
		ioPalletizing.Status.PerLayersNum:=0;
	ELSE
		ioPalletizing.Status.Error:=TRUE;
		ioPalletizing.Status.ErrorID:=2;//托盘未取走
	END_IF	
END_IF


//指示灯输出
oRequestButtonLamp:=FALSE;
oFinishButtonLamp:=FALSE;
CASE ioPalletizing.Status.State OF
	1:
		oRequestButtonLamp:=TRUE;
	2:
		oFinishButtonLamp:=TRUE;
	3:
		oRequestButtonLamp:= iClock.Clock_1s;
	4:
		oRequestButtonLamp:= iClock.Clock_1s;
ELSE
	;
END_CASE

//报警复位
IF iMode.Out.ErrorReset THEN
	ioPalletizing.Status.Error:=FALSE;
	ioPalletizing.Status.ErrorID:=0;
END_IF


//光栅遮挡异常
IF ioPalletizing.Status.State < 3 AND NOT iLightCurtain THEN
	ioPalletizing.Status.Error:=TRUE;
	ioPalletizing.Status.ErrorID:=1;
END_IF




