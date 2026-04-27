

IF DownLoad_F.Q AND DB6002_Recipe.RecipeChangePmt THEN
	
	DB6002_Recipe.RecipeNum:=DB6002_Recipe.RecipeNumTemp;//显示对应配方ID
	DB6002_Recipe.TypeData[DB6002_Recipe.RecipeNumTemp].Name:=DB6002_Recipe.RecipeNameTemp;
	;
END_IF







