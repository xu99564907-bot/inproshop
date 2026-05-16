PROGRAM OP70_Communication
VAR
	OP08HeartdelayON:TON;
	OP08HeartdelayOFF:TON;
	MasterHeartdelayON:TON;
	MasterHeartdelayOFF:TON;	
END_VAR


//心跳输出
IF CPU_Clock.Clock_1s THEN
	DB7005_Communication.TO_OPXX.Heart:=1;
ELSE
	DB7005_Communication.TO_OPXX.Heart:=0;
END_IF

OP08HeartdelayON(IN:= DB7005_Communication.From_OPXX.Heart=1, PT:= T#2S, Q=> , ET=> );
OP08HeartdelayOFF(IN:= DB7005_Communication.From_OPXX.Heart=0, PT:= T#2S, Q=> , ET=> );

//前站掉线报警
IF (OP08HeartdelayON.Q OR OP08HeartdelayOFF.Q) AND NOT DB7000_Control.Mode.Status.OfflineMode  THEN
	DB7070_Fault.Stop.BeforStation_Communication_Rrror:=TRUE;
END_IF

 
//主站心跳通讯检测
MasterHeartdelayON(IN:= DB7005_Communication.FromMaster.Heart=1, PT:= T#2S, Q=> , ET=> );
MasterHeartdelayOFF(IN:= DB7005_Communication.FromMaster.Heart=0, PT:= T#2S, Q=> , ET=> );
//主站掉线报警
IF (MasterHeartdelayON.Q OR MasterHeartdelayOFF.Q) AND NOT DB7000_Control.Mode.Status.OfflineMode  THEN
	DB7070_Fault.Stop.MasterTimeOut:=TRUE;
END_IF

//与主站配方不一致报警
IF DB7005_Communication.FromMaster.MasterRecipeID<>DB7002_Recipe.RecipeNum AND NOT DB7000_Control.Mode.Status.OfflineMode THEN
	DB7070_Fault.Stop.MaterReipeDiscrepancy:=TRUE;
END_IF







