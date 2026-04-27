TYPE Str_AxisDevStatus :
STRUCT
	iDOG:BOOL;//原点感应器
	iLimitFor:BOOL;//正极限
	iLimitBack:BOOL;//负极限
	iAlam:BOOL;//轴报警
	oPowerOn:BOOL;//轴使能
	oReset:BOOL;//报警复位	
END_STRUCT
END_TYPE
