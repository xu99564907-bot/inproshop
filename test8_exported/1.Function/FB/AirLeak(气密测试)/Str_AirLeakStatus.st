TYPE Str_AirLeakStatus :
STRUCT
	Active:BOOL;//已连接
	ABusy:BOOL;//A测试中
	BBusy:BOOL;//B测试中
	ADone:BOOL;//A测试结束
	BDone:BOOL;//B测试结束
	AResult:Str_AirLeakResult;//A反馈结果
	BResult:Str_AirLeakResult;//B反馈结果
	AForceAct:REAL;//A通道实际压力值
	BForceAct:REAL;//B通道实际压力值
	ALeakAct:REAL;//A通道实际泄露值
	BLeakAct:REAL;//B通道实际泄露值	
	
END_STRUCT
END_TYPE
