PROGRAM OP50_DriveControl
VAR
	FB_Cylinder_instance :ARRAY[0..63]OF FB_Cylinder_V1;
	FB_Vacuum_instance :ARRAY[0..31]OF FB_Vacuum_V1;
	FB_Axis_Instance:ARRAY[0..31]OF FB_Axis_V1_3;
	FB_Sensor_instance :ARRAY[0..200]OF FB_Sensor_V1_1;
	FB_TcpClient_Instance:ARRAY[0..31]OF FB_TcpClient;
	FB_DoubleStart_Instance:ARRAY[1..4]OF FB_DoubleStart;	
	FB_Epson_V1_Instance:ARRAY[1..1]OF FB_Epson_V1;	
	FB_Kuka_V1_Instance:ARRAY[1..2]OF FB_Kuka6_V1;
	FB_Rotdisk_V1_Instance:ARRAY[1..1]OF FB_Rotdisk_V1;
	FB_Stopper_V1_Instance:ARRAY[1..1]OF FB_Stopper_V1;
	FB_Motor_Instance:ARRAY[1..1]OF FB_Motor;
	FB_Heating_Instance:ARRAY[1..1]OF FB_Heating;
	FB_Gear_Instance:ARRAY[1..1]OF FB_Gear;
	FB_AAS_Instance:ARRAY[1..1]OF FB_AAS;
	FB_AirLeak_Instance:ARRAY[1..2]OF FB_AirLeak;
	FB_Palletizing_Instance:ARRAY[1..3]OF FB_Palletizing;
END_VAR
VAR
	i:INT;//循环变量用
	j:INT;//循环变量用
END_VAR

// VAR
// 	TempKUKA1InPut AT %IB4500:ARRAY[0..63]OF BYTE;
// 	TempKUKA1OutPut AT %QB4500:ARRAY[0..63]OF BYTE;
// 	TempKUKA2InPut AT %IB4600:ARRAY[0..63]OF BYTE;
// 	TempKUKA2OutPut AT %QB4600:ARRAY[0..63]OF BYTE;
// END_VAR
VAR
	PowerLimitDelay:ARRAY[0..16] OF TON;//超出额定电流
END_VAR
 
ACT_Axis();
ACT_Cylinder();
ACT_Vacuum();
ACT_Epson();
ACT_Kuka();
ACT_Sensor();
ACT_Motor();
ACT_Rotdisk();
ACT_AI();
ACT_Stopper();
 
ACT_Pallet();