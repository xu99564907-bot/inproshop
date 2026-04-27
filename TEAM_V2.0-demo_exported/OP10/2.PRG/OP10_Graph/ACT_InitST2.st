
//延时时间
IntitalTimeDelay[2,0](IN:=Init[2].Step=5,PT:=T#500MS);
IntitalTimeDelay[2,1]();
IntitalTimeDelay[2,2]();
IntitalTimeDelay[2,3]();
IntitalTimeDelay[2,4]();
IntitalTimeDelay[2,5]();

//初始化完成状态清除
IF DB1070_Fault.EstopTotal OR DB1070_Fault.StopTotal OR DB1000_Control.Mode.Status.ManualMode OR DB1000_Control.Mode.Out.Stop THEN
	Init[2].Step:=0;
	Init[2].Running:=FALSE;
END_IF

//启动回原
IF DB1000_Control.Mode.Out.HomeStart_R AND NOT Init[2].Running THEN
	Init[2].Running:=TRUE;
	Init[2].Complete:=FALSE;
	Init[2].Step:=5;
	Init[2].Comment:="初始化开始";
END_IF

IF Init[2].Running THEN
	
	CASE Init[2].Step OF
		5 :
			Init[2].Comment:="初始化开始判定";
			IF IntitalTimeDelay[2,0].Q THEN
				IF Auto[2].Disable THEN
					Init[2].Step:=1000;
				ELSE
					Init[2].Step:=10;
				END_IF		
			END_IF
						
		10:
			Init[2].Comment:=" ";
			IF TRUE THEN
				Init[2].Step:=100;
			END_IF

			
		100:
			Init[2].Comment:=" ";
			 
			IF TRUE THEN
				Init[2].Step:=110;
			END_IF
			
		110:			
			Init[2].Comment:=" ";
			 
			IF TRUE THEN
				Init[2].Step:=1000;
			END_IF	
			
	 
		
		1000:
			Init[2].Comment:="工位初始化完成，等待下工位完成";
			Init[2].Running:=FALSE;
			Init[2].Complete:=TRUE;
			Init[2].Step:=0;
			
	ELSE
		;
	END_CASE
	
END_IF

















