TYPE Str_CylinderStatus :
STRUCT
	InHome	:BOOL;//在初始位	
	InWork	:BOOL;//在工作位	
	Error	:BOOL;//错误	
	ErrorID	:WORD;//错误代码	
	Sp_Time	:ARRAY[0..9] OF INT;//运动时间	
	Sp_Times	:UINT;//动作次数	
	Er_Times	:UINT;//报警次数	

END_STRUCT
END_TYPE
