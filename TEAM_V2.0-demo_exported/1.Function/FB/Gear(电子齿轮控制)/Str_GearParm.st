TYPE Str_GearParm :
STRUCT
	IC_Home:BOOL;//回原互锁条件	
	IC_ABS:BOOL;//定位互锁条件
	IC_JOG:BOOL;//点动互锁条件	
	_ABS:ARRAY[0..49] OF Str_AxisParmControl;
	_INC:ARRAY[0..49] OF Str_AxisParmControl;
	ManuPosition:REAL;//手动定位点位
	ManuVelocity:REAL;//手动定位速度
	VelModeVelocity:REAL;//速度模式定位速度
	Comment:WSTRING(40);//轴名称
END_STRUCT
END_TYPE
