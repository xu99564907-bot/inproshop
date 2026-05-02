TYPE Str_HMI :
STRUCT
	Jump:ARRAY[0..1]OF INT;//触摸屏跳转画面
	Num:INT;//触摸屏当前画面
	Estop:Str_HMIFault;//急停报警信息
	Cyl:Str_HMIFault;//气缸报警信息
	Vac:Str_HMIFault;//真空报警信息
	Axis:Str_HMIFault;//气缸轴报警信息
	Stop:Str_HMIFault;//暂停报警信息
	Run:Str_HMIFault;//警告信息
	SpaceButton:ARRAY[0..99]OF BOOL;//预留触摸屏按钮
END_STRUCT
END_TYPE
