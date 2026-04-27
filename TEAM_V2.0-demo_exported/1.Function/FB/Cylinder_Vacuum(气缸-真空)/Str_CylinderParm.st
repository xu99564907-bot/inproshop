TYPE Str_CylinderParm :
STRUCT
	IC_Home		:BOOL;//初始位互锁	
	IC_Work		:BOOL;//工作位互锁	
	DisableHome	:BOOL;//初始位感应器屏蔽	
	DisableWork	:BOOL;//动作位感应器屏蔽	
	Error_Delay	:UINT;//错误报警延时	
	Home_Delay	:UINT;//初始位到位延时	
	Work_Delay	:UINT;//动作位到位延时	
	Close_Delay	:UINT;//关闭破真空延时	
	Comment		:WSTRING(40);//气缸名称	
END_STRUCT
END_TYPE
