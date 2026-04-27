TYPE Str_ScrewStatus :
STRUCT
	Ready	:BOOL;//备钉完成
	Busy	:BOOL;//出钉中	
	Done	:BOOL;//出钉到位		
	Error	:BOOL;//错误	
	ErrorID	:WORD;//错误代码	
	SpTime		:UINT;//出钉时间
END_STRUCT
END_TYPE
