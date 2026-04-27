TYPE Str_Kuka6Status :
STRUCT
	AppID0			:BOOL;//返回程序编号
	AppID1			:BOOL;//返回程序编号
	AppID2			:BOOL;//返回程序编号
	AppID3			:BOOL;//返回程序编号
	AppID4			:BOOL;//返回程序编号
	AppID5			:BOOL;//返回程序编号
	AppID6			:BOOL;//返回程序编号
	AppID7			:BOOL;//返回程序编号	
	ALARM_STOP:		BOOL;//	急停
	USER_SAF:		BOOL;//	安全门	
	Ready:			BOOL;//	驱动器处于待机运行状态
	STOPMESS:		BOOL;//	集合故障
	PRO_ACT:		BOOL;//	程序激活
	PGNO_REQ:		BOOL;//	程序号请求	
	APPL_RUN:		BOOL;//	运行中
	EXT:			BOOL;//外部自动运行
	Intialed:		BOOL;//	机械手初始化完成	
	SpaceBoo18		:BOOL;//预备位
	SpaceBoo19		:BOOL;//预备位
	SpaceBoo20		:BOOL;//预备位
	SpaceBoo21		:BOOL;//预备位
	SpaceBoo22		:BOOL;//预备位
	SpaceBoo23		:BOOL;//预备位
	SpaceBoo24		:BOOL;//预备位
	SpaceBoo25		:BOOL;//预备位
	SpaceBoo26		:BOOL;//预备位
	SpaceBoo27		:BOOL;//预备位
	SpaceBoo28		:BOOL;//预备位
	SpaceBoo29		:BOOL;//预备位
	SpaceBoo30		:BOOL;//预备位
	SpaceBoo31		:BOOL;//预备位
	SpaceBoo32		:BOOL;//预备位	
	InterFace_B:ARRAY[33..64] OF BOOL;//交互信号
	ErrorCode:			WORD;//	错误代码（9-10）
	ProductType			:INT;//配方型号(第11-12个字节)
	StepNum				:INT;//步序号(第13-14个字节)
	InterFace_Register19:	WORD;// 交换数据字(Holding Register19)
	InterFace_Register20:	WORD;//	交换数据字(Holding Register20)
	InterFace_Register21:	WORD;//	交换数据字(Holding Register21)
	InterFace_Register22:	WORD;//	交换数据字(Holding Register22)
	InterFace_Register23:	WORD;//	交换数据字(Holding Register23)
	InterFace_Register24:	WORD;//	交换数据字(Holding Register24)
	InterFace_Register25:	WORD;//	交换数据字(Holding Register25)
	InterFace_Register26:	WORD;//	交换数据字(Holding Register26)
	InterFace_Register27:	WORD;// 交换数据字(Holding Register27)	
	InterFace_Register28:	WORD;//	交换数据字(Holding Register28)
	InterFace_Register29:	WORD;// 交换数据字(Holding Register29)	
	InterFace_Register30:	WORD;//	交换数据字(Holding Register30)
	InterFace_Register31:	WORD;//	交换数据字(Holding Register31)
	InterFace_Register32:	WORD;//	交换数据字(Holding Register32)
END_STRUCT
END_TYPE
