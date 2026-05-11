

IF DownLoad_F.Q AND DB7002_Recipe.RecipeChangePmt THEN


(**************下面程序固定****************)
	//配方ID切换/配方名设定
	DB7002_Recipe.RecipeNum:=DB7002_Recipe.RecipeNumTemp;//显示对应配方ID
	DB7002_Recipe.TypeData[DB7002_Recipe.RecipeNumTemp].Name:=DB7002_Recipe.RecipeNameTemp;
	;
END_IF