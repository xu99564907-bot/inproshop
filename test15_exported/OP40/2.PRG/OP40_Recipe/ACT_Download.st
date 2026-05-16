

IF DownLoad_F.Q AND DB4002_Recipe.RecipeChangePmt THEN
	
	DB4002_Recipe.RecipeNum:=DB4002_Recipe.RecipeNumTemp;//显示对应配方ID
	DB4002_Recipe.TypeData[DB4002_Recipe.RecipeNumTemp].Name:=DB4002_Recipe.RecipeNameTemp;
	;
END_IF







