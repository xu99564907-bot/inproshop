TYPE Str_EpsonCmd :
STRUCT
	Rob_Start		:BOOL;//启动（IN512）
	Rob_Stop		:BOOL;//停止（IN513）
	Rob_Pause		:BOOL;//暂停（IN514）
	Rob_Continue	:BOOL;//继续（IN515）
	Rob_Reset		:BOOL;//复位（IN516）
	SetMotorsOn		:BOOL;//伺服使能打开（IN517）
	SetMotorsOff	:BOOL;//伺服使能关闭（IN518）
	SetPowerHigh	:BOOL;//高功率模式（IN519）
	SetPowerLow		:BOOL;//低功率模式（IN520）
	X_For			:BOOL;//X正向点动（IN521）
	X_Back			:BOOL;//X反向点动（IN522）
	Y_For			:BOOL;//Y正向点动（IN523）
	Y_Back			:BOOL;//Y反向点动（IN524）
	Z_For			:BOOL;//Z正向点动（IN525）
	Z_Back			:BOOL;//Z反向点动（IN526）			
	U_For			:BOOL;//U正向点动(IN527)
	U_Back			:BOOL;//U反向点动(IN528)
	V_For			:BOOL;//V正向点动(IN529)
	V_Back			:BOOL;//V反向点动(IN530)
	W_For			:BOOL;//W正向点动(IN531)
	W_Back			:BOOL;//W反向点动(IN532)
	SavePoint		:BOOL;//点位保存(IN533)
	Rob_Jump		:BOOL;//执行JUMP运动(IN534)
	ManuMode		:BOOL;//手动模式(IN535)
	AutoMode		:BOOL;//自动模式(IN536)
	SFree			:BOOL;//电机释放(IN537)
	SLock			:BOOL;//电机锁定(IN538)
	TeachMode		:BOOL;//示教模式(IN539)
	SpaceBoo29		:BOOL;//预备位(IN540)
	MachineIntial	:BOOL;//设备初始化(IN541)
	MachineAutoRun	:BOOL;//设备自动中(IN542)
	MachineStepRun	:BOOL;//单步信号(IN543)
	Speed			:INT;//	运行速度(IN34)
	PointNum		:INT;//	选择点位(IN35)
	InterFace_B:ARRAY[576..607] OF BOOL;//交互信号
	ProductType		:INT;//产品型号(IN38)
	InterFace_IN39	:INT;//交换数据字(IN39)
	InterFace_IN40	:INT;//交换数据字(IN40)
	InterFace_IN41	:INT;//交换数据字(IN41)
	InterFace_IN42	:INT;//交换数据字(IN42)
	InterFace_IN43	:INT;//交换数据字(IN43)
	InterFace_IN44	:INT;//交换数据字(IN44)
	InterFace_IN45	:INT;//交换数据字(IN45)
	InterFace_IN46	:INT;//交换数据字(IN46)
	InterFace_IN47	:INT;//交换数据字(IN47)
	InterFace_IN48	:INT;//交换数据字(IN48)
	InterFace_IN49	:INT;//交换数据字(IN49)
	InterFace_IN50	:INT;//交换数据字(IN50)
	InterFace_IN51	:INT;//交换数据字(IN51)
	InterFace_IN52	:INT;//交换数据字(IN52)
	InterFace_IN53	:INT;//交换数据字(IN53)

	
END_STRUCT
END_TYPE
