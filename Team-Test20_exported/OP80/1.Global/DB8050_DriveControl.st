
VAR_GLOBAL RETAIN PERSISTENT	
	CylCtrl AT %MB133808 : ARRAY [0..63] OF Str_Cylinder;
	VacCtrl AT %MB146812 : ARRAY [0..63] OF Str_Cylinder;
	AxisCtrl AT %MB179816 : ARRAY [0..16] OF Str_Axis;
	Sensor AT %MB155388 : ARRAY [0..168] OF Str_Sensor;
	CamCtrl AT %MB131084 : ARRAY [1..3] OF Str_CamControl;	
	HeatCtrl AT %MB131100 : ARRAY [1..1] OF Str_Heating;
	AgingCtrl AT %MB209056 : ARRAY [0..80] OF Str_Aging;
	AirLeakCtrl AT %MB131268 : ARRAY [0..2] OF Str_AirLeak;
	PalletCtrl AT %MB131144 : ARRAY [0..3] OF Str_Palletizing;
END_VAR

VAR_GLOBAL
	DoubleStart:ARRAY [1..4] OF Str_DoubleStart;	
	Epson : ARRAY [1..10] OF Str_Epson;	
	Kuka : ARRAY [1..2] OF Str_Kuka6;	
	Rotdisk:ARRAY [1..1] OF Str_Rotdisk;
	Stopper:ARRAY [1..20] OF Str_Stopper;
	Motor:ARRAY [1..10] OF Str_Motor;
	AI:ARRAY [0..200] OF Str_AI;
	GearCtrl:ARRAY [1..1] OF Str_Gear;
	AAS:ARRAY [1..1] OF Str_AAS;
END_VAR

