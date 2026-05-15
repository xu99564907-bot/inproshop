
//延时时间
IntitalTimeDelay[3,0](IN:=Init[3].Step=5,PT:=T#500MS);
IntitalTimeDelay[3,1]();
IntitalTimeDelay[3,2]();
IntitalTimeDelay[3,3]();
IntitalTimeDelay[3,4]();
IntitalTimeDelay[3,5]();

//初始化完成状态清除
IF DB1070_Fault.EstopTotal OR DB1070_Fault.StopTotal OR DB1000_Control.Mode.Status.ManualMode OR DB1000_Control.Mode.Out.Stop THEN
	Init[3].Step:=0;
	Init[3].Running:=FALSE;
END_IF

//启动回原
IF DB1000_Control.Mode.Out.HomeStart_R AND NOT Init[3].Running THEN
	Init[3].Running:=TRUE;
	Init[3].Complete:=FALSE;
	Init[3].Step:=5;
	Init[3].Comment:="初始化开始";
END_IF

IF Init[3].Running THEN
	
	CASE Init[3].Step OF
		5 :
			Init[3].Comment:="初始化开始判定";
			IF IntitalTimeDelay[3,0].Q THEN
				IF Auto[3].Disable THEN
					Init[3].Step:=1000;
				ELSE
					Init[3].Step:=10;
				END_IF		
			END_IF
						
		10:
			Init[3].Comment:=" ";
			IF TRUE THEN
				Init[3].Step:=100;
			END_IF
			
		100:
			Init[3].Comment:=" ";
		 
			IF TRUE THEN
				Init[3].Step:=110;
			END_IF
			
		110:			
			Init[3].Comment:=" ";
			 
			IF TRUE THEN
				Init[3].Step:=1000;
			END_IF	
			
		 
		
		
		1000:
			Init[3].Comment:="工位初始化完成";
			Init[3].Running:=FALSE;
			Init[3].Complete:=TRUE;
			Init[3].Step:=0;
	ELSE
		;
	END_CASE
	
END_IF

















