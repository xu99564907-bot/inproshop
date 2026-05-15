TYPE Str_Clock :
STRUCT	
	DataToday:_sDT;//当天日期
	TimeMs:UDINT;//上电后累计时间ms
	FirstRun:BOOL;//上电第一扫描周期
	Clock_10ms:BOOL;//10毫秒脉冲
	Clock_50ms:BOOL;//50ms脉冲
	Clock_100ms:BOOL;//100毫秒脉冲
	Clock_500ms:BOOL;//500ms脉冲
	Clock_1s:BOOL;//1S脉冲
	Clock_10ms_R:BOOL;//10ms脉冲上升沿
	Clock_50ms_R:BOOL;//50ms脉冲上升沿
	Clock_100ms_R:BOOL;//100ms脉冲上升沿
	Clock_500ms_R:BOOL;//500ms脉冲上升沿
	Clock_1s_R:BOOL;//1S脉冲上升沿
	DateOld:ARRAY[0..30] OF _sDT;//过去31天时间
	DayStartTime:STRING := '8:00';//白班开始时间
	NightStartTime:STRING := '20:00';//夜班开始时间
	
END_STRUCT
END_TYPE
