
//延时时间
IntitalTimeDelay[4,0](IN:=Init[4].Step=5,PT:=T#500MS);
IntitalTimeDelay[4,1]();
IntitalTimeDelay[4,2]();
IntitalTimeDelay[4,3]();
IntitalTimeDelay[4,4]();
IntitalTimeDelay[4,5]();

//初始化完成状态清除
IF DB1070_Fault.EstopTotal OR DB1070_Fault.StopTotal OR DB1000_Control.Mode.Status.ManualMode OR DB1000_Control.Mode.Out.Stop THEN
	Init[4].Step:=0;
	Init[4].Running:=FALSE;
END_IF

//启动回原
IF DB1000_Control.Mode.Out.HomeStart_R AND NOT Init[4].Running THEN
	Init[4].Running:=TRUE;
	Init[4].Complete:=FALSE;
	Init[4].Step:=5;
	Init[4].Comment:="初始化开始";
END_IF

IF Init[4].Running THEN
	
	CASE Init[4].Step OF
		5 :
			Init[4].Comment:="初始化开始判定";
			IF IntitalTimeDelay[4,0].Q THEN
				IF Auto[4].Disable THEN
					Init[4].Step:=1000;
				ELSE
					Init[4].Step:=10;
				END_IF		
			END_IF	
			
		10:
			Init[4].Comment:=" ";
			IF TRUE THEN
				Init[4].Step:=100;
			END_IF

			
		100:
			Init[4].Comment:=" ";
			 
			IF TRUE THEN
				Init[4].Step:=110;
			END_IF
			
		110:			
			Init[4].Comment:=" ";
			 
			IF TRUE  THEN
				Init[4].Step:=1000;
			END_IF	
		 
		
		
		1000:
			Init[4].Comment:="工位初始化完成，等待下工位完成";
			Init[4].Running:=FALSE;
			Init[4].Complete:=TRUE;
			Init[4].Step:=0;
	ELSE
		;
	END_CASE
	
END_IF

















