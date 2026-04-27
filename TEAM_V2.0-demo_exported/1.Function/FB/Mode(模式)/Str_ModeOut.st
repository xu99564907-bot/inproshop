TYPE Str_ModeOut :
STRUCT
	
	HomeStart:BOOL;//设备初始化开始
	ErrorReset:BOOL;//设备报警复位
	Stop:BOOL;//设备停止
	AutoRun_R:BOOL;//运转中上升沿
	AutoRun_F:BOOL;// 运转中下降沿
	HomeOK_R:BOOL;//回原完成上升沿
	HomeOK_F:BOOL;//回原完成下降沿
	HomeStart_R:BOOL;//回原开始上升沿
	HomeStart_F:BOOL;//回原开始下降沿
END_STRUCT
END_TYPE
