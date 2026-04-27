VAR_GLOBAL
END_VAR
VAR_GLOBAL RETAIN PERSISTENT

	RecipeChangePmt AT %MB133673 : BOOL;	//配方允许切换
	ParameterChangePmt AT %MB133674 : BOOL;	//参数允许更改
	RecipeNumTemp AT %MB133675 : INT;	//HMI选中还未保存到PLC的编号.
	RecipeNum AT %MB133677 : INT;	//配方元素编号.
	RecipeName AT %MB146778 : STRING(20);	//配方元素名称.
	RecipeNameTemp AT %MB179580 : STRING(20);	//HMI头部显示当前配方名称
	RecipeOk AT %MB133679 : BOOL;//配方可用
	DownLoad AT %MB133680 : BOOL;//配方下载
	TypeDataCur AT %MB327972 : Str_OP70_Recipe;//当前配方
	TypeData AT %MB490632 : ARRAY [0..10] OF Str_OP70_Recipe;//配方数据
END_VAR
