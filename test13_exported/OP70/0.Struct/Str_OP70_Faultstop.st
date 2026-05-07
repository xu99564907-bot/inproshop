TYPE Str_OP70_FaultStop :
STRUCT
	MAP:BOOL;//映射地址勿删
	
	
	Cyl:ARRAY[0..127]OF BOOL;//8个字
	Vac:ARRAY[0..63]OF BOOL;//4个字
	Axis:ARRAY[0..63]OF BOOL;//4个字
	Sensor:ARRAY[0..127]OF BOOL;//8个字
	InitialTimeOut		:BOOL;//回原超时
	SafeDoorOpen		:BOOL;//安全门打开
	BeforStation_Communication_Rrror:BOOL;//前站通讯断开
	MasterTimeOut:BOOL;//主站通讯断开
	MaterReipeDiscrepancy:BOOL;//配方不一致
	感应器_NotDetect:BOOL;//感应器未检测到
	Space:ARRAY[10..127] OF BOOL;//预留报警位 

END_STRUCT
END_TYPE