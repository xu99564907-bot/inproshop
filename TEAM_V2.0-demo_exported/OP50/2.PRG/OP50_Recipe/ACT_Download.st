

IF DownLoad_F.Q AND DB5002_Recipe.RecipeChangePmt THEN
	
	DB5002_Recipe.RecipeNum:=DB5002_Recipe.RecipeNumTemp;//显示对应配方ID
	DB5002_Recipe.TypeData[DB5002_Recipe.RecipeNumTemp].Name:=DB5002_Recipe.RecipeNameTemp;
	;
END_IF







