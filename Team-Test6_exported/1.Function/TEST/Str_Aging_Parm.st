TYPE Str_Aging_Parm :
STRUCT
	LastTime:TIME := T#1.4S;
	AgingTime:INT :=1800;//老化时间
	AgingInterval:INT :=1;//老化间隔
	ProductCode:STRING;//产品码
END_STRUCT
END_TYPE
