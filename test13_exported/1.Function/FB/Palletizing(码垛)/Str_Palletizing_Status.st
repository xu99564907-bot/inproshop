TYPE Str_Palletizing_Status :
STRUCT
	Busy:BOOL;//托盘进出中
	Done:BOOL;//托盘进出完成
	State:WORD;//工位状态 = 0 无托盘，=1 有托盘待取放料，=2有托盘已放满/取空，=3请求托盘进入，=4请求托盘离开
	PerLayersNum:INT;//当前层产品数量
	LayersNum:INT;//当前层数
	Error:BOOL;//错误
	ErrorID:WORD;//错误代码;
END_STRUCT
END_TYPE
