PROGRAM OP11_Communication
VAR
	HeartdelayON:TON;
	HeartdelayOFF:TON;
	MasterHeartdelayON:TON;
	MasterHeartdelayOFF:TON;	
END_VAR


//心跳输出
IF CPU_Clock.Clock_1s THEN
	DB1105_Communication.TO_OPXX.Heart:=1;
ELSE
	DB1105_Communication.TO_OPXX.Heart:=0;
END_IF
//给前站安全信号
IF TRUE THEN
	DB1105_Communication.TO_OPXX.Safe:=1;
ELSE
	DB1105_Communication.TO_OPXX.Safe:=0;
END_IF;


HeartdelayON(IN:= DB1105_Communication.From_OPXX.Heart=1, PT:= T#2S, Q=> , ET=> );
HeartdelayOFF(IN:= DB1105_Communication.From_OPXX.Heart=0, PT:= T#2S, Q=> , ET=> );
//前站掉线报警
IF (HeartdelayON.Q OR HeartdelayOFF.Q) AND NOT DB1100_Control.Mode.Status.OfflineMode  THEN
	DB1170_Fault.Stop.BeforStation_Communication_Rrror:=TRUE;
END_IF

//主站心跳通讯检测
MasterHeartdelayON(IN:= DB1105_Communication.FromMaster.Heart=1, PT:= T#2S, Q=> , ET=> );
MasterHeartdelayOFF(IN:= DB1105_Communication.FromMaster.Heart=0, PT:= T#2S, Q=> , ET=> );
//主站掉线报警
IF (MasterHeartdelayON.Q OR MasterHeartdelayOFF.Q) AND NOT DB1100_Control.Mode.Status.OfflineMode  THEN
	DB1170_Fault.Stop.MasterTimeOut:=TRUE;
END_IF

//与主站配方不一致报警
IF DB1105_Communication.FromMaster.MasterRecipeID<>DB1102_Recipe.RecipeNum AND NOT DB1100_Control.Mode.Status.OfflineMode THEN
	DB1170_Fault.Stop.MaterReipeDiscrepancy:=TRUE;
END_IF
 