
VAR_GLOBAL RETAIN PERSISTENT	
	CylCtrl AT %MB436944 : ARRAY [0..63] OF Str_Cylinder;
	VacCtrl AT %MB445520 : ARRAY [0..63] OF Str_Cylinder;
	AxisCtrl AT %MB454096 : ARRAY [0..16] OF Str_Axis;
	Sensor AT %MB483336 : ARRAY [0..63] OF Str_Sensor;
	CamCtrl AT %MB337740 : ARRAY [0..1] OF Str_Cam;	
	ESDCtrl AT %MB179360 : ARRAY [0..4] OF Str_ESD;
END_VAR

VAR_GLOBAL
	DoubleStart:ARRAY [1..3] OF Str_DoubleStart;	
	Epson : ARRAY [1..10] OF Str_Epson;	
	Kuka : ARRAY [1..10] OF Str_Kuka;	
	Rotdisk:ARRAY [1..1] OF Str_Rotdisk;
	Stopper:ARRAY [1..20] OF Str_Stopper;
	Motor:ARRAY [1..10] OF Str_Motor;
	AI:ARRAY [1..200] OF Str_AI;
	GearCtrl:ARRAY [1..1] OF Str_Gear;
	AAS:ARRAY [1..1] OF Str_AAS;
	CodeCtrl:ARRAY [0..4] OF Str_Code;
	PrintCtrl:ARRAY [0..1] OF Str_Print;	
	ScrewCtrl:ARRAY[0..4] OF Str_Screw;
END_VAR


