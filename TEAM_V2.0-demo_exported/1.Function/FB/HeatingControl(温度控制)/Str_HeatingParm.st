TYPE Str_HeatingParm :
STRUCT
	SV:REAL;//温度设定值
	PV:REAL;//温度实际值
	K:REAL;//温控补偿系数
	ControlLimit:REAL;//温控范围
	Kp:REAL;//比例系数
	Ti:REAL;//积分时间
	Td:REAL;//微分时间
END_STRUCT
END_TYPE
