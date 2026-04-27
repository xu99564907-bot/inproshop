TYPE Str_Graph :
STRUCT
	Start:BOOL;//流程启动
	Disable:BOOL;//流程屏蔽
	Running:BOOL;//流程运转中
	NoPausedRunning:BOOL;//流程不暂停运行
	Complete:BOOL;//流程完成
	Step:INT;//流程步
	StepBefor:INT;//上一周期步骤
	CycleTime:INT;//流程计时	
	Comment:WSTRING;//流程注释
	InterFace_IN:ARRAY[0..9] OF BOOL;//交互信号输入
	InterFace_OUT:ARRAY[0..9] OF BOOL;//交互信号输出
END_STRUCT
END_TYPE
