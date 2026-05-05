PROGRAM OP20_Recipe
VAR
	i:INT;
	DownLoad_R:R_TRIG;
	Download_F:F_TRIG;
	Change:R_TRIG;
END_VAR
VAR RETAIN PERSISTENT
	RecipeNum AT %MB131076 : INT;
END_VAR

//主站一键切换配方
IF To_Slave.OnLineMode=1 THEN
	IF DB2002_Recipe.DownLoad THEN
		To_Slave.RecipeDownLoad:=1;
	ELSE
		To_Slave.RecipeDownLoad:=0;
	END_IF
	To_Slave.RecipeID:=DB2002_Recipe.RecipeNumTemp;
ELSE
	To_Slave.RecipeDownLoad:=0;
END_IF

//配方名
DB2002_Recipe.RecipeName:=DB2002_Recipe.TypeData[DB2002_Recipe.RecipeNum].Name;

//配方参数修改使能
IF DB2002_Recipe.RecipeNum=DB2002_Recipe.RecipeNumTemp THEN
	DB2002_Recipe.ParameterChangePmt:=TRUE;
ELSE
	DB2002_Recipe.ParameterChangePmt:=FALSE;
END_IF

//配方允许切换使能
DB2002_Recipe.RecipeChangePmt:=DB2000_Control.Mode.Status.ManualMode ;

//配方提取
DB2002_Recipe.TypeDataCur:=DB2002_Recipe.TypeData[DB2002_Recipe.RecipeNum];


IF RecipeNum<>DB2002_Recipe.RecipeNumTemp THEN
	DB2002_Recipe.RecipeNameTemp:=DB2002_Recipe.TypeData[DB2002_Recipe.RecipeNumTemp].Name;
	RecipeNum:=DB2002_Recipe.RecipeNumTemp;
END_IF

DownLoad_R(CLK:= DB2002_Recipe.DownLoad);
DownLoad_F(CLK:= DB2002_Recipe.DownLoad);
ACT_Download();
ACT_Upload();

