TYPE Str_RotdiskStatus :
STRUCT
	Busy:BOOL;//运动中
	Done:BOOL;//执行完成
	Error:BOOL;//错误
	ErrorID:WORD;//错误代码
	Sp_Time	:ARRAY[0..9] OF UINT;//运动时间	
	
END_STRUCT
END_TYPE
