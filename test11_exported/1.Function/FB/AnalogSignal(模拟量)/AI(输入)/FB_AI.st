FUNCTION_BLOCK FB_AI
VAR_INPUT
	iValueInput:INT;//输入值
	iADMin:INT;//取值范围的下限
	iADMax:INT;//取值范围的上限
	iUserMin:REAL;//实际值下限
	iUserMax:REAL;//实际值上限	
END_VAR
VAR_IN_OUT
	ioAI:Str_AI;
END_VAR
VAR_OUTPUT
	oValueUser:REAL;//输出用户值
	oError:BOOL;//报错，数值输入异常
END_VAR
VAR RETAIN PERSISTENT
	TeachValue:INT;//校准偏移值
	TeachOK:BOOL;//校准OK
END_VAR

//数值异常复位值，报错提示，退出计算
IF iValueInput<iADMin OR iValueInput>iADMax THEN
	oError:=TRUE;
	oValueUser:=0;
	ioAI.Status.UserData:=0;
	RETURN;
END_IF

//报错复位
oError:=FALSE;
//偏移示教
IF ioAI.Cmd.Teach THEN
	TeachValue:=REAL_TO_INT( ioAI.Parm.ValueTeach*(iADMax-iADMin)/(iUserMax-iUserMin))-iValueInput;
	ioAI.Cmd.Teach:=FALSE;
END_IF

//输出值计算
IF TeachOK THEN	
	oValueUser:=(INT_TO_REAL(iValueInput-iADMin-TeachValue)/INT_TO_REAL(iADMax-iADMin))*(iUserMax-iUserMin)+iUserMin;
ELSE
	oValueUser:=(INT_TO_REAL(iValueInput-iADMin)/INT_TO_REAL(iADMax-iADMin))*(iUserMax-iUserMin)+iUserMin;
END_IF

//映射
ioAI.Status.TeachValue:=TeachValue;
ioAI.Status.TeachOK:=TeachOK;
ioAI.Status.UserData:=oValueUser;