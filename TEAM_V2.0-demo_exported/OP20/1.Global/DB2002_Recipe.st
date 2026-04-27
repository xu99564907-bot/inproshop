VAR_GLOBAL
END_VAR
VAR_GLOBAL RETAIN PERSISTENT

	RecipeChangePmt AT %MB132604 : BOOL;	//配方允许切换
	ParameterChangePmt AT %MB132605 : BOOL;	//参数允许更改
	RecipeNumTemp AT %MB132606 : INT;	//HMI选中还未保存到PLC的编号.
	RecipeNum AT %MB133168 : INT;	//配方元素编号.
	RecipeName AT %MB146619 : STRING(20);	//配方元素名称.
	RecipeNameTemp AT %MB146640 : STRING(20);	//HMI头部显示当前配方名称
	RecipeOk AT %MB133637 : BOOL;//配方可用
	DownLoad AT %MB133638 : BOOL;//配方下载
	TypeDataCur AT %MB146664 : Str_OP20_Recipe;//当前配方
	TypeData AT %MB323868 : ARRAY [0..20] OF Str_OP20_Recipe;//配方数据
END_VAR
