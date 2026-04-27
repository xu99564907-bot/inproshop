PROGRAM OP70_DriveControl
VAR
	FB_Cylinder_instance :ARRAY[0..63]OF FB_Cylinder_V1;
	FB_Vacuum_instance :ARRAY[0..31]OF FB_Vacuum_V1;
	FB_Axis_Instance:ARRAY[0..31]OF FB_Axis_V1_3;
	FB_Sensor_instance :ARRAY[0..63]OF FB_Sensor_V1_1;
	FB_TcpClient_Instance:ARRAY[0..31]OF FB_TcpClient;
	FB_DoubleStart_Instance:ARRAY[1..1]OF FB_DoubleStart;	
	FB_Epson_V1_Instance:ARRAY[1..1]OF FB_Epson_V1;	
	FB_Kuka_V1_Instance:ARRAY[1..10]OF FB_Kuka_V1;
	FB_Rotdisk_V1_Instance:ARRAY[1..1]OF FB_Rotdisk_V1;
	FB_Stopper_V1_Instance:ARRAY[1..10]OF FB_Stopper_V1;
	FB_AI_Instance:ARRAY[1..1]OF FB_AI;
	FB_Motor_Instance:ARRAY[1..1]OF FB_Motor;
	FB_Heating_Instance:ARRAY[1..1]OF FB_Heating;
	FB_Cam_Instance:ARRAY[1..1]OF FB_Cam;
	FB_AAS_Instance:ARRAY[1..1]OF FB_AAS;
	FB_ElectricScrewdriver_Instance:ARRAY[1..4]OF FB_ElectricScrewdriver_V1_1_0;
	FB_ScrewFeeder_Instance:ARRAY[1..4]OF FB_ScrewFeeder;
	FB_Code_Instance:ARRAY[1..4]OF FB_Code;
	FB_Print_Instance:ARRAY[1..1]OF FB_Print;
END_VAR
VAR
	i:INT;//循环变量用
	EpsonTcpClient:ARRAY[1..1]OF Str_TcpClient;
	KukaTcpClient:ARRAY[1..1]OF Str_TcpClient;	
END_VAR

 
ACT_Axis();
ACT_Cylinder();
ACT_Vacuum();
ACT_Sensor();
ACT_Cam();
ACT_ElectricScrewdriver();
ACT_CODE();
ACT_Print();


