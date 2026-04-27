
//延时时间
IntitalTimeDelay[1,0](IN:=Init[1].Step=5,PT:=T#500MS);
IntitalTimeDelay[1,1]();
IntitalTimeDelay[1,2]();
IntitalTimeDelay[1,3]();
IntitalTimeDelay[1,4]();
IntitalTimeDelay[1,5]();

//初始化完成状态清除
IF DB1070_Fault.EstopTotal OR DB1070_Fault.StopTotal OR DB1000_Control.Mode.Status.ManualMode OR DB1000_Control.Mode.Out.Stop THEN
	Init[1].Step:=0;
	Init[1].Running:=FALSE;
END_IF

//启动回原
IF DB1000_Control.Mode.Out.HomeStart_R AND NOT Init[1].Running THEN
	Init[1].Running:=TRUE;
	Init[1].Complete:=FALSE;
	Init[1].Step:=5;
	Init[1].Comment:="初始化开始";
END_IF

IF Init[1].Running THEN
	
	CASE Init[1].Step OF
		5 :
			Init[1].Comment:="初始化开始判定";
			IF IntitalTimeDelay[1,0].Q THEN
				IF Auto[1].Disable THEN
					Init[1].Step:=1000;
				ELSE
					Init[1].Step:=10;
				END_IF				
			END_IF

			
		10:
			Init[1].Comment:="";
			IF TRUE THEN
				Init[1].Step:=20;
			END_IF
						
		100:
			Init[1].Comment:=" ";
			 
			IF TRUE THEN
				Init[1].Step:=1000;
			END_IF
	
		
		1000:
			Init[1].Comment:="工位初始化完成，等待下工位完成";	
			Init[1].Complete:=TRUE;
			IF Init[1].Complete AND Init[2].Complete AND Init[3].Complete  AND Init[4].Complete  AND Init[5].Complete  AND Init[6].Complete THEN	
				DB1000_Control.Mode.Status.HomeOK:=TRUE;				
				Init[1].Running:=FALSE;
				Init[1].Step:=0;
			END_IF			
	ELSE
		;
	END_CASE
	
END_IF

















