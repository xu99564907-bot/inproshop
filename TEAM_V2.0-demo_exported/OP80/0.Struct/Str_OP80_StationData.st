TYPE Str_OP80_StationData :
STRUCT
	Num:INT;//数量：=0无产品，
	ID:INT;//产品ID
	ProductCode:STRING;//产品编码
	BeforStatus:INT;//锁附站产品状态
	NowStatus:INT;//当前站产品状态 =1  ，=2   ，=3  
 
END_STRUCT
END_TYPE
