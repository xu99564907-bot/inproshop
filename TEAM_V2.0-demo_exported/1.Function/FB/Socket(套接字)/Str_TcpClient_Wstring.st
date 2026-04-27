TYPE Str_TcpClient_Wstring :
STRUCT
	Enable:		BOOL;//使能
	Execute:	BOOL;//发送数据
	SrcTcpPort:	UINT;//本地端口号	
	DstAdr:		STRING[256];//远程IP地址	
	DstTcpPort:	UINT;//远程端口号	
	SendDat:	WSTRING(500);//发送数据内容	
	RcvDat:		WSTRING(500);//接收数据内容	
	Active:		BOOL;//	链接已建立	
	SendDone:	BOOL;//	发送数据完成	
	RcvDone:	BOOL;//	接收数据完成	
	Error:		BOOL;//	错误	
	ErrorID:	WORD;//	错误代码
END_STRUCT
END_TYPE
