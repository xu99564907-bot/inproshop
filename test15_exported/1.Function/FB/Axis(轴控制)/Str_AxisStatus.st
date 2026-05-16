TYPE Str_AxisStatus :
STRUCT	
	InPoint	:ARRAY[0..50] OF BOOL;//在点位	
	InTorque:ARRAY[0..50] OF BOOL;//扭力到达	
	PowerON	:BOOL;//轴已使能	
	Busy	:BOOL;//运转中	
	PosOK	:BOOL;//定位完成	
	Intialed	:BOOL;//回原完成	
	Paused	:BOOL;//轴暂停中	
	Posi	:BOOL;//轴正转中	
	Nega	:BOOL;//轴反转中	
	Error	:BOOL;//错误	
	ErrorID	:WORD;//错误代码	
	ActPosition	:REAL;//实际位置
	ActVelocity	:REAL;//实际速度
	ActTorque	:REAL;//实际扭矩
	StopPositon	:REAL;//停止位置
	HmiPosition	:REAL;//触摸屏显示对应绝对位置点位
	SpTime		:UINT;//运动时间
	State		:INT;//轴状态
	ActMode		:INT;//轴实际控制模式=1转矩模式，=2速度模式,=3位置控制模式
END_STRUCT
END_TYPE
