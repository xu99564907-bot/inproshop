TYPE Str_StopperCmd :
STRUCT
	ReleasePallet_Back:BOOL;//挡停控制流出启动
	StopCylinder_Back:BOOL;//挡停手动缩回
	StopCylinder_For:BOOL;//挡停手动伸出
	Reset:BOOL;//挡停状态复位
	
END_STRUCT
END_TYPE
