VAR_GLOBAL
END_VAR
VAR_GLOBAL RETAIN PERSISTENT

	RecipeChangePmt AT %MB132596 : BOOL;	//配方允许切换
	ParameterChangePmt AT %MB132597 : BOOL;	//参数允许更改
	RecipeNumTemp AT %MB132598 : INT;	//HMI选中还未保存到PLC的编号.
	RecipeNum AT %MB132600 : INT;	//配方元素编号.
	RecipeName AT %MB133699 : STRING(20);	//配方元素名称.
	RecipeNameTemp AT %MB133720 : STRING(20);	//HMI头部显示当前配方名称
	RecipeOk AT %MB132602 : BOOL;//配方可用
	DownLoad AT %MB132603 : BOOL;//配方下载
	TypeDataCur AT %MB146576 : Str_OP11_Recipe;//当前配方
	TypeData AT %MB305052 : ARRAY [0..20] OF Str_OP11_Recipe;//配方数据
END_VAR
