PROGRAM OP70_Recipe
VAR
	i:INT;
	DownLoad_R:R_TRIG;
	Download_F:F_TRIG;
	Change:R_TRIG;
END_VAR
VAR RETAIN PERSISTENT
	RecipeNum AT %MB131080 : INT;
END_VAR

//配方名
DB7002_Recipe.RecipeName:=DB7002_Recipe.TypeData[DB7002_Recipe.RecipeNum].Name;

//主线一键切换
IF DB7005_Communication.FromMaster.OnLineMode=1 THEN
	DB7002_Recipe.RecipeNumTemp:=DB7005_Communication.FromMaster.RecipeID;
END_IF

//配方参数修改使能
IF DB7002_Recipe.RecipeNum=DB7002_Recipe.RecipeNumTemp THEN
	DB7002_Recipe.ParameterChangePmt:=TRUE;
ELSE
	DB7002_Recipe.ParameterChangePmt:=FALSE;
END_IF

//配方允许切换使能
DB7002_Recipe.RecipeChangePmt:=DB7000_Control.Mode.Status.ManualMode OR DB7005_Communication.FromMaster.OnLineMode=1;

//配方名称获取
IF RecipeNum<>DB7002_Recipe.RecipeNumTemp THEN
	DB7002_Recipe.RecipeNameTemp:=DB7002_Recipe.TypeData[DB7002_Recipe.RecipeNumTemp].Name;
	RecipeNum:=DB7002_Recipe.RecipeNumTemp;
END_IF

DownLoad_R(CLK:= DB7002_Recipe.DownLoad OR (DB7005_Communication.FromMaster.OnLineMode=1 AND DB7005_Communication.FromMaster.RecipeDownLoad=1));
DownLoad_F(CLK:= DB7002_Recipe.DownLoad OR (DB7005_Communication.FromMaster.OnLineMode=1 AND DB7005_Communication.FromMaster.RecipeDownLoad=1));
ACT_Upload();
ACT_Download();

//一键切换配方时，从站退出初始化完成状态
IF DB7005_Communication.FromMaster.OnLineMode=1 AND DB7005_Communication.FromMaster.RecipeDownLoad=1 THEN
	DB7000_Control.Mode.Status.HomeOK:=FALSE;
	DB7000_Control.Mode.Status.AutoRunning:=FALSE;
END_IF



