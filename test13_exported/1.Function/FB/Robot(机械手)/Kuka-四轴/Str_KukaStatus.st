TYPE Str_KukaStatus :
STRUCT
	Ready:			BOOL;//	系统就绪（Coil 257）	
	Running:		BOOL;//	运行中（Coil 258）	
	Paused:			BOOL;//	已暂停（Coil 259）
	Stop:			BOOL;//	已停止（Coil 260）
	Error:			BOOL;//	错误-APP（Coil 261）	
	SafeguardOn:	BOOL;//	安全门（Coil 262）
	EStopOn:		BOOL;//	急停（Coil 263）		
	SError:			BOOL;//	重故障-系统（Coil 264）	
	Warning:		BOOL;//	警告（Coil 265）
	Actived:		BOOL;//	已激活（Coil 266）
	ActConfirmed:	BOOL;//	Act已确认（Coil 267）	
	Space1:			BOOL;//	预备位（Coil 268）	
	Space2:			BOOL;//	预备位（Coil 269）	
	Space3:			BOOL;//	预备位（Coil 270）	
	Space4:			BOOL;//	预备位（Coil 271）	
	Intialed:		BOOL;//	机械手初始化完成（Coil 272）			
	InsideBox1:		BOOL;//	Box1（Coil 273）	
	InsideBox2:		BOOL;//	Box2（Coil 274）	
	InsideBox3:		BOOL;//	Box3（Coil 275）	
	InsideBox4:		BOOL;//	Box4（Coil 276）	
	InsideBox5:		BOOL;//	Box5（Coil 277）	
	InsideBox6:		BOOL;//	Box6（Coil 278）	
	InsideBox7:		BOOL;//	Box7（Coil 279）	
	InsideBox8:		BOOL;//	Box8 （Coil 280）	
	InsideBox9:		BOOL;//	Box9 （Coil 281）	
	InsideBox10:	BOOL;//	Box10（Coil 282）	
	InsideBox11:	BOOL;//	Box11（Coil 283）	
	InsideBox12:	BOOL;//	Box12（Coil 284）	
	InsideBox13:	BOOL;//	Box13（Coil 285）	
	InsideBox14:	BOOL;//	Box14（Coil 286）	
	InsideBox15:	BOOL;//	Box15（Coil 287）	
	InsideBox16:	BOOL;//	Box15（Coil 288）		
	InsidePlane1:	BOOL;//	Plane1（Coil 289）	
	InsidePlane2:	BOOL;//	Plane2（Coil 290）	
	InsidePlane3:	BOOL;//	Plane3（Coil 291）	
	InsidePlane4:	BOOL;//	Plane4（Coil 292）	
	InsidePlane5:	BOOL;//	Plane5（Coil 293）	
	InsidePlane6:	BOOL;//	Plane6（Coil 294）	
	InsidePlane7:	BOOL;//	Plane7（Coil 295）	
	InsidePlane8:	BOOL;//	Plane8（Coil 296）	
	InsidePlane9:	BOOL;//	Plane9（Coil 297）	
	InsidePlane10:	BOOL;//	Plane10（Coil 298）	
	InsidePlane11:	BOOL;//	Plane11（Coil 299）	
	InsidePlane12:	BOOL;//	Plane12（Coil 300）	
	InsidePlane13:	BOOL;//	Plane13（Coil 301）	
	InsidePlane14:	BOOL;// Plane14（Coil 302）	
	InsidePlane15:	BOOL;//	Plane15（Coil 303）	
	InsidePlane16:	BOOL;//	Plane15（Coil 304）	
	InterFace_B:ARRAY[305..336] OF BOOL;//交互信号
	ErrorCode:			WORD;//	错误代码（Holding Register 17）
	InterFace_Register18:	WORD;//	交换数据字(Holding Register18)
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
