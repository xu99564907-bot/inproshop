
//16#04&16#10报文

//H04报文
// 报文格式：
// 请求报文：
// 事务处理标识符（Transaction Identifier）：用于配对请求和响应，通常是一个 16 位的无符号整数。不同的请求有不同的事务处理标识符，由主站生成。
// 协议标识符（Protocol Identifier）：一般设置为 0，表示是 Modbus 协议，也是 16 位无符号整数。
// 长度（Length）：表示后续字节的长度，包括单元标识符、功能码和数据部分。
// 单元标识符（Unit Identifier）：用于识别从站设备，每个从站有一个唯一的标识符，通常是 1 个字节。
// 功能码（Function Code）：0x04，表示读取输入寄存器。
// 起始地址（Starting Address）：指定要读取的输入寄存器的起始地址，是 16 位无符号整数。
// 寄存器数量（Quantity of Registers）：指定要读取的输入寄存器的数量，也是 16 位无符号整数。


// Modbus 功能码 10（写多个寄存器）
// 用途：
// 用于主站向从站设备的保持寄存器写入多个连续的值。这些保持寄存器可以用于配置设备参数、控制设备输出等多种用途。
// 报文格式：
// 请求报文：
// 事务处理标识符、协议标识符、长度和单元标识符的含义与功能码 04 中的类似。
// 功能码（Function Code）：0x10，表示写多个寄存器。
// 起始地址（Starting Address）：指定要写入的保持寄存器的起始地址，16 位无符号整数。
// 寄存器数量（Quantity of Registers）：指定要写入的保持寄存器的数量，16 位无符号整数。
// 字节数（Byte Count）：表示后续要写入的寄存器数据的字节数，因为每个寄存器是 16 位（2 字节），所以字节数是寄存器数量 ×2。
// 寄存器值（Register Values）：按照顺序包含要写入的寄存器的值，每个值占 2 字节。

//IP地址，端口号映射
TcpClient.DstAdr:=iDstAdr;
TcpClient.DstTcpPort:=iDstTcpPort;

//事务处理标识符、协议标识符和单元标识符
bySendData[0]:=16#00;
bySendData[1]:=16#00;//事务处理标识符
bySendData[2]:=16#00;
bySendData[3]:=16#00;//协议标识符
bySendData[6]:=16#00;//单元标识符


//功能码切换
IF change=0  THEN//读保持寄存器数据16个字
	bySendData[7]:=16#03;
	bySendData[4]:=16#00;
	bySendData[5]:=16#05;
	bySendData[8]:=16#00;
	bySendData[9]:=16#10;//起始地址
	bySendData[10]:=16#00;
	bySendData[11]:=16#10;//寄存器数量
	TcpClient.SendSize:=12;
ELSIF change=1  THEN//写保持寄存器数据16个字
	bySendData[7]:=16#10;
	bySendData[4]:=16#00;
	bySendData[5]:=16#86;
	bySendData[8]:=16#00;
	bySendData[9]:=16#00;//起始地址
	bySendData[10]:=16#00;
	bySendData[11]:=16#10;//寄存器数量
	bySendData[12]:=16#20;//字节数量
	TcpClient.SendSize:=45;
ELSIF change=2  THEN//读连续线圈
	bySendData[7]:=16#01;
	bySendData[4]:=16#00;
	bySendData[5]:=16#05;
	bySendData[8]:=16#01;
	bySendData[9]:=16#00;//起始地址
	bySendData[10]:=16#01;
	bySendData[11]:=16#00;//寄存器数量
 	TcpClient.SendSize:=12;
ELSIF change=3  THEN//写多个线圈
	bySendData[7]:=16#0F;
	bySendData[4]:=16#00;
	bySendData[5]:=16#25;
	bySendData[8]:=16#00;
	bySendData[9]:=16#00;//起始地址
	bySendData[10]:=16#01;
	bySendData[11]:=16#00;//寄存器数量
	bySendData[12]:=16#20;//字节数量
	TcpClient.SendSize:=45;
END_IF

//发送内容映射
TcpClient.SendDat:=bySendData;

//通讯读写控制
// IF iEnable THEN
// 	ioTcpClient.Enable:=TRUE;
// END_IF
FB_TcpClient_instance(ioTcpClient:= TcpClient);


//接收数据地址映射
byRevData:=TcpClient.RcvDat;


//循环触发读写
//间隔时间
//TimeDelayExcute(IN:= NOT ioTcpClient.Execute AND ioTcpClient.Active, PT:= T#1S,);
TcpClient.Execute:=iClock AND TcpClient.Active;
TimeDelayExcute_R(CLK:= TcpClient.Execute);

IF TimeDelayExcute_R.Q THEN
	change:=change+1;
	IF change>=4 THEN
		change:=0;
	END_IF
END_IF

//连接异常
TimeOutDelay(IN:= (NOT TcpClient.Active AND TcpClient.Enable)OR TcpClient.RcvSize<>16#0C, PT:= T#2S, Q=> oTimeOut);
EnableDelay(IN:= NOT TcpClient.Enable, PT:= T#1S);
IF iMode.Out.ErrorReset AND oTimeOut  THEN
	TcpClient.Enable:=FALSE;
ELSIF EnableDelay.Q THEN
	TcpClient.Enable:=TRUE;
END_IF