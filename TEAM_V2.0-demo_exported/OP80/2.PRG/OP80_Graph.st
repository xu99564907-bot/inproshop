PROGRAM OP80_Graph
VAR
	IntitalTimeDelay:ARRAY[1..9,0..10] OF TON;//初始化流程用
	AutoTimeDelay:ARRAY[1..9,0..10] OF TON;//自动流程用
	
	Init:ARRAY[1..20]OF Str_Graph := [20((Complete := TRUE))];//初始化
	Auto:ARRAY[1..20]OF Str_Graph;//自动
	Start:ARRAY[1..9] OF BOOL;//自动启动条件
	i:INT;//循环变量用
	
 
	
END_VAR


ACT_InitST1();
ACT_InitST2();
ACT_InitST3();
ACT_InitST4();
 
ACT_AutoRunST1_气密1测试();
ACT_AutoRunST2_气密2测试();
ACT_AutoRunST3_气密3测试();
ACT_AutoRunST4_气密4测试();
 


