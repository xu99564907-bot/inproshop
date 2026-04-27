PROGRAM OP11_Fault
VAR
	i:UINT;//循环变量用
	Pobool_IN: POINTER TO BOOL;//输入报警指针地址获取；
	Pobool_OUT: POINTER TO BOOL;//输出报警指针地址获取；
	EstopMAP:ARRAY[0..255] OF BOOL;
	StopMAP:ARRAY[0..999] OF BOOL;
	RunMAP:ARRAY[0..255] OF BOOL;
	Size:UINT;//数组数量
	Estop_R:R_TRIG;//急停上升沿
	Stop_R:R_TRIG;//暂停上升沿
	Run_R:R_TRIG;//警告上升沿
	StopFaultDelay:ARRAY[1..10]OF TON;//停止报警延时
END_VAR




//气缸报警地址映射
SizeOfAry(In:=DB1150_DriveControl.CylCtrl,Out=>Size);
FOR i:=0 TO Size-1 BY 1 DO
	DB1170_Fault.Stop.Cyl[I]:=DB1150_DriveControl.CylCtrl[i].Status.Error;
END_FOR
//真空报警映射
SizeOfAry(In:=DB1150_DriveControl.VacCtrl,Out=>Size);
FOR i:=0 TO Size-1 BY 1 DO
	DB1170_Fault.Stop.Vac[I]:=DB1150_DriveControl.VacCtrl[i].Status.Error;
END_FOR
//轴报警映射
SizeOfAry(In:=DB1150_DriveControl.AxisCtrl,Out=>Size);
FOR i:=0 TO Size-1 BY 1 DO
	DB1170_Fault.Stop.Axis[I]:=DB1150_DriveControl.AxisCtrl[i].Status.Error;
END_FOR


//急停报警
DB1170_Fault.Estop.EstopButton:=NOT DB1100_Control.Machine.EmgSafetyRelay;

//暂停故障
 
DB1170_Fault.Stop.SafeDoorOpen:=NOT DB1100_Control.Machine.SafetyDoorRelay;
 
  


//提示
 


ACT_MAP();
ACT_HMI_Jump();


