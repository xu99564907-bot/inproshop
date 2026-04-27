PROGRAM OP30_Graph
VAR
	IntitalTimeDelay:ARRAY[1..9,0..10] OF TON;//初始化流程用
	AutoTimeDelay:ARRAY[1..9,0..10] OF TON;//自动流程用
	
	Init:ARRAY[1..20]OF Str_Graph := [20((Complete := TRUE))];//初始化
	Auto:ARRAY[1..20]OF Str_Graph;//自动
	Start:ARRAY[1..9] OF BOOL;//自动启动条件
	i:INT;//循环变量用
	
	AgingPutAllowNo:INT;//老化允许放编号
	AgingPickAllowNo:INT;//老化允许取编号
	BufferPutAllowNo:INT;//缓存台允许放编号
	
	AgingPutAllow:BOOL;//老化允许放
	AgingPickAllow:BOOL;//老化允许取
	BufferPutAllow:BOOL;//缓存台允许放
	
	
	BufferPickAllow:BOOL;//缓存台允许取
	TestPickAllow:BOOL;//测试台允许取
	TestPutAllow:BOOL;//测试台允许放
	PalletProductPutAllow:BOOL;//码垛区域允许放产品
	PalletPartitionPutAllow:BOOL;//码垛区域允许放隔板
	PalletPartitionPickAllow:BOOL;//码垛区域允许取隔板
	NgPutAllow:BOOL;//NG区域允许放料
	
	BufferPickAllowNo:INT;//缓存台允许取编号
	TestPickAllowNo:INT;//测试台允许取编号
	TestPutAllowNo:INT;//测试台允许放编号
	PalletProductPutAllowNo:INT;//码垛区域允许放产品编号
	PalletPartitionPutAllowNo:INT;//码垛区域允许放隔板编号
	
	
	PartitionInRobot:BOOL;//机械手上有隔板
	
	X1Point:INT;//X1轴
	X2Point:INT;//X1轴	
	BufferDisable:ARRAY[0..4]OF BOOL;
	
END_VAR


ACT_InitST1();
ACT_InitST2();
ACT_InitST3();
ACT_InitST4();
ACT_InitST5();
ACT_InitST6();

ACT_AutoRunST1_气密1测试();
ACT_AutoRunST2_气密2测试();
ACT_AutoRunST3_气密3测试();
ACT_AutoRunST4_气密4测试();
ACT_AutoRunST5_上料机械手();
ACT_AutoRunST6_码垛机械手();



