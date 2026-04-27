TYPE Str_StopperDevStatus :
STRUCT
	Sensor1:BOOL;//到位检测(靠近挡停感应器)
	Sensor2:BOOL;//到位检测(末尾治具检测感应器)
	CylFor_Sensor:BOOL;//挡停气缸伸出感应器，无感应器=1
	CylBack_Sensor:BOOL;//挡停气缸缩回感应器，无感应器=1
	CylFor_Valve:BOOL;//挡停气缸伸出电磁阀
	CylBack_Valve:BOOL;//挡停气缸缩回电磁阀
END_STRUCT
END_TYPE
