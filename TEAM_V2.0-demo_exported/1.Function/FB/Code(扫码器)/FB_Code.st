FUNCTION_BLOCK FB_Code
VAR_INPUT
	iMode:Str_Mode;//设备模式
	iDstAdr:STRING;//远程IP地址
	iDstTcpPort:UINT;//远程端口号
	iSendData:STRING;//发送内容
END_VAR
VAR_IN_OUT
	ioCode:Str_Code;
END_VAR
VAR_OUTPUT
	oTimeOut:BOOL;//通讯连接超时
END_VAR
VAR
	i:INT;//循环变量
	FB_TcpClient_String_Instance:FB_TcpClient_String;
	TcpClient: Str_TcpClient_String;
	TimeOutDelay: TON;
	EnableDelay: TON;
END_VAR


//发送内容
TcpClient.SendDat:=CONCAT(iSendData,'$R$N');

//IP&端口号设定
TcpClient.DstAdr:=iDstAdr;//远程IP地址
TcpClient.DstTcpPort:=iDstTcpPort;//远程端口号
//发送内容
IF ioCode.Cmd.Execute THEN
	TcpClient.Execute:=TRUE;
	ioCode.Status.Done:=FALSE;
	ClearString(ioCode.Status.Result);
END_IF
//通讯实例化
FB_TcpClient_String_Instance(ioTcpClient:= TcpClient);
//反馈数据更新
IF TcpClient.RcvDone THEN
	ioCode.Status.Done:=TRUE;
	ioCode.Status.Result:=TcpClient.RcvDat;
END_IF
//触发标志位自复位
ioCode.Cmd.Execute:=FALSE;

(****************通讯异常复位******************)
TimeOutDelay(IN:= NOT TcpClient.Active AND TcpClient.Enable, PT:= T#2S);//通讯异常延时
EnableDelay(IN:= NOT TcpClient.Enable, PT:= T#1S);//延时复位通讯

IF iMode.Out.ErrorReset AND oTimeOut  THEN
	TcpClient.Enable:=FALSE;
ELSIF EnableDelay.Q THEN
	TcpClient.Enable:=TRUE;
END_IF

//状态映射
ioCode.Status.Active:=TcpClient.Active;


//连接异常
IF TimeOutDelay.Q THEN
	oTimeOut:=TRUE;
ELSE
	oTimeOut:=FALSE;
END_IF;

