FUNCTION_BLOCK FB_ScrewFeeder
VAR_IN_OUT
	ioScewFeederCtrl:Str_Screw;
END_VAR

VAR_INPUT
	iName:WSTRING(40);//供钉机名称
	iMode:Str_Mode;//设备模式
	iSensor:BOOL;//落钉到位-上升沿信号
	iERROR:BOOL;//供钉机报警
	iReady:BOOL;//备钉完成信号
	iClear:BOOL;//钉排出信号
	iTimeOut:TIME;//超时时间设定
END_VAR

VAR_OUTPUT
	oStart:BOOL;//启动供钉
	oReset:BOOL;//报警复位
	oError:BOOL;//报警
	oErrorID:WORD;//报警代码
END_VAR

VAR
	i:INT;//循环数据用
	En_Control:BOOL;//出钉控制条件
	Start_R:R_TRIG;//启动上升沿检测防呆
	iSensor_R:R_TRIG;//落钉上升沿检测
	StartTimeOut:TON;//超时检测
	ReayDelay:TON;//备钉完成信号延时
END_VAR




(*版本V1:
	功能块建立
*)
//
En_Control:=NOT ioScewFeederCtrl.Status.Done AND (ioScewFeederCtrl.Status.Ready OR iMode.Out.HomeStart);
//控制
IF iMode.Status.AutoMode AND  En_Control  THEN
	oStart:=ioScewFeederCtrl.Cmd.AutoStart;
ELSIF iMode.Status.ManualMode AND En_Control  THEN
	oStart:=ioScewFeederCtrl.Cmd.ManuStart;
ELSE
	oStart:=FALSE;
END_IF


//备钉完成延时
ReayDelay(IN:= iReady, PT:= T#100MS, Q=> , ET=> );
ioScewFeederCtrl.Status.Ready:=ReayDelay.Q;

//落钉检测到位
iSensor_R(CLK:=iSensor);
IF iSensor_R.Q THEN
	ioScewFeederCtrl.Status.Done:=TRUE;;
ELSIF iClear THEN
	ioScewFeederCtrl.Status.Done:=FALSE;;
END_IF



//获取启动上升沿状态
Start_R(CLK:= ioScewFeederCtrl.Cmd.AutoStart OR ioScewFeederCtrl.Cmd.ManuStart );

//获取出钉时间
StartTimeOut(IN:= oStart, PT:= iTimeOut );


//报警
IF Start_R.Q AND ioScewFeederCtrl.Status.Done THEN
	oError:=TRUE;
	oErrorID:=1;//披头内有钉
	;
END_IF

IF Start_R.Q AND ioScewFeederCtrl.Status.Done THEN
	oError:=TRUE;
	oErrorID:=2;//备钉未完成
	;
END_IF

IF StartTimeOut.Q THEN
	oError:=TRUE;
	oErrorID:=3;//出钉超时
	;
END_IF

//报警复位
IF iMode.Out.ErrorReset THEN
	oError:=FALSE;
END_IF

//切换模式手动清除信号
IF iMode.Status.AutoMode THEN
	ioScewFeederCtrl.Cmd.ManuStart:=FALSE;
END_IF
//自复位自动控制信号
ioScewFeederCtrl.Cmd.AutoStart:=FALSE;
