VAR_GLOBAL
END_VAR
VAR_GLOBAL RETAIN PERSISTENT

	RecipeChangePmt AT %MB133639 : BOOL;	//配方允许切换
	ParameterChangePmt AT %MB133666 : BOOL;	//参数允许更改
	RecipeNumTemp AT %MB133667 : INT;	//HMI选中还未保存到PLC的编号.
	RecipeNum AT %MB133669 : INT;	//配方元素编号.
	RecipeName AT %MB146707 : STRING(20);	//配方元素名称.
	RecipeNameTemp AT %MB146728 : STRING(20);	//HMI头部显示当前配方名称
	RecipeOk AT %MB133671 : BOOL;//配方可用
	DownLoad AT %MB133672 : BOOL;//配方下载
	TypeDataCur AT %MB146752 : Str_OP30_Recipe;//当前配方
	TypeData AT %MB325920 : ARRAY [0..20] OF Str_OP30_Recipe;//配方数据
END_VAR
