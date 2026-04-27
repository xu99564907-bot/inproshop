PROGRAM OP30_Recipe
VAR
	i:INT;
	DownLoad_R:R_TRIG;
	Download_F:F_TRIG;
	Change:R_TRIG;
END_VAR
VAR RETAIN PERSISTENT
	RecipeNum AT %MB131078 : INT;
END_VAR

//主站一键切换配方
IF To_Slave.OnLineMode=1 THEN
	IF DB3002_Recipe.DownLoad THEN
		To_Slave.RecipeDownLoad:=1;
	ELSE
		To_Slave.RecipeDownLoad:=0;
	END_IF
	To_Slave.RecipeID:=DB3002_Recipe.RecipeNumTemp;
ELSE
	To_Slave.RecipeDownLoad:=0;
END_IF

//配方名
DB3002_Recipe.RecipeName:=DB3002_Recipe.TypeData[DB3002_Recipe.RecipeNum].Name;

//配方参数修改使能
IF DB3002_Recipe.RecipeNum=DB3002_Recipe.RecipeNumTemp THEN
	DB3002_Recipe.ParameterChangePmt:=TRUE;
ELSE
	DB3002_Recipe.ParameterChangePmt:=FALSE;
END_IF

//配方允许切换使能
DB3002_Recipe.RecipeChangePmt:=DB6000_Control.Mode.Status.ManualMode ;

//配方提取
DB3002_Recipe.TypeDataCur:=DB3002_Recipe.TypeData[DB3002_Recipe.RecipeNum];


IF RecipeNum<>DB3002_Recipe.RecipeNumTemp THEN
	DB3002_Recipe.RecipeNameTemp:=DB3002_Recipe.TypeData[DB3002_Recipe.RecipeNumTemp].Name;
	RecipeNum:=DB3002_Recipe.RecipeNumTemp;
END_IF

DownLoad_R(CLK:= DB3002_Recipe.DownLoad);
DownLoad_F(CLK:= DB3002_Recipe.DownLoad);
ACT_Download();
ACT_Upload();

