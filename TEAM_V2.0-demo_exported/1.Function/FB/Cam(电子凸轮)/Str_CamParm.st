TYPE Str_CamParm :
STRUCT
	IC_ABS:BOOL;//定位互锁条件
	_ABS:ARRAY[0..49] OF Str_AxisParmControl;
END_STRUCT
END_TYPE
