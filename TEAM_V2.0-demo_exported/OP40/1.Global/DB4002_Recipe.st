VAR_GLOBAL
END_VAR
VAR_GLOBAL RETAIN PERSISTENT

	RecipeChangePmt : BOOL;	//配方允许切换
	ParameterChangePmt : BOOL;	//参数允许更改
	RecipeNumTemp : INT;	//HMI选中还未保存到PLC的编号.
	RecipeNum  : INT;	//配方元素编号.
	RecipeName  : STRING(20);	//配方元素名称.
	RecipeNameTemp   : STRING(20);	//HMI头部显示当前配方名称
	RecipeOk  : BOOL;//配方可用
	DownLoad  : BOOL;//配方下载
	TypeDataCur   : Str_OP30_Recipe;//当前配方
	TypeData  : ARRAY [0..20] OF Str_OP30_Recipe;//配方数据
END_VAR
