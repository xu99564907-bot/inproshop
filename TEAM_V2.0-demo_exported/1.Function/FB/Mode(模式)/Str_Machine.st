TYPE Str_Machine :
STRUCT
	OP_Emg_Stop		:BOOL;//操作面板紧急停止按钮
	OP_StartButton	:BOOL;//操作面板启动按钮
	OP_StopButton	:BOOL;//操作面板停止按钮
	OP_ResetButton	:BOOL;//操作面板复位按钮
	OP_AutoManual	:BOOL;//操作面板手/自动选择
	EmgSafetyRelay	:BOOL;//急停安全继电器信号
	SafetyDoorRelay	:BOOL;//安全门安全继电器信号
	LightCurtainRelay:BOOL;//光栅安全继电器信号
	AirPresure		:BOOL;//气源压力开关信号
	RedLightHouse	:BOOL;//红色灯塔
	YeLightHouse	:BOOL;//黄色灯塔
	GrLightHouse	:BOOL;//绿色灯塔
	Buzzer			:BOOL;//蜂鸣器
	StartLamp		:BOOL;//开始按钮灯
	StopLamp		:BOOL;//停止按钮灯
	ResetLamp		:BOOL;//复位按钮灯
	Light			:BOOL;//日光灯
	Emg_Stop		:ARRAY[0..9]OF BOOL := [10(TRUE)];//急停信号
	LightCurtain	:ARRAY[0..9]OF BOOL := [10(TRUE)];//安全光栅信号
	SafetyDoor		:ARRAY[0..9]OF BOOL := [10(TRUE)];//安全门信号
	Speed			:REAL;//设备运行速率
	CycleTime		:Str_CycleTime;//周期时间
	PowerOnTime		:UDINT;//开机时间
	RunTime			:UDINT;//运行时间
	EfficencyResult	:REAL;//设备稼动率
	EfficencyClear	:BOOL;//稼动率清零
END_STRUCT
END_TYPE
