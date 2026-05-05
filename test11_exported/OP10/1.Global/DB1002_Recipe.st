VAR_GLOBAL
END_VAR
VAR_GLOBAL RETAIN PERSISTENT

	RecipeChangePmt AT %MB131236 : BOOL;	//配方允许切换
	ParameterChangePmt AT %MB131237 : BOOL;	//参数允许更改
	RecipeNumTemp AT %MB131618 : INT;	//HMI选中还未保存到PLC的编号.
	RecipeNum AT %MB131646 : INT;	//配方元素编号.
	RecipeName AT %MB133595 : STRING(20);	//配方元素名称.
	RecipeNameTemp AT %MB133616 : STRING(20);	//HMI头部显示当前配方名称
	RecipeOk AT %MB132194 : BOOL;//配方可用
	DownLoad AT %MB132195 : BOOL;//配方下载
	TypeDataCur AT %MB179604 : Str_OP10_Recipe;//当前配方
	TypeData AT %MB328404 : ARRAY [0..20] OF Str_OP10_Recipe;//配方数据
END_VAR
