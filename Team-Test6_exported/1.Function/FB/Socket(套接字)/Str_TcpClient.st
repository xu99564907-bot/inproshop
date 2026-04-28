TYPE Str_TcpClient :
STRUCT
	Enable:		BOOL;//使能
	Execute:	BOOL;//发送数据
	SrcTcpPort:	UINT;//本地端口号	
	DstAdr:		STRING;//远程IP地址	
	DstTcpPort:	UINT;//远程端口号	
	SendDat:	ARRAY[0..500] OF BYTE;//发送数据内容	
	SendSize:	UINT;//发送数据长度
	RcvDat:		ARRAY[0..500] OF BYTE;//接收数据内容	
	RcvSize:	UINT;//接收数据长度
	Active:		BOOL;//	链接已建立	
	SendDone:	BOOL;//	发送数据完成	
	RcvDone:	BOOL;//	接收数据完成	
	Error:		BOOL;//	错误	
	ErrorID:	WORD;//	错误代码
END_STRUCT
END_TYPE
