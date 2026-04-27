TYPE Str_AxisCmd :
STRUCT
	Power	:BOOL;//使能
	Stop	:BOOL;//停止
	ManuToHome	:BOOL;//手动回原
	AutoToHome	:BOOL;//自动回原
	ManuJogFoward	:BOOL;//手动JOG+
	ManuJogBackward	:BOOL;//手动JOG-
	VelocityControl	:BOOL;//速度模式控制
	VelocityChange	:BOOL;//速度模式变速
	AutoINC	:INT;//自动相对运动
	AutoABS	:INT;//自动绝对运动
	Torque:INT;//转矩控制运动
	PointSelect:INT;//点位选择
	TeachOn	:BOOL;//示教使能
	Teach	:BOOL;//示教位置
	ManuPoint	:BOOL;//手动绝对运动点位
	ManuPosition	:BOOL;//手动绝对运动指定位置
	
END_STRUCT
END_TYPE
