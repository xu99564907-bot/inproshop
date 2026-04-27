
VAR_GLOBAL RETAIN PERSISTENT	
	CylCtrl   : ARRAY [0..63] OF Str_Cylinder;
	VacCtrl   : ARRAY [0..32] OF Str_Cylinder;
	AxisCtrl  : ARRAY [0..16] OF Str_Axis;
	Sensor  : ARRAY [0..32] OF Str_Sensor;
	CamCtrl  : ARRAY [1..3] OF Str_CamControl;	
END_VAR

VAR_GLOBAL
	DoubleStart:ARRAY [1..4] OF Str_DoubleStart;	
	Epson : ARRAY [1..10] OF Str_Epson;	
	Kuka : ARRAY [1..2] OF Str_Kuka6;	
	Rotdisk:ARRAY [1..1] OF Str_Rotdisk;
	Stopper:ARRAY [1..20] OF Str_Stopper;
	Motor:ARRAY [1..10] OF Str_Motor;
	AI:ARRAY [0..20] OF Str_AI;
	AAS:ARRAY [1..1] OF Str_AAS;
	HeatCtrl : ARRAY [1..1] OF Str_Heating;
	PalletCtrl : ARRAY [0..3] OF Str_Palletizing;
END_VAR

