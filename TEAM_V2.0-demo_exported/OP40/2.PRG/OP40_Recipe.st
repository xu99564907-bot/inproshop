PROGRAM OP40_Recipe
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
	IF DB4002_Recipe.DownLoad THEN
		To_Slave.RecipeDownLoad:=1;
	ELSE
		To_Slave.RecipeDownLoad:=0;
	END_IF
	To_Slave.RecipeID:=DB4002_Recipe.RecipeNumTemp;
ELSE
	To_Slave.RecipeDownLoad:=0;
END_IF

//配方名
DB4002_Recipe.RecipeName:=DB4002_Recipe.TypeData[DB4002_Recipe.RecipeNum].Name;

//配方参数修改使能
IF DB4002_Recipe.RecipeNum=DB4002_Recipe.RecipeNumTemp THEN
	DB4002_Recipe.ParameterChangePmt:=TRUE;
ELSE
	DB4002_Recipe.ParameterChangePmt:=FALSE;
END_IF

//配方允许切换使能
DB4002_Recipe.RecipeChangePmt:=DB4000_Control.Mode.Status.ManualMode ;

//配方提取
DB4002_Recipe.TypeDataCur:=DB4002_Recipe.TypeData[DB4002_Recipe.RecipeNum];


IF RecipeNum<>DB4002_Recipe.RecipeNumTemp THEN
	DB4002_Recipe.RecipeNameTemp:=DB4002_Recipe.TypeData[DB4002_Recipe.RecipeNumTemp].Name;
	RecipeNum:=DB4002_Recipe.RecipeNumTemp;
END_IF

DownLoad_R(CLK:= DB4002_Recipe.DownLoad);
DownLoad_F(CLK:= DB4002_Recipe.DownLoad);
ACT_Download();
ACT_Upload();

