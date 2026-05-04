TYPE Str_StopperStatus :
STRUCT
	PalletArrivalSensor:BOOL;//托盘位置到达
	Busy:BOOL;//托盘流出中
	FeedOutPls:BOOL;//放行脉冲信号
	OKToFeedIn:BOOL;//托盘允许进
	OKToFeedOut:BOOL;//托盘允许出
	MotorOn:BOOL;//流线运转中
	StationHome:BOOL;//工站在原位
	TimeOut:BOOL;//托盘流出超时
	Times:INT;//已放行治具个数
	Comment:WSTRING(40);//流出步注释
END_STRUCT
END_TYPE
