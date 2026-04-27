FUNCTION FC_LCONCAT : WSTRING//最终结果字符数量小于80
VAR_INPUT
	iSTR1:WSTRING;//输入1
	iSTR2:WSTRING;//输入2
END_VAR
VAR
	Num:INT;//用于循环变量
	Temp_Len:INT;//输入1字符串长度(偶数个)
	Temp_STR1:POINTER TO WSTRING;
	Temp_STR2:POINTER TO WSTRING;
	Temp_LCONCAT:POINTER TO WSTRING;
	
END_VAR

//wstring 变量合并
Temp_STR1:=ADR(iSTR1);//获取输入1地址
FOR Num:= 0 TO 80 BY 2 DO
	Temp_STR2:= Temp_STR1+INT_TO_DWORD(Num);
	IF Temp_STR2^="" THEN
		Temp_Len:=Num;//获取输入1长度
		EXIT;
	END_IF
END_FOR
Temp_LCONCAT:=ADR(FC_LCONCAT);
Temp_STR2:=Temp_LCONCAT+INT_TO_DWORD(Temp_Len);//获取输入2字符串存放开始地址
Temp_LCONCAT^:=iSTR1;//输入1字符串存放到对应地址
Temp_STR2^:=iSTR2;//输入2字符串存放到对应地址
