

IF DownLoad_F.Q AND DB2002_Recipe.RecipeChangePmt THEN
	
	DB2002_Recipe.RecipeNum:=DB2002_Recipe.RecipeNumTemp;//显示对应配方ID
	DB2002_Recipe.TypeData[DB2002_Recipe.RecipeNumTemp].Name:=DB2002_Recipe.RecipeNameTemp;
	;
END_IF







