TYPE Str_ESDStatus :
STRUCT
	PowerON	:BOOL;//电批已使能	
	Busy	:BOOL;//锁附中	
	PosOK	:BOOL;//锁附完成	
	OK	:BOOL;//锁附OK	
	NG	:BOOL;//锁附NG	
	VolNum:INT;//锁螺丝当前数量 
	Error	:BOOL;//错误	
	ErrorID	:WORD;//错误代码	
	SpTime		:UINT;//锁附时间
	State		:INT;//电批状态=1锁附中,=2锁附OK,=3锁附NG
END_STRUCT
END_TYPE
