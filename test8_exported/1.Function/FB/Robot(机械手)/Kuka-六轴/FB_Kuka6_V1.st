FUNCTION_BLOCK FB_Kuka6_V1
VAR_IN_OUT
	ioKuka:Str_Kuka6;
END_VAR
VAR_INPUT
	iMode:Str_Mode;//设备控制模式
	iName:WSTRING;//名称
	iSpeed:REAL;//运行速度
	iProductType:INT;//配方名称	
	inputAddres:ARRAY[0..63] OF BYTE;
END_VAR
VAR_OUTPUT
	oRESET:BOOL;//安全回路复位
	outputAddres: ARRAY[0..63] OF BYTE;
	oTimeOut:BOOL;//通讯超时
END_VAR
VAR
	i:INT;//循环变量用
	TcpClient:Str_TcpClient;
	FB_TcpClient_instance:FB_TcpClient;//通讯功能块实例化
	bySendData:ARRAY[0..63]OF BYTE;
	byRevData:ARRAY[0..63]OF BYTE;
	change:INT;//切换读写状态
	TimeDelayExcute:TON;//数据发送间隔
	TimeDelayExcute_R:R_TRIG;
	TimeDelayControl:ARRAY[0..9] OF TON;//控制延时
	TimeOutDelay:TON;//超时
	EnableDelay:TON;//延时使能
END_VAR



ACT_Input();
ACT_Control();
ACT_Output();



