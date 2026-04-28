FB_Vacuum_instance[1](
	iEnable:=TRUE,
	iName:= "码垛机械手隔板真空吸Vac01",
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iHomeOK:= DB8000_Control.Mode.Status.HomeOK,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8600_2_码垛机械手隔板真空吸Vac01_真空表头,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	ioVaccum:= DB8050_DriveControl.VacCtrl[1],
	oValve_Work=> QX8600_2_码垛机械手隔板真空吸Vac01_吸真空,
	oValve_Home=> QX8600_3_码垛机械手隔板真空吸Vac01_破真空);
///////
///////
///////
