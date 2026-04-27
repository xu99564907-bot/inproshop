VAR_GLOBAL RETAIN PERSISTENT
	{attribute 'ElemComment':='(),(上料机械臂取料夹爪),(上料机械臂放料夹爪),(缓存台1),(缓存台2),(缓存台3),(缓存台4),(测试台1),(测试台2),(测试台3),(测试台4),(下料机械臂),4()'}
	StationData AT %MB142384 : ARRAY [0..15] OF Str_OP80_StationData;
	AgingTime AT %MB131231 : INT;//老化时间
	AgingInterval AT %MB131233 : INT;//老化间隔
	Product AT %MB220072 : ARRAY [0..20] OF Str_OP80_Product;
	Cyl_B_Sport AT %MB131235 : BOOL;//封堵B气缸是否动作
	
END_VAR

