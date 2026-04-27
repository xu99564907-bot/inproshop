FUNCTION_BLOCK FB_Count
VAR_IN_OUT
	ioCount:Str_Count;
END_VAR
VAR_INPUT
	iClock:Str_Clock;//系统时钟
	iDayStartTime:STRING;//白班开始时间
	iNightStartTime:STRING;//夜班开始时间
END_VAR
VAR RETAIN PERSISTENT
	Day:BOOL;//白班状态
	Night:BOOL;//夜班状态
	DateTime:_sDT;//日期记录
END_VAR
VAR
	i:UINT;//循环变量用
	j:UINT;//循环变量用
	Day_F:F_TRIG;//白班状态下降沿
	Night_F:F_TRIG;//夜班状态下降沿
	TempDayStartTimeHour:UINT;//白班开始时间-小时
	TempDayStartTimeMin:UINT;//白班开始时间-分钟
	TempNightStartTimeHour:UINT;//夜班班开始时间-小时
	TempNightStartTimeMin:UINT;//夜班开始时间-分钟
	TempHours:UINT;//当天的第几个小时
	TempDayPowerOFF:UINT;//距离上次断电几天
	TempSTR:ARRAY[0..10] OF STRING;//计算开始时间用
END_VAR

(*********************************************)
//白班计数ioCount.Today.Hour[0]-[11]
//夜班计数ioCount.Today.Hour[12]-[23]

(*
*******20250912更新******
1、优化计数清零时间点条件
2、增加非整点开班时间点(例:8:30-8:30),触摸屏分时时间点跟随变化
3、增加历史日期计算显示，保存30天每天生产总数
*)

//上电第1个扫描周期
IF iClock.FirstRun THEN

	//解析白夜班开始时间
	FC_StringSplit(iSTR:= iDayStartTime, iCharSplit:= ':', QSTR=>TempSTR);
	TempDayStartTimeHour:=STRING_TO_UINT(TempSTR[0]);
	TempDayStartTimeMin:=STRING_TO_UINT(TempSTR[1]);
	FC_StringSplit(iSTR:= iNightStartTime, iCharSplit:= ':', QSTR=>TempSTR);
	TempNightStartTimeHour:=STRING_TO_UINT(TempSTR[0]);
	TempNightStartTimeMin:=STRING_TO_UINT(TempSTR[1]);
	
	//计算触摸屏计数分时显示时间
	FOR i:=0 TO 23 BY 1 DO
		ioCount.Today.TimeOfHour[i]:=TempDayStartTimeHour+i;
		IF ioCount.Today.TimeOfHour[i]>23 THEN
			ioCount.Today.TimeOfHour[i]:=ioCount.Today.TimeOfHour[i]-24;
		END_IF
	END_FOR
	ioCount.Today.TimeOfMinu:=TempDayStartTimeMin;
	TempNightStartTimeMin:=TempDayStartTimeMin;//强制夜班开始时间的分钟与白班一致
	
	//计算与上次断电时间间隔几天-最大一个月
	FOR i:=0 TO 30 BY 1 DO//判断断电前记忆日期与前30天日期是否有相等的
		IF DateTime.uiYear=iClock.DateOld[i].uiYear
			AND DateTime.uiMonth=iClock.DateOld[i].uiMonth 
			AND DateTime.uiDay=iClock.DateOld[i].uiDay THEN
			TempDayPowerOFF:=i;
			EXIT;
		ELSE
			TempDayPowerOFF:=31;
		END_IF;
	END_FOR
	
	//上电时间点在凌晨00:00到开班前的计算的断电天数-1
	IF iClock.DataToday.uiHour < TempDayStartTimeHour 
		OR (iClock.DataToday.uiHour = TempDayStartTimeHour AND iClock.DataToday.uiMinute < TempDayStartTimeMin)  THEN
		TempDayPowerOFF:=TempDayPowerOFF-1;
	END_IF

END_IF

//上电第二个扫描周期后记录当前时间
IF NOT iClock.FirstRun THEN
	DateTime:=iClock.DataToday;
END_IF;


//当天第几个小时计算
IF iClock.DataToday.uiHour < TempDayStartTimeHour 
	OR (iClock.DataToday.uiHour = TempDayStartTimeHour AND iClock.DataToday.uiMinute < TempDayStartTimeMin)  THEN//过零点后+24再计算
	IF iClock.DataToday.uiMinute >= TempDayStartTimeMin THEN
		TempHours:=iClock.DataToday.uiHour-TempDayStartTimeHour+24;
	ELSE
		TempHours:=iClock.DataToday.uiHour-TempDayStartTimeHour+23;
			
	END_IF
