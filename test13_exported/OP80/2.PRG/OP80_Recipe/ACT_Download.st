

IF DownLoad_F.Q AND DB8002_Recipe.RecipeChangePmt THEN
	
	DB8002_Recipe.RecipeNum:=DB8002_Recipe.RecipeNumTemp;//显示对应配方ID
	DB8002_Recipe.TypeData[DB8002_Recipe.RecipeNumTemp].Name:=DB8002_Recipe.RecipeNameTemp;
	;
END_IF







