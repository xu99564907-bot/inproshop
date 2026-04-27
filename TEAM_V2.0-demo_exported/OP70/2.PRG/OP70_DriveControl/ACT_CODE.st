


//扫码器1
FB_Code_Instance[1](
	iMode:=DB7000_Control.Mode,
	iDstAdr:= '192.168.7.22', 
	iDstTcpPort:= 2000, 
	iSendData:= 'READ', 
	ioCode:= CodeCtrl[1], 
	oTimeOut=> );


//扫码器2
FB_Code_Instance[2](
	iMode:=DB7000_Control.Mode,
	iDstAdr:= '192.168.7.23', 
	iDstTcpPort:= 2000, 
	iSendData:= 'READ', 
	ioCode:= CodeCtrl[2], 
	oTimeOut=> );

//扫码器3
FB_Code_Instance[3](
	iMode:=DB7000_Control.Mode,
	iDstAdr:= '192.168.7.24', 
	iDstTcpPort:= 2000, 
	iSendData:= 'READ', 
	ioCode:= CodeCtrl[3], 
	oTimeOut=> );


//扫码器4
FB_Code_Instance[4](
	iMode:=DB7000_Control.Mode,
	iDstAdr:= '192.168.7.25', 
	iDstTcpPort:= 2000, 
	iSendData:= 'READ', 
	ioCode:= CodeCtrl[4], 
	oTimeOut=> );



















