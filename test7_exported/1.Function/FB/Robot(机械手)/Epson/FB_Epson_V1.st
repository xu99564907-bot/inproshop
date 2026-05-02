FUNCTION_BLOCK FB_Epson_V1
VAR_IN_OUT
	ioEpson:Str_Epson;
END_VAR
VAR_INPUT
	iMode:Str_Mode;//设备控制模式
	iName:WSTRING;//名称
	iDstAdr:STRING;//IP地址
	iDstTcpPort:UINT;//端口号
	iSpeed:REAL;//运行速度
	iProductType:INT;//配方名称
	iClock:BOOL;//发送时钟
END_VAR
VAR_OUTPUT
	oTimeOut:BOOL;//通讯超时
END_VAR
VAR
	i:INT;//循环变量用
	FB_TcpClient_instance:FB_TcpClient;//通讯功能块实例化
	TcpClient:Str_TcpClient;
	bySendData:ARRAY[0..500]OF BYTE;
	byRevData:ARRAY[0..500]OF BYTE;
	change:BOOL;//切换读写状态
	TimeDelayExcute:TON;//数据发送间隔
	TimeDelayExcute_R:R_TRIG;
	TimeDelayControl:ARRAY[0..9] OF TON;//控制延时
	TimeOutDelay:TON;//超时
	EnableDelay:TON;//延时使能
END_VAR



ACT_Input();
ACT_Control();
ACT_Output();
ACT_Socket();

