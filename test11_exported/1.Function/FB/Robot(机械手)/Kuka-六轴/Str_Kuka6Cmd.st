TYPE Str_Kuka6Cmd :
STRUCT
	AppID0			:BOOL;//Main程序编号
	AppID1			:BOOL;//Main程序编号
	AppID2			:BOOL;//Main程序编号
	AppID3			:BOOL;//Main程序编号
	AppID4			:BOOL;//Main程序编号
	AppID5			:BOOL;//Main程序编号
	AppID6			:BOOL;//Main程序编号
	AppID7			:BOOL;//Main程序编号
	PGNO_VALID		:BOOL;//程序号有效
	EXT_START		:BOOL;//启动
	MOVE_ENABLE		:BOOL;//运行开通-激活运动使能
	CONF_MESS		:BOOL;//错误确认
	DRIVES_OFF		:BOOL;//驱动器关闭
	DRIVES_ON		:BOOL;//驱动装置接通
	EXT_Stop		:BOOL;//程序复位	
	MachineIntial	:BOOL;//设备初始化
	MachineAutoRun	:BOOL;//设备自动中
	MachineStepRun	:BOOL;//单步信号
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
	InterFace_B		:ARRAY[33..64] OF BOOL;//交互信号
	Speed				:INT;//	运行速度(第9-10个字节)
	ProductType			:INT;//配方型号(第11-12个字节)
	StepNum				:INT;//步序号(第13-14个字节)
	InterFace_Register4	:INT;//交换数据字(第15-16个字节)
	InterFace_Register5	:INT;//交换数据字(第17-18个字节)
	InterFace_Register6	:INT;//交换数据字(第19-20个字节)
	InterFace_Register7	:INT;//交换数据字(第21-22个字节)
	InterFace_Register8	:INT;//交换数据字(第23-24个字节)
	InterFace_Register9	:INT;//交换数据字(第25-26个字节)
	InterFace_Register10	:REAL;//交换数据字(第27-30个字节)
	InterFace_Register11	:REAL;//交换数据字(第31-34个字节)
	InterFace_Register12	:REAL;//交换数据字
	InterFace_Register13	:REAL;//交换数据字
	InterFace_Register14	:REAL;//交换数据字
	InterFace_Register15	:REAL;//交换数据字
	InterFace_Register16	:REAL;//交换数据字
	
END_STRUCT
END_TYPE
