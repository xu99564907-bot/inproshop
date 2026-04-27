

IF DownLoad_F.Q AND DB3002_Recipe.RecipeChangePmt THEN
	
	DB3002_Recipe.RecipeNum:=DB3002_Recipe.RecipeNumTemp;//显示对应配方ID
	DB3002_Recipe.TypeData[DB3002_Recipe.RecipeNumTemp].Name:=DB3002_Recipe.RecipeNameTemp;
	;
END_IF







