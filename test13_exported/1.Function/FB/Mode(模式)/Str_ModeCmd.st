TYPE Str_ModeCmd :
STRUCT
	AutoManualButton:BOOL;//手自动按钮
	RunButton		:BOOL;//启动按钮
	StopButton		:BOOL;//停止按钮
	ResetButton		:BOOL;//复位按钮	
	CycleEndButton	:BOOL;//周期停止按钮
	StepButton		:BOOL;//单步按钮
	HomingButton	:BOOL;//回原按钮
	NullPartButton	:BOOL;//空跑按钮
	OfflineButton	:BOOL;//离线按钮
	LampTest		:BOOL;//灯光测试
	Debug_BUZButton	:BOOL;//蜂鸣器屏蔽
	SafetyDoorShieild:BOOL;//安全门屏蔽
	NullPartRunLine	:BOOL;//空托盘跑线
	ManUnlock		:BOOL;//互锁信号解锁
END_STRUCT
END_TYPE
