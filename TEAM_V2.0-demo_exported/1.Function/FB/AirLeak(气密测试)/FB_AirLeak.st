FUNCTION_BLOCK FB_AirLeak
VAR_INPUT
	iMode:Str_Mode;//设备模式
	iDstAdr:STRING;//远程IP地址
	iDstTcpPort:UINT;//远程端口号
	iSendData:STRING;//发送内容
END_VAR
VAR_IN_OUT
	ioAirLeak:Str_AirLeak;
END_VAR
VAR_OUTPUT
	oTimeOut:BOOL;//通讯连接超时
END_VAR
VAR
	i:INT;//循环变量
	FB_TcpClient_String_Instance:FB_TcpClient_String;
	TcpClient: Str_TcpClient_String;
	TimeOutDelay: TON;
	EnableDelay: TON;
	A_StartDelay:TON;
	B_StartDelay:TON;
	AForceAct:STRING;
	ALeakAct:STRING;
	BForceAct:STRING;
	BLeakAct:STRING;
	
	TestNum:STRING;
	TestTime:STRING;
	TestForce:STRING;
	LeakageValue:STRING;
END_VAR


//IP&端口号设定
TcpClient.DstAdr:=iDstAdr;//远程IP地址
TcpClient.DstTcpPort:=iDstTcpPort;//远程端口号

//发送内容
IF ioAirLeak.Cmd.A_Start AND NOT TcpClient.Execute AND B_StartDelay.Q  THEN
	TcpClient.Execute:=TRUE;
	ioAirLeak.Status.ADone:=FALSE;
	TcpClient.SendDat[0]:=16#02;
	TcpClient.SendDat[1]:=16#30;
	TcpClient.SendDat[2]:=16#30;
	TcpClient.SendDat[3]:=16#33;
	TcpClient.SendDat[4]:=16#41;
	TcpClient.SendDat[5]:=16#53;
	TcpClient.SendDat[6]:=16#54;
	TcpClient.SendDat[7]:=16#03;
	TcpClient.SendDat[8]:=16#74;		
	ClearString(TcpClient.RcvDat);
	ioAirLeak.Status.ABusy:=FALSE;
	ioAirLeak.Status.ADone:=FALSE;
	ioAirLeak.Cmd.A_Start:=FALSE;
ELSIF ioAirLeak.Cmd.B_Start AND NOT TcpClient.Execute AND A_StartDelay.Q THEN
	TcpClient.Execute:=TRUE;
	ioAirLeak.Status.ADone:=FALSE;
	TcpClient.SendDat[0]:=16#02;
	TcpClient.SendDat[1]:=16#30;
	TcpClient.SendDat[2]:=16#30;
	TcpClient.SendDat[3]:=16#33;
	TcpClient.SendDat[4]:=16#42;
	TcpClient.SendDat[5]:=16#53;
	TcpClient.SendDat[6]:=16#54;
	TcpClient.SendDat[7]:=16#03;
	TcpClient.SendDat[8]:=16#77;		
	ClearString(TcpClient.RcvDat);
	ioAirLeak.Status.BBusy:=FALSE;	
	ioAirLeak.Status.BDone:=FALSE;
	ioAirLeak.Cmd.B_Start:=FALSE;
END_IF

