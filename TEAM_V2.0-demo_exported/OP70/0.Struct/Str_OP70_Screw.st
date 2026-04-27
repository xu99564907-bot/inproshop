TYPE Str_OP70_Screw :
STRUCT
	GoalNum:INT;//锁螺丝目标数量，
	VolNum:INT;//锁螺丝当前数量 
	TargetTorsion		: REAL;	//目标扭力设置
	Step0ScrewSpeed		: WORD;	//Step0拧紧速度
	TorqueKeepTime		: WORD;	//扭力保持时间
	countVOL            : BOOL;
END_STRUCT
END_TYPE
