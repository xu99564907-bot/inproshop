

IF DownLoad_F.Q AND DB1102_Recipe.RecipeChangePmt THEN
	
	DB1102_Recipe.RecipeNum:=DB1102_Recipe.RecipeNumTemp;//显示对应配方ID
	DB1102_Recipe.TypeData[DB1102_Recipe.RecipeNumTemp].Name:=DB1102_Recipe.RecipeNameTemp;
	;
END_IF







