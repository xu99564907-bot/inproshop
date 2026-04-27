FUNCTION_BLOCK FB_Sensor_V1_1
VAR_IN_OUT
	ioSensor:Str_Sensor;
END_VAR
VAR_INPUT
	iSensor:BOOL;//感应器输入信号
	iName:WSTRING(40);//感应器名称
END_VAR
VAR_OUTPUT
END_VAR
VAR
	TON_OnDelay	:TON;		
	TON_OffDelay	:TON;	
	ON_R	:R_TRIG;		
	OFF_R	:R_TRIG;		


END_VAR


(*版本V1.1:
	增加屏蔽信号功能
*)

//信号映射
ioSensor.Parm.Comment:=iName;
ioSensor.Parm.Input:=iSensor;

//信号延时实例化
TON_OnDelay(IN:=ioSensor.Parm.Input  ,PT:=UINT_TO_TIME(ioSensor.Parm.OnDelay*100));
TON_OFFDelay(IN:=NOT ioSensor.Parm.Input ,PT:=UINT_TO_TIME(ioSensor.Parm.OffDelay*100));

//上升沿实例化
ON_R(CLK:=ioSensor.Parm.Input);
OFF_R(CLK:=NOT ioSensor.Parm.Input);


//ON输出
ioSensor.Status._ON:=(TON_OnDelay.Q AND NOT ioSensor.Parm.OnDisable)OR ioSensor.Parm.OnDisable ;

//OFF输出
ioSensor.Status._OFF:=(TON_OffDelay.Q AND NOT ioSensor.Parm.OffDisable)OR ioSensor.Parm.OffDisable  ;

//ON上升沿输出
ioSensor.Status._R:=ON_R.Q ;

//OFF上升沿输出
ioSensor.Status._F:=OFF_R.Q ;
