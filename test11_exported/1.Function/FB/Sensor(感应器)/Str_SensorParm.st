TYPE Str_SensorParm :
STRUCT
	OnDelay:UINT;//ON延时	
	OffDelay:UINT;//OFF延时	
	OnDisable:BOOL;//On屏蔽[=TRUE,感应器ON一直输出
	OffDisable:BOOL;//Off屏蔽[=TRUE,感应器ON一直输出
	Input:BOOL;//信号输入	
	Comment:WSTRING(50);//感应器名称	
END_STRUCT
END_TYPE
