FUNCTION FC_SysTime : BOOL
VAR_INPUT
	iNow:_sDT;
END_VAR
VAR_IN_OUT
	ioBefor:ARRAY[0..30]OF _sDT;
END_VAR
VAR
	i:UINT;
	uiMonth: INT;
END_VAR


ioBefor[0]:=iNow;
FOR i:=1 TO 30 BY 1 DO
	ioBefor[i]:=ioBefor[i-1];
	ioBefor[i].uiDay:=ioBefor[i-1].uiDay-1;

	IF ioBefor[i].uiDay=0 THEN
		CASE ioBefor[i-1].uiMonth OF 
			1:
				ioBefor[i].uiDay:=31;
				ioBefor[i].uiMonth:=12;
				ioBefor[i].uiYear:=ioBefor[i-1].uiYear-1;
			2:
				ioBefor[i].uiDay:=31;
				ioBefor[i].uiMonth:=1;
			3:
				IF (ioBefor[i].uiYear MOD 4)=0 THEN
					ioBefor[i].uiDay:=29;
					ioBefor[i].uiMonth:=2;
				ELSE
					ioBefor[i].uiDay:=28;
					ioBefor[i].uiMonth:=2;	
				END_IF				
			4:
				ioBefor[i].uiDay:=31;
				ioBefor[i].uiMonth:=3;
			5:
				ioBefor[i].uiDay:=30;
				ioBefor[i].uiMonth:=4;
			6:
				ioBefor[i].uiDay:=31;
				ioBefor[i].uiMonth:=5;
			7:
				ioBefor[i].uiDay:=30;
				ioBefor[i].uiMonth:=6;
				
			8:
				ioBefor[i].uiDay:=31;
				ioBefor[i].uiMonth:=7;
				
			9:
				ioBefor[i].uiDay:=31;
				ioBefor[i].uiMonth:=8;
				
			10:
				ioBefor[i].uiDay:=30;
				ioBefor[i].uiMonth:=9;
				
			11:
				ioBefor[i].uiDay:=31;
				ioBefor[i].uiMonth:=10;
				
			12:
				ioBefor[i].uiDay:=30;
				ioBefor[i].uiMonth:=11;

		END_CASE
		
	END_IF
	ioBefor[i].uiDayOfWeek:=0;
	ioBefor[i].uiHour:=0;
	ioBefor[i].uiMinute:=0;
	ioBefor[i].uiSecond:=0;
	ioBefor[i].uiMillisecond:=0;
END_FOR





