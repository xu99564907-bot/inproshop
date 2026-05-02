TYPE Str_KukaCmd :
STRUCT
	Rob_Stop		:BOOL;//停止（Coil 1）	
	Rob_Start		:BOOL;//启动（Coil 2）
	Rob_Pause		:BOOL;//暂停（Coil 3）
	Rob_Continue	:BOOL;//继续（Coil 4）
	Rob_Uninatsll	:BOOL;//停止卸载（Coil 5）
	ActiveScara		:BOOL;//激活Scara（Coil 6）
	AppID0			:BOOL;//Main程序编号（Coil 7）
	AppID1			:BOOL;//Main程序编号（Coil 8）
	AppID2			:BOOL;//Main程序编号（Coil 9）
	AppID3			:BOOL;//Main程序编号（Coil 10）
	AppID4			:BOOL;//Main程序编号（Coil 11）
	AppID5			:BOOL;//Main程序编号（Coil 12）
	AppID6			:BOOL;//Main程序编号（Coil 13）
	ShutDown		:BOOL;//重启控制器（Coil 14）
	Acknoledgment	:BOOL;//确认消息（Coil 15）
	MachineIntial	:BOOL;//设备初始化（Coil 16）
	MachineAutoRun	:BOOL;//设备自动中（Coil 17）
	MachineStepRun	:BOOL;//单步信号（Coil 18）
	SpaceBool6		:BOOL;//预备位(Coil 19)
	SpaceBool7		:BOOL;//预备位(Coil 20)
	SpaceBool8		:BOOL;//预备位(Coil 21)
	SpaceBool9		:BOOL;//预备位(Coil 22)
	SpaceBoo20		:BOOL;//预备位(Coil 23)
	SpaceBoo21		:BOOL;//预备位(Coil 24)
	SpaceBoo22		:BOOL;//预备位(Coil 25)
	SpaceBoo23		:BOOL;//预备位(Coil 26)
	SpaceBoo24		:BOOL;//预备位(Coil 27)
	SpaceBoo25		:BOOL;//预备位(Coil 28)
	SpaceBoo26		:BOOL;//预备位(Coil 29)
	SpaceBoo27		:BOOL;//预备位(Coil 30)
	SpaceBoo28		:BOOL;//预备位(Coil 31)
	SpaceBoo29		:BOOL;//预备位(Coil 32)
	InterFace_B		:ARRAY[33..64] OF BOOL;//交互信号
	Speed				:INT;//	运行速度(Holding Register 1)
	ProductType			:INT;//交换数据字(Holding Register 2)
	InterFace_Register3	:INT;//交换数据字(Holding Register 3)
	InterFace_Register4	:INT;//交换数据字(Holding Register 4)
	InterFace_Register5	:INT;//交换数据字(Holding Register 5)
	InterFace_Register6	:INT;//交换数据字(Holding Register 6)
	InterFace_Register7	:INT;//交换数据字(Holding Register 7)
	InterFace_Register8	:INT;//交换数据字(Holding Register 8)
	InterFace_Register9	:INT;//交换数据字(Holding Register 9)
	InterFace_Register10	:INT;//交换数据字(Holding Register 10)
	InterFace_Register11	:INT;//交换数据字(Holding Register 11)
	InterFace_Register12	:INT;//交换数据字(Holding Register 12)
	InterFace_Register13	:INT;//交换数据字(Holding Register 13)
	InterFace_Register14	:INT;//交换数据字(Holding Register 14)
	InterFace_Register15	:INT;//交换数据字(Holding Register 15)
	InterFace_Register16	:INT;//交换数据字(Holding Register 16)

	
END_STRUCT
END_TYPE
