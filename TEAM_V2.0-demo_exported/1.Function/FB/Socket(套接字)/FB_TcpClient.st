FUNCTION_BLOCK FB_TcpClient
VAR_IN_OUT
	ioTcpClient:Str_TcpClient;
END_VAR
VAR_OUTPUT
END_VAR
VAR
	i:UINT;//循环变量
	STR1:POINTER TO STRING(500);
	STR2:POINTER TO STRING(500);	
	LEN_Rcv:ULINT;
	RcvDat:ARRAY[0..500] OF BYTE;
	
END_VAR
VAR
	TCP_Client_instance: TCP_Client;
	TCP_Send_instance: TCP_Send;
	TCP_Receive_instance: TCP_Receive;
END_VAR




TCP_Client_instance(
	xEnable:= ioTcpClient.Enable, 
	strIpAddrDst:= ioTcpClient.DstAdr, 
	uiPortDst:= ioTcpClient.DstTcpPort, 
	udiTimeOut:= , 
	xNotKeepAlive:= , 
	xDone=> , 
	xBusy=> , 
	xError=> , 
	dwErrorID=> , 
	xActive=> ioTcpClient.Active, 
	hConnection=> );

TCP_Send_instance(
	xExecute:= ioTcpClient.Execute AND TCP_Client_instance.xActive, 
	hConnection:= TCP_Client_instance.hConnection, 
	uiSize:=ioTcpClient.SendSize, 
	pbyData:= ADR(ioTcpClient.SendDat), 
	udiTimeOut:= , 
	xDone=> , 
	xBusy=> , 
	xError=> , 
	dwErrorID=> );

TCP_Receive_instance(
	xEnable:= TCP_Client_instance.xActive AND NOT TCP_Receive_instance.xDone AND NOT TCP_Receive_instance.xError, 
	hConnection:= TCP_Client_instance.hConnection, 
	uiSize:= 500, 
	pbyData:= ADR(RcvDat), 
	xDone=> , 
	xBusy=> , 
	xError=> , 
	dwErrorID=> , 
	xReady=> , 
	uiCount=> LEN_Rcv);

//截取字符串长度
IF LEN_Rcv<> 0 THEN	
	FOR i:=0 TO 500 BY 1 DO
		ioTcpClient.RcvDat[i]:=0;
	END_FOR
	FOR i:=0 TO ULINT_TO_UINT(LEN_Rcv) BY 1 DO
		ioTcpClient.RcvDat[i]:=RcvDat[i];
	END_FOR
	ioTcpClient.RcvDone:=TRUE;	
	ioTcpClient.RcvSize:=ULINT_TO_UINT(LEN_Rcv);
ELSE
	ioTcpClient.RcvDone:=FALSE;
END_IF

//发送指令OFF
IF TCP_Send_instance.xDone OR TCP_Send_instance.xError OR NOT ioTcpClient.Enable THEN
	ioTcpClient.Execute:=FALSE;
END_IF


