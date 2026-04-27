PROGRAM OP11_Recipe
VAR
	i:INT;
	DownLoad_R:R_TRIG;
	Download_F:F_TRIG;
	Change:R_TRIG;
END_VAR
VAR RETAIN PERSISTENT
	RecipeNum AT %MB131074 : INT;
END_VAR

//主站一键切换配方
IF To_Slave.OnLineMode=1 THEN
	IF DB1102_Recipe.DownLoad THEN
		To_Slave.RecipeDownLoad:=1;
	ELSE
		To_Slave.RecipeDownLoad:=0;
	END_IF
	To_Slave.RecipeID:=DB1102_Recipe.RecipeNumTemp;
ELSE
	To_Slave.RecipeDownLoad:=0;
END_IF

//配方名
DB1102_Recipe.RecipeName:=DB1102_Recipe.TypeData[DB1102_Recipe.RecipeNum].Name;

//配方参数修改使能
IF DB1102_Recipe.RecipeNum=DB1102_Recipe.RecipeNumTemp THEN
	DB1102_Recipe.ParameterChangePmt:=TRUE;
ELSE
	DB1102_Recipe.ParameterChangePmt:=FALSE;
END_IF

//配方允许切换使能
DB1102_Recipe.RecipeChangePmt:=DB1100_Control.Mode.Status.ManualMode ;

//配方提取
DB1102_Recipe.TypeDataCur:=DB1102_Recipe.TypeData[DB1102_Recipe.RecipeNum];


IF RecipeNum<>DB1102_Recipe.RecipeNumTemp THEN
	DB1102_Recipe.RecipeNameTemp:=DB1102_Recipe.TypeData[DB1102_Recipe.RecipeNumTemp].Name;
	RecipeNum:=DB1102_Recipe.RecipeNumTemp;
END_IF

DownLoad_R(CLK:= DB1102_Recipe.DownLoad);
DownLoad_F(CLK:= DB1102_Recipe.DownLoad);
ACT_Download();
ACT_Upload();