//AB两通道测试间隔
A_StartDelay(IN:= NOT ioAirLeak.Cmd.A_Start AND NOT TcpClient.Execute, PT:= T#500MS );
B_StartDelay(IN:= NOT ioAirLeak.Cmd.B_Start AND NOT TcpClient.Execute, PT:= T#500MS );

//通讯实例化
FB_TcpClient_String_Instance(ioTcpClient:= TcpClient);
//反馈数据更新
IF TcpClient.RcvDone THEN
	IF TcpClient.RcvDat[4]=16#41 AND TcpClient.RcvDat[7]=16#4F AND TcpClient.RcvDat[8]=16#4B THEN
		ioAirLeak.Status.ABusy:=TRUE;
	END_IF
	IF TcpClient.RcvDat[4]=16#42 AND TcpClient.RcvDat[7]=16#4F AND TcpClient.RcvDat[8]=16#4B THEN
		ioAirLeak.Status.BBusy:=TRUE;
	END_IF
	IF TcpClient.RcvDat[124] = 16#30 AND LEN(TcpClient.RcvDat) > 100 THEN
		ioAirLeak.Status.ADone:=TRUE;;
		ioAirLeak.Status.ABusy:=FALSE;
		//测试工位号
		ioAirLeak.Status.AResult.TestStation:=0;
		//测试结果
		ioAirLeak.Status.AResult.TestResult:=TcpClient.RcvDat[86]-16#30;
		//测试编号
		FOR i:=0 TO 4 BY 1 DO
			TestNum[i]:=TcpClient.RcvDat[i+7];;
		END_FOR
		//测试时间
		FOR i:=0 TO 13 BY 1 DO
			TestTime[i]:=TcpClient.RcvDat[i+12];;
		END_FOR		
		//测试压力
		FOR i:=0 TO 11 BY 1 DO
			TestForce[i]:=TcpClient.RcvDat[i+59];;
		END_FOR			
		//泄漏值
		FOR i:=0 TO 11 BY 1 DO
			LeakageValue[i]:=TcpClient.RcvDat[i+72];;
		END_FOR				
		ioAirLeak.Status.AResult.TestNum:=STRING_TO_REAL(TestNum);
		ioAirLeak.Status.AResult.TestTime:=STRING_TO_REAL(TestTime);
		ioAirLeak.Status.AResult.TestForce:=STRING_TO_REAL(TestForce);
		ioAirLeak.Status.AResult.LeakageValue:=STRING_TO_REAL(LeakageValue);
		ioAirLeak.Status.ADone:=TRUE;
	ELSIF TcpClient.RcvDat[124] = 16#31 AND LEN(TcpClient.RcvDat) > 100 THEN
		ioAirLeak.Status.BDone:=TRUE;;
		ioAirLeak.Status.BBusy:=FALSE;
		//测试工位号
		ioAirLeak.Status.BResult.TestStation:=1;
		//测试结果
		ioAirLeak.Status.BResult.TestResult:=TcpClient.RcvDat[86]-16#30;
		//测试编号
		FOR i:=0 TO 4 BY 1 DO
			TestNum[i]:=TcpClient.RcvDat[i+7];;
		END_FOR
		//测试时间
		FOR i:=0 TO 13 BY 1 DO
			TestTime[i]:=TcpClient.RcvDat[i+12];;
		END_FOR		
		//测试压力
		FOR i:=0 TO 11 BY 1 DO
			TestForce[i]:=TcpClient.RcvDat[i+59];;
		END_FOR			
		//泄漏值
		FOR i:=0 TO 11 BY 1 DO
			LeakageValue[i]:=TcpClient.RcvDat[i+72];;
		END_FOR	
		ioAirLeak.Status.BResult.TestNum:=STRING_TO_REAL(TestNum);
		ioAirLeak.Status.BResult.TestTime:=STRING_TO_REAL(TestTime);
		ioAirLeak.Status.BResult.TestForce:=STRING_TO_REAL(TestForce);
		ioAirLeak.Status.BResult.LeakageValue:=STRING_TO_REAL(LeakageValue);
		ioAirLeak.Status.BDone:=TRUE;
	END_IF
	
	//实时压力泄露值记录
	IF ioAirLeak.Status.ABusy THEN
		IF LEN(TcpClient.RcvDat)=61 THEN
			//A测试压力
			FOR i:=0 TO 11 BY 1 DO
				AForceAct[i]:=TcpClient.RcvDat[i+9];;
			END_FOR			
			//A泄漏值
			FOR i:=0 TO 11 BY 1 DO
				ALeakAct[i]:=TcpClient.RcvDat[i+21];;
			END_FOR						
		END_IF
		ioAirLeak.Status.AForceAct:=STRING_TO_REAL(AForceAct);
		ioAirLeak.Status.ALeakAct:=STRING_TO_REAL(ALeakAct);
	ELSE
		ClearString(AForceAct);
		ClearString(ALeakAct);
	END_IF
	IF ioAirLeak.Status.BBusy THEN
		IF LEN(TcpClient.RcvDat)=61 THEN		
			//B测试压力
			FOR i:=0 TO 11 BY 1 DO
				BForceAct[i]:=TcpClient.RcvDat[i+35];;
			END_FOR			
			//B泄漏值
			FOR i:=0 TO 11 BY 1 DO
				BLeakAct[i]:=TcpClient.RcvDat[i+47];;
			END_FOR		
		END_IF	
		ioAirLeak.Status.BForceAct:=STRING_TO_REAL(BForceAct);
		ioAirLeak.Status.BLeakAct:=STRING_TO_REAL(BLeakAct);
	ELSE
		ClearString(BForceAct);
		ClearString(BLeakAct);		
	END_IF	
END_IF


(****************通讯异常复位******************)
TimeOutDelay(IN:= NOT TcpClient.Active AND TcpClient.Enable, PT:= T#2S);//通讯异常延时
EnableDelay(IN:= NOT TcpClient.Enable, PT:= T#1S);//延时复位通讯

IF iMode.Out.ErrorReset AND oTimeOut  THEN
	TcpClient.Enable:=FALSE;
ELSIF EnableDelay.Q THEN
	TcpClient.Enable:=TRUE;
END_IF

//状态映射
ioAirLeak.Status.Active:=TcpClient.Active;


//连接异常
IF TimeOutDelay.Q THEN
	oTimeOut:=TRUE;
ELSE
	oTimeOut:=FALSE;
END_IF;

