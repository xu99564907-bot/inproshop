FUNCTION FC_StringSplit: BOOL
VAR_INPUT
	iSTR:STRING;//输入
	iCharSplit:STRING;//分割符
END_VAR
VAR_OUTPUT
	QSTR:ARRAY[0..10] OF STRING;//输出结果
END_VAR
VAR
	i:INT;//用于循环变量
	j:INT;//用于循环变量
	TotalCount:INT;
	tempIStr:STRING;
END_VAR

//string数据分解
j:=0; 
TotalCount:=0;
TotalCount:=LEN(iSTR); //获取字符串长度
FOR i:=0 TO 10 BY 1 DO//字符串数组清空
	ClearString(QStr[i]);
END_FOR;
ClearString(tempIStr); 
IF TotalCount<>0 THEN
		FOR i:=0 TO TotalCount   BY 1 DO
				tempIStr:=MID(iSTR,1,i);//提取字符
				IF tempIStr <> iCharSplit THEN  //分割条件
						QStr[j]:=CONCAT(QStr[j],tempIStr);//拼接字符  
				ELSE
						j:=j+1; 
				END_IF;  
		END_FOR;
		FC_StringSplit:=TRUE;
ELSE
	FC_StringSplit:=FALSE;
END_IF;

