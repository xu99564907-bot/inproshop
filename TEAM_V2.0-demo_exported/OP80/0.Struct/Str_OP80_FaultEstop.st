TYPE Str_OP80_FaultEstop :
STRUCT
	MAP:BOOL;//映射地址勿删
	
	
	EstopButton:BOOL;//紧急停止按钮按下
	SafeDoor:BOOL;//安全门打开
	LightCurtain:BOOL;//光栅遮挡
	Space:ARRAY[3..63] OF BOOL;//预留报警位 

END_STRUCT
END_TYPE
