TYPE Str_Aging_Cmd :
STRUCT
	Enable:BOOL := true;//工位屏蔽
	Excute:BOOL;//触摸屏触发老化
	Stop:BOOL;//停止老化
	PutIn:BOOL;//放入产品
	AutoMotorUpFor:BOOL;//自动上电机正转
	AutoMotorUpBak:BOOL;//自动上电机反转
	AutoMotorDownFor:BOOL;//自动下电机正转
	AutoMotorDownBak:BOOL;//自动下电机反转		
	ManuMotorUpFor:BOOL;//手动上电机正转
	ManuMotorUpBak:BOOL;//手动上电机反转	
	ManuMotorDownFor:BOOL;//手动下电机正转
	ManuMotorDownBak:BOOL;//手动下电机反转	
	
	
	
END_STRUCT
END_TYPE
