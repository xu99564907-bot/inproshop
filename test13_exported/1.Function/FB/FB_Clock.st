FUNCTION_BLOCK FB_Clock
VAR_INPUT
	iEnable:BOOL;
	iClock:UINT;
END_VAR
VAR_OUTPUT
	o_Clock:BOOL;
END_VAR
VAR
	tempNumber:UINT;
END_VAR

IF iEnable THEN
	IF iClock =1 THEN
		IF o_Clock THEN
			o_Clock:=FALSE;
		ELSE
			o_Clock:=TRUE;
		END_IF	
	ELSE
		tempNumber:=tempNumber+1;
	
		IF tempNumber>0 AND tempNumber <=iClock THEN
			o_Clock:=FALSE;
		ELSIF tempNumber>iClock AND tempNumber<=iClock*2-1 THEN
			o_Clock:=TRUE;
		ELSE
			tempNumber:=0;
		END_IF
	END_IF
ELSE
	o_Clock:=FALSE;		
END_IF
