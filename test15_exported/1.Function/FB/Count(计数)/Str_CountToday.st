TYPE Str_CountToday :
STRUCT
	Total:UINT;//总计数
	Night:UINT;//夜班计数
	Day:UINT;//白班计数
	Hour:ARRAY[0..23] OF UINT;//小时计数
	TimeOfHour:ARRAY[0..23] OF UINT;//HMI显示小时
	TimeOfMinu:UINT;//HMI显示分钟
END_STRUCT
END_TYPE
