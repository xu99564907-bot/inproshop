TYPE Str_AirLeakResult :
STRUCT
	TestNum:REAL;//测试编号
	TestTime:REAL;//测试时间
	TestForce:REAL;//测试压力
	LeakageValue:REAL;//泄漏值
	TestResult:INT;//测试结果
	TestStation:INT;//测试工位=0:A,=1:B
END_STRUCT
END_TYPE
