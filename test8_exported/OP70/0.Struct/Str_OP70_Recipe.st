TYPE Str_OP70_Recipe :
STRUCT
	Name:STRING[20];//配方名称
	ID:INT;//配方ID
	AxisPosition_X1:ARRAY[0..49] OF REAL;//X1轴点位参数
	AxisPosition_Y1:ARRAY[0..49] OF REAL;//X2轴点位参数
	AxisPosition_Z1_PickPoint:REAL;//Z1轴取料点位参数
	PickNum:INT;//取料个数设定
END_STRUCT
END_TYPE
