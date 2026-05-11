FUNCTION FC_WStringSplit:ARRAY[0..10] OF WSTRING
VAR_INPUT
	iwSTR:WSTRING;//输入1
	CharSplit:WSTRING;//分割符
END_VAR
VAR_OUTPUT
	QSTR1:ARRAY[0..10] OF WSTRING;//输出结果
END_VAR
VAR
	i:INT;//用于循环变量
	j:INT;//用于循环变量
	Temp_wSTR:ARRAY[0..100] OF Str_WstringWord;
END_VAR

//wstring 变量合并
j:=0;
FOR i:=0 TO 20 BY 1 DO
	QSTR1[i]:="";
END_FOR
FOR i:=0 TO 80 BY 1 DO
	Temp_wSTR[i].Wo:=iwSTR[i];
	IF Temp_wSTR[i].Ws<> "" THEN
		IF Temp_wSTR[i].Ws = CharSplit THEN
			j:=j+1;
		ELSE
			QSTR1[j]:=FC_LCONCAT(QSTR1[j],Temp_wSTR[i].Ws);		
		END_IF
		;
	ELSE
		EXIT;
	END_IF
END_FOR