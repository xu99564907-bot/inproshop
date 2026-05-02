PROGRAM OP10_Recipe
VAR
	i:INT;
	DownLoad_R:R_TRIG;
	Download_F:F_TRIG;
	Change:R_TRIG;
END_VAR
VAR RETAIN PERSISTENT
	RecipeNum AT %MB131072 : INT;
END_VAR

//主站一键切换配方
IF To_Slave.OnLineMode=1 THEN
	IF DB1002_Recipe.DownLoad THEN
		To_Slave.RecipeDownLoad:=1;
	ELSE
		To_Slave.RecipeDownLoad:=0;
	END_IF
	To_Slave.RecipeID:=DB1002_Recipe.RecipeNumTemp;
ELSE
	To_Slave.RecipeDownLoad:=0;
END_IF

//配方名
DB1002_Recipe.RecipeName:=DB1002_Recipe.TypeData[DB1002_Recipe.RecipeNum].Name;

//配方参数修改使能
IF DB1002_Recipe.RecipeNum=DB1002_Recipe.RecipeNumTemp THEN
	DB1002_Recipe.ParameterChangePmt:=TRUE;
ELSE
	DB1002_Recipe.ParameterChangePmt:=FALSE;
END_IF

//配方允许切换使能
DB1002_Recipe.RecipeChangePmt:=DB1000_Control.Mode.Status.ManualMode ;

//配方提取
DB1002_Recipe.TypeDataCur:=DB1002_Recipe.TypeData[DB1002_Recipe.RecipeNum];


IF RecipeNum<>DB1002_Recipe.RecipeNumTemp THEN
	DB1002_Recipe.RecipeNameTemp:=DB1002_Recipe.TypeData[DB1002_Recipe.RecipeNumTemp].Name;
	RecipeNum:=DB1002_Recipe.RecipeNumTemp;
END_IF

DownLoad_R(CLK:= DB1002_Recipe.DownLoad);
DownLoad_F(CLK:= DB1002_Recipe.DownLoad);
ACT_Download();
ACT_Upload();

