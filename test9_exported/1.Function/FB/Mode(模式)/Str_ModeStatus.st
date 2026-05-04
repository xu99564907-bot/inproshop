TYPE Str_ModeStatus :
STRUCT
	ManualMode	:BOOL;//手动模式
	AutoMode	:BOOL;//自动模式
	RunMode		:BOOL;//运转模式
	StopMode	:BOOL;//停止模式
	CycleMode	:BOOL;//周期模式
	StepMode	:BOOL;//单步模式
	DryMode		:BOOL;//空跑模式
	ClearMode	:BOOL;//清料模式
	OfflineMode	:BOOL;//离线模式
	HandMode	:BOOL;//人工模式
	StationMode	:BOOL;//单工位运行模式
	AutoRunning	:BOOL;//自动运转中
	StepRunning	:BOOL;//单步运转中
	HomeOK		:BOOL;//初始化完成
	EStop		:BOOL;//急停
	Fault		:BOOL;//报警
	Warning		:BOOL;//警告
	
END_STRUCT
END_TYPE



