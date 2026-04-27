PROGRAM OP80_Other
VAR
	i:INT;//循环变量
	MaterialCode: INT;
END_VAR


//产品1 
DB8090_Other.Product[1].ProductSpecifications:='  ';
DB8090_Other.Product[1].ProductCode:=' ';

DB8090_Other.Product[1].MaterialCode[1]:=' ';
DB8090_Other.Product[1].MaterialCode[2]:=' ';

//产品2 
DB8090_Other.Product[2].ProductSpecifications:=' ';
DB8090_Other.Product[2].ProductCode:=' ';

DB8090_Other.Product[2].MaterialCode[1]:=' ';
DB8090_Other.Product[2].MaterialCode[2]:=' ';

//产品3_S20LW-2
DB8090_Other.Product[3].ProductSpecifications:=' ';
DB8090_Other.Product[3].ProductCode:=' ';

DB8090_Other.Product[3].MaterialCode[1]:=' ';
DB8090_Other.Product[3].MaterialCode[2]:=' ';



FOR i:=1 TO 20 BY 1 DO
	DB8090_Other.Product[i].MaterialName[1]:=" ";
	DB8090_Other.Product[i].MaterialName[2]:=" ";
END_FOR

//产品对应编号检索
FOR i:=1 TO 20 BY 1 DO
	IF DB8002_Recipe.TypeData[DB8002_Recipe.RecipeNum].Name=DB8090_Other.Product[i].ProductSpecifications THEN
		DB8002_Recipe.TypeData[DB8002_Recipe.RecipeNum].ProDuctNum:=i;
		EXIT;
	END_IF

END_FOR
IF i>=21 THEN
	;
END_IF



//动作分类
IF DB8090_Other.Product[DB8002_Recipe.TypeDataCur.ProDuctNum].MaterialCode[1]='PGH64' THEN
	DB8090_Other.Cyl_B_Sport:=TRUE;
ELSE
	DB8090_Other.Cyl_B_Sport:=FALSE;
END_IF








