TYPE Str_HeatingParmStatus :
STRUCT
	ATDone:BOOL;//自整定完成	
	ATBusy:BOOL;//自整定中
	Fault:BOOL;//错误
	FaultID:INT;//错误代码	
	Warm:BOOL;//警告
	WarmID:INT;//警告代码
END_STRUCT
END_TYPE
