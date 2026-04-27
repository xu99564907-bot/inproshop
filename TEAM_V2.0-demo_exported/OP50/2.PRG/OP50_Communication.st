PROGRAM OP50_Communication
VAR
	HeartdelayON:TON;
	HeartdelayOFF:TON;
	MasterHeartdelayON:TON;
	MasterHeartdelayOFF:TON;
END_VAR


//心跳输出
IF CPU_Clock.Clock_1s THEN
	DB5005_Communication.TO_OPXX.Heart:=1;
ELSE
	DB5005_Communication.TO_OPXX.Heart:=0;
END_IF
//给前站安全信号
IF TRUE THEN
	DB5005_Communication.TO_OPXX.Safe:=1;
ELSE
	DB5005_Communication.TO_OPXX.Safe:=0;
END_IF;


HeartdelayON(IN:= DB5005_Communication.From_OPXX.Heart=1, PT:= T#2S, Q=> , ET=> );
HeartdelayOFF(IN:= DB5005_Communication.From_OPXX.Heart=0, PT:= T#2S, Q=> , ET=> );
//前站掉线报警
IF (HeartdelayON.Q OR HeartdelayOFF.Q) AND NOT DB5000_Control.Mode.Status.OfflineMode  THEN
	DB5070_Fault.Stop.BeforStation_Communication_Rrror:=TRUE;
END_IF

//主站心跳通讯检测
MasterHeartdelayON(IN:= DB5005_Communication.FromMaster.Heart=1, PT:= T#2S, Q=> , ET=> );
MasterHeartdelayOFF(IN:= DB5005_Communication.FromMaster.Heart=0, PT:= T#2S, Q=> , ET=> );
//主站掉线报警
IF (MasterHeartdelayON.Q OR MasterHeartdelayOFF.Q) AND NOT DB5000_Control.Mode.Status.OfflineMode  THEN
	DB5070_Fault.Stop.MasterTimeOut:=TRUE;
END_IF

//与主站配方不一致报警
IF DB5005_Communication.FromMaster.MasterRecipeID<>DB5002_Recipe.RecipeNum AND NOT DB5000_Control.Mode.Status.OfflineMode THEN
	DB5070_Fault.Stop.MaterReipeDiscrepancy:=TRUE;
END_IF

 