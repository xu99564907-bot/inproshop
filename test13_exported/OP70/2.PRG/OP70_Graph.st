PROGRAM OP70_Graph
VAR
	IntitalTimeDelay:ARRAY[1..9,0..10] OF TON;//初始化流程用
	AutoTimeDelay:ARRAY[1..9,0..10] OF TON;//自动流程用
	Init:ARRAY[1..20]OF Str_Graph := [20((Complete := TRUE))];//初始化
	Auto:ARRAY[1..20]OF Str_Graph;//自动
	Start:ARRAY[1..9] OF BOOL;//自动启动条件
	i:INT;//循环变量用
	Screw:ARRAY[1..4] OF Str_OP70_Screw;
END_VAR

ACT_InitST1();
ACT_InitST2();
ACT_InitST3();
ACT_InitST4();
ACT_InitST5();
ACT_InitST6();
ACT_AutoRunST1_人工上料打码();
ACT_AutoRunST2_同步搬运();
ACT_AutoRunST3_侧面1锁螺丝工位();
ACT_AutoRunST4_侧面2锁螺丝工位();
ACT_AutoRunST5_顶面锁螺丝工位();
ACT_AutoRunST6_下料工位();