ELSE
	IF iClock.DataToday.uiMinute >= TempDayStartTimeMin THEN
		TempHours:=iClock.DataToday.uiHour-TempDayStartTimeHour;
	ELSE
		TempHours:=iClock.DataToday.uiHour-TempDayStartTimeHour-1;			
	END_IF		
END_IF
//计数
IF ioCount.Execute THEN
	ioCount.Execute:=FALSE;//计数标志位复位
	//每小时计数
	FOR i:=0 TO 23 BY 1 DO		
		IF TempHours = i THEN
			ioCount.Today.Hour[i]:=ioCount.Today.Hour[i]+ioCount.Num;
		END_IF;
	END_FOR;

	//当日产量总计
	ioCount.Today.Total:=ioCount.Today.Total+ioCount.Num;
	
	//白夜班计数&当天产量计数
	IF Day THEN
		ioCount.Today.Day:=ioCount.Today.Day+ioCount.Num;//白班总计		
	ELSIF Night THEN
		ioCount.Today.Night:=ioCount.Today.Night+ioCount.Num;//夜班总计
	END_IF;
	
	//总产量计数
	ioCount.Total:=ioCount.Total+ioCount.Num;
	
	//历史产量计数
	ioCount.Befor[0]:=ioCount.Befor[0]+ioCount.Num;
END_IF;

//一键清零
IF ioCount.Clear THEN
	FOR i:=0 TO 23 BY 1 DO
			ioCount.Today.Hour[i]:=0;
	END_FOR;	
	ioCount.Today.Day:=0;
	ioCount.Today.Night:=0;
	ioCount.Today.Total:=0;
END_IF;

//当班产量自动清零
//白班清零
//清零条件:夜班下降沿 OR 记录日期不是当前日期
IF Night_F.Q OR TempDayPowerOFF > 0 THEN
	ioCount.Today.Day:=0;
	ioCount.Today.Total:=0;
	FOR i:= 0 TO 11 BY 1 DO		
			ioCount.Today.Hour[i]:=0;
	END_FOR;	
	IF Night_F.Q THEN
		TempDayPowerOFF:=1;
	END_IF
	FOR i:=1 TO TempDayPowerOFF BY 1 DO
		FOR j:=30 TO 1 BY -1 DO
			ioCount.Befor[j]:=ioCount.Befor[j-1];
		END_FOR;
		ioCount.Befor[0]:=0;
	END_FOR
		
	//前31天时间计算
	IF iClock.DataToday.uiHour < TempDayStartTimeHour 
		OR (iClock.DataToday.uiHour = TempDayStartTimeHour AND iClock.DataToday.uiMinute < TempDayStartTimeMin) THEN
		FC_SysTime(iNow:= iClock.DateOld[1], ioBefor:=ioCount.DateBefor );
	ELSE
		FC_SysTime(iNow:= iClock.DataToday, ioBefor:=ioCount.DateBefor );
	END_IF
	
END_IF;

//夜班清零
//清零条件:
//白班下降沿 OR 记录日期不是当前日期 AND (日期不是昨天日期 OR 时间大于夜班开始时间)
IF Day_F.Q 
	OR TempDayPowerOFF > 1
	OR (TempDayPowerOFF = 1 AND (iClock.DataToday.uiHour>TempNightStartTimeHour OR (iClock.DataToday.uiHour=TempNightStartTimeHour AND iClock.DataToday.uiMinute>=TempNightStartTimeMin))) THEN
	ioCount.Today.Night:=0;
	FOR i:= 12 TO 23 BY 1 DO
			ioCount.Today.Hour[i]:=0;
	END_FOR;
END_IF;

//获取白夜班状态
Day_F(CLK:=Day);
Night_F(CLK:=Night);
IF (iClock.DataToday.uiHour > TempDayStartTimeHour AND iClock.DataToday.uiHour < TempNightStartTimeHour)
	OR (iClock.DataToday.uiHour = TempDayStartTimeHour AND iClock.DataToday.uiMinute>=TempDayStartTimeMin)
	OR (iClock.DataToday.uiHour = TempNightStartTimeHour AND iClock.DataToday.uiMinute<TempNightStartTimeMin)  THEN
	Day:=TRUE;
	Night:=FALSE;
ELSE
	Day:=FALSE;
	Night:=TRUE;	
END_IF;
//断电天数清零
TempDayPowerOFF:=0;
