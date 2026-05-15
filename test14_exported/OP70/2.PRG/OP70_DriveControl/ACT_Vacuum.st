FB_Vacuum_instance[1](
	iEnable:=TRUE,
	iName:= "电批3真空Vac01",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iReset:= DB7000_Control.Mode.Out.ErrorReset,
	iAuto:= DB7000_Control.Mode.Status.AutoMode,
	iHomeOK:= DB7000_Control.Mode.Status.HomeOK,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX7111_2_电批3真空Vac01_真空表头,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	ioVaccum:= DB7050_DriveControl.VacCtrl[1],
	oValve_Work=> QX7111_2_电批3真空Vac01_吸真空,
	oValve_Home=> QX7111_3_电批3真空Vac01_破真空);
///////
///////
///////

FB_Vacuum_instance[2](
	iEnable:=TRUE,
	iName:= "电批4真空Vac02",
	iEstop:= DB7000_Control.Machine.EmgSafetyRelay,
	iReset:= DB7000_Control.Mode.Out.ErrorReset,
	iAuto:= DB7000_Control.Mode.Status.AutoMode,
	iHomeOK:= DB7000_Control.Mode.Status.HomeOK,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX7111_6_电批4真空Vac02_真空表头,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	ioVaccum:= DB7050_DriveControl.VacCtrl[2],
	oValve_Work=> QX7111_6_电批4真空Vac02_吸真空,
	oValve_Home=> QX7111_7_电批4真空Vac02_破真空);
///////
///////
///////
