TYPE Str_Count :
STRUCT
	Execute:BOOL;//计数触发
	Clear:BOOL;//计数清除
	Num:UINT;//计数单次增加数量
	Total:UDINT;//总计数
	Today:Str_CountToday;//白班计数
	Befor:ARRAY[0..30] OF UINT;//前30天历史产量
	DateBefor:ARRAY[0..30] OF _sDT;//前30天日期
END_STRUCT
END_TYPE
