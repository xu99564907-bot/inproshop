

IF DownLoad_F.Q AND DB1002_Recipe.RecipeChangePmt THEN

	
	DB1002_Recipe.RecipeNum:=DB1002_Recipe.RecipeNumTemp;//显示对应配方ID
	DB1002_Recipe.TypeData[DB1002_Recipe.RecipeNumTemp].Name:=DB1002_Recipe.RecipeNameTemp;
	;
END_IF







