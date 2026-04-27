TYPE Str_Aging_Status :
STRUCT
	Busy:BOOL;//老化中
	Done:BOOL;//老化完成
	State:WORD;//工位状态 = 0空闲，=1待老化，=2老化中，=3老化完成OK，=4老化完成NG
	TestTime:INT;//已测试时间
	UpMotor:WORD;//上电机状态 = 0 停止 =1 正转 =2 反转
	DownMotor:WORD;//下电机状态 = 0 停止 =1 正转 =2 反转
	Upcurrent:REAL;//上电机电流
	Downcurrent:REAL;//下电机电流
	UpcurrentMAX:REAL;//上电机最大电流
	DowncurrentMAX:REAL;//下电机最大电流
	Error:BOOL;//错误
	ErrorID:WORD;//错误代码;=1测试开始时物料未检测到;
END_STRUCT
END_TYPE
