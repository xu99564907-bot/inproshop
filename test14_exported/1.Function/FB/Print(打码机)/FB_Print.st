FUNCTION_BLOCK FB_Print
VAR_INPUT
	iMode:Str_Mode;//设备模式
	iDstAdr:STRING;//远程IP地址
	iDstTcpPort:UINT;//远程端口号
END_VAR
VAR_IN_OUT
	ioPrint:Str_Print;
END_VAR
VAR_OUTPUT
	oTimeOut:BOOL;//通讯连接超时
	oPtrintError:BOOL;//打印过程错误
END_VAR
VAR
	i:INT;//循环变量
	Step:INT;//打印步骤
	FB_TcpClient_String_Instance:FB_TcpClient_WString;
	TcpClient: Str_TcpClient_WString;
	TimeOutDelay: TON;
	EnableDelay: TON;
	StepDelay:ARRAY[0..9] OF TON;//步延时
	
	
END_VAR



//IP&端口号设定
TcpClient.DstAdr:=iDstAdr;//远程IP地址
TcpClient.DstTcpPort:=iDstTcpPort;//远程端口号

//触发打印开始
IF ioPrint.Cmd.Execute AND Step = 0 THEN
	STEP:=5;
	ioPrint.Status.Done:=FALSE;
END_IF

StepDelay[0](IN:= Step<>0, PT:= T#10S );	
StepDelay[3](IN:= Step=30, PT:= T#5S );	
StepDelay[5](IN:= Step=50, PT:= T#5S );	
StepDelay[6](IN:= Step=60, PT:= T#5S );	

CASE Step OF
	5://判定是否屏蔽
		IF ioPrint.Cmd.Disable THEN
			STEP:=10;
		ELSE
			STEP:=100;
		END_IF
	10 ://赋值打印内容
		TcpClient.SendDat:=ioPrint.Parm.Data;//赋值内容
		TcpClient.RcvDat:="";//清空返回数据
		FOR i:=0 TO 500 BY 1 DO
			SWAP(TcpClient.SendDat[i]);		
		END_FOR
		STEP:=20;
		
	20://触发发送
		IF NOT TcpClient.Execute THEN
			TcpClient.Execute:=TRUE;
			STEP:=30;
		END_IF
	
	30://等待返回正常结果
		IF TcpClient.RcvDat = ioPrint.Parm.Data THEN
			STEP:=40;
		ELSIF StepDelay[3].Q THEN 
			oPtrintError:=TRUE;
		END_IF
		
	40://触发打印
		TcpClient.SendDat:="<X>";//赋值内容
		TcpClient.RcvDat:="";//清空返回数据
		FOR i:=0 TO 500 BY 1 DO
			SWAP(TcpClient.SendDat[i]);		
		END_FOR
		STEP:=45;
	45://触发发送
		IF NOT TcpClient.Execute THEN
			TcpClient.Execute:=TRUE;
			STEP:=50;
		END_IF		
	50://等待返回打印中
		IF TcpClient.RcvDat = "<X>" OR TcpClient.RcvDat = "<XE>" THEN
			STEP:=60;
		ELSIF StepDelay[5].Q THEN 
			STEP:=40;
		END_IF	
	
	60://等待返回打印完成
		IF TcpClient.RcvDat = "<XE>" THEN
			STEP:=100;
		ELSIF StepDelay[6].Q THEN 
			oPtrintError:=TRUE;
		END_IF
		
	100://打印结束，输出Done
		ioPrint.Status.Done:=TRUE;
		STEP:=0;

END_CASE


//通讯实例化
FB_TcpClient_String_Instance(ioTcpClient:= TcpClient);
//反馈数据更新
IF TcpClient.RcvDone THEN
	ioPrint.Status.Done:=TRUE;
	FOR i:=0 TO 500 BY 1 DO
		SWAP(TcpClient.RcvDat[i]);		
	END_FOR
END_IF
//触发标志位自复位
ioPrint.Cmd.Execute:=FALSE;

(****************通讯异常复位******************)
TimeOutDelay(IN:= NOT TcpClient.Active AND TcpClient.Enable, PT:= T#2S);//通讯异常延时
EnableDelay(IN:= NOT TcpClient.Enable, PT:= T#1S);//延时复位通讯

IF iMode.Out.ErrorReset AND oTimeOut  THEN
	TcpClient.Enable:=FALSE;
ELSIF EnableDelay.Q THEN
	TcpClient.Enable:=TRUE;
END_IF

//状态映射
ioPrint.Status.Active:=TcpClient.Active;
//打印中
ioPrint.Status.Busy:=STEP<>0;

//超时复位
IF StepDelay[0].Q AND iMode.Out.ErrorReset THEN
	STEP:=0;
END_IF



//连接异常
IF TimeOutDelay.Q THEN
	oTimeOut:=TRUE;
ELSE
	oTimeOut:=FALSE;
END_IF;

