FUNCTION_BLOCK FB_AAS
VAR_INPUT
	iMode:Str_Mode;//设备模式
	iCameraNum:INT;//相机触发通道数量<20
	iDstAdr:STRING;//远程IP地址
	iDstTcpPort:UINT;//远程端口号
	iRecipeNum:STRING;//配方名称
END_VAR
VAR_IN_OUT
	ioAAS:Str_AAS;
END_VAR
VAR_OUTPUT
	oTimeOut:BOOL;//通讯连接超时
END_VAR
VAR
	i:INT;//循环变量
	FB_TcpClient_String_Instance:ARRAY[0..20]OF FB_TcpClient_String;
	TcpClient:ARRAY[0..20]OF Str_TcpClient_String;
	TimeOutDelay:ARRAY[0..20]OF TON;
	EnableDelay:ARRAY[0..20]OF TON;
END_VAR

//通道0，调用AAS配方号
//通道1-20，触发拍照检测

//发送内容
TcpClient[0].SendDat:=CONCAT(iRecipeNum,'$R$N');
TcpClient[1].SendDat:='Camera1$R$N';
TcpClient[2].SendDat:='Camera2$R$N';
TcpClient[3].SendDat:='Camera3$R$N';
TcpClient[4].SendDat:='Camera4$R$N';
TcpClient[5].SendDat:='Camera5$R$N';
TcpClient[6].SendDat:='Camera6$R$N';
TcpClient[7].SendDat:='Camera7$R$N';
TcpClient[8].SendDat:='Camera8$R$N';
TcpClient[9].SendDat:='Camera9$R$N';
TcpClient[10].SendDat:='Camera110$R$N';
TcpClient[11].SendDat:='Camera11$R$N';
TcpClient[12].SendDat:='Camera12$R$N';
TcpClient[13].SendDat:='Camera13$R$N';
TcpClient[14].SendDat:='Camera14$R$N';
TcpClient[15].SendDat:='Camera15$R$N';
TcpClient[16].SendDat:='Camera16$R$N';
TcpClient[17].SendDat:='Camera17$R$N';
TcpClient[18].SendDat:='Camera18$R$N';
TcpClient[19].SendDat:='Camera19$R$N';
TcpClient[20].SendDat:='Camera20$R$N';

FOR i:=0 TO iCameraNum BY 1 DO
	//IP&端口号设定
	TcpClient[i].DstAdr:=iDstAdr;//远程IP地址
	TcpClient[i].DstTcpPort:=iDstTcpPort;//远程端口号
	//发送内容
	IF ioAAS.Cmd.Execute[i] THEN
		TcpClient[i].Execute:=TRUE;
		ioAAS.Status.Result:='';
	END_IF
	//通讯实例化
	FB_TcpClient_String_Instance[i](ioTcpClient:= TcpClient[i]);
	//反馈数据更新
	IF TcpClient[i].RcvDone THEN
		ioAAS.Status.Result:=TcpClient[i].RcvDat;
	END_IF
	//触发标志位自复位
	ioAAS.Cmd.Execute[i]:=FALSE;
	
	(****************通讯异常复位******************)
	TimeOutDelay[i](IN:= NOT TcpClient[I].Active AND TcpClient[i].Enable, PT:= T#2S);//通讯异常延时
	EnableDelay[I](IN:= NOT TcpClient[i].Enable, PT:= T#1S);//延时复位通讯
	
	IF iMode.Out.ErrorReset AND oTimeOut  THEN
		TcpClient[i].Enable:=FALSE;
	ELSIF EnableDelay[i].Q THEN
		TcpClient[i].Enable:=TRUE;
	END_IF
END_FOR

//连接异常
FOR i:=0 TO iCameraNum BY 1 DO
	IF TimeOutDelay[i].Q THEN
		oTimeOut:=TRUE;
		EXIT;
	ELSE
		oTimeOut:=FALSE;
	END_IF;
END_FOR
