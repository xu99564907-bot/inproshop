FB_Cylinder_instance[1](
	iEnable:=TRUE,
	iName:="测试1_产品侧边定位气缸CY01",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8300_0_测试1_产品侧边定位气缸CY01_伸出位,
	iSensor_Home:= IX8300_1_测试1_产品侧边定位气缸CY01_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[1],
	oValve_Work=> QX8300_0_测试1_产品侧边定位气缸CY01_伸出,
	oValve_Home=> QX8300_1_测试1_产品侧边定位气缸CY01_缩回);
///////
///////
///////

FB_Cylinder_instance[2](
	iEnable:=TRUE,
	iName:="测试1_产品固定气缸CY02A",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8300_2_测试1_产品固定气缸CY02A_锁紧位,
	iSensor_Home:= IX8300_2_测试1_产品固定气缸CY02A_锁紧位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[2],
	oValve_Work=> QX8300_2_测试1_产品固定气缸CY02_锁紧,
	oValve_Home=> QX8300_2_测试1_产品固定气缸CY02_锁紧);
///////
///////
///////

FB_Cylinder_instance[3](
	iEnable:=TRUE,
	iName:="测试1_产品封堵A上下气缸CY03",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8300_6_测试1_产品封堵A上下气缸CY03_上升位,
	iSensor_Home:= IX8300_6_测试1_产品封堵A上下气缸CY03_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[3],
	oValve_Work=> QX8300_6_测试1_产品封堵A上下气缸CY03_上升,
	oValve_Home=> QX8300_6_测试1_产品封堵A上下气缸CY03_上升);
///////
///////
///////

FB_Cylinder_instance[4](
	iEnable:=TRUE,
	iName:="测试1_产品封堵A侧推气缸CY04",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8301_0_测试1_产品封堵A侧推气缸CY04_伸出位,
	iSensor_Home:= IX8301_1_测试1_产品封堵A侧推气缸CY04_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[4],
	oValve_Work=> QX8301_0_测试1_产品封堵A侧推气缸CY04_伸出,
	oValve_Home=> QX8301_1_测试1_产品封堵A侧推气缸CY04_缩回);
///////
///////
///////

FB_Cylinder_instance[5](
	iEnable:=TRUE,
	iName:="测试1_产品封堵B上下气缸CY05",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8301_2_测试1_产品封堵B上下气缸CY05_上升位,
	iSensor_Home:= IX8301_2_测试1_产品封堵B上下气缸CY05_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[5],
	oValve_Work=> QX8301_2_测试1_产品封堵B上下气缸CY05_上升,
	oValve_Home=> QX8301_2_测试1_产品封堵B上下气缸CY05_上升);
///////
///////
///////

FB_Cylinder_instance[6](
	iEnable:=TRUE,
	iName:="测试1_驱动齿轮气缸CY06",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8301_4_测试1_驱动齿轮气缸CY06_伸出位,
	iSensor_Home:= IX8301_5_测试1_驱动齿轮气缸CY06_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[6],
	oValve_Work=> QX8301_4_测试1_驱动齿轮气缸CY06_伸出,
	oValve_Home=> QX8301_5_测试1_驱动齿轮气缸CY06_缩回);
///////
///////
///////

FB_Cylinder_instance[7](
	iEnable:=TRUE,
	iName:="测试1_固定夹爪气缸CY07",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8301_6_测试1_固定夹爪气缸CY07_夹紧位,
	iSensor_Home:= IX8301_7_测试1_固定夹爪气缸CY07_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[7],
	oValve_Work=> QX8301_6_测试1_固定夹爪气缸CY07_夹紧,
	oValve_Home=> QX8301_7_测试1_固定夹爪气缸CY07_缩回);
///////
///////
///////

FB_Cylinder_instance[8](
	iEnable:=TRUE,
	iName:="测试1_插管测试气缸CY08",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8302_0_测试1_插管测试气缸CY08_上升位,
	iSensor_Home:= IX8302_0_测试1_插管测试气缸CY08_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[8],
	oValve_Work=> QX8302_0_测试1_插管测试气缸CY08_上升,
	oValve_Home=> QX8302_0_测试1_插管测试气缸CY08_上升);
///////
///////
///////

FB_Cylinder_instance[9](
	iEnable:=TRUE,
	iName:="测试1_拔管解扣气缸CY09",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8302_2_测试1_拔管解扣气缸CY09_上升位,
	iSensor_Home:= IX8302_2_测试1_拔管解扣气缸CY09_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[9],
	oValve_Work=> QX8302_2_测试1_拔管解扣气缸CY09_上升,
	oValve_Home=> QX8302_2_测试1_拔管解扣气缸CY09_上升);
///////
///////
///////

FB_Cylinder_instance[10](
	iEnable:=TRUE,
	iName:="缓存NG1_侧边定位气缸CY10",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8302_4_缓存NG1_侧边定位气缸CY10_伸出位,
	iSensor_Home:= IX8302_5_缓存NG1_侧边定位气缸CY10_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[10],
	oValve_Work=> QX8302_4_缓存NG1_侧边定位气缸CY10_伸出,
	oValve_Home=> QX8302_5_缓存NG1_侧边定位气缸CY10_缩回);
///////
///////
///////

FB_Cylinder_instance[11](
	iEnable:=TRUE,
	iName:="测试2_产品侧边定位气缸CY11",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8304_0_测试2_产品侧边定位气缸CY11_伸出位,
	iSensor_Home:= IX8304_1_测试2_产品侧边定位气缸CY11_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[11],
	oValve_Work=> QX8304_0_测试2_产品侧边定位气缸CY11_伸出,
	oValve_Home=> QX8304_1_测试2_产品侧边定位气缸CY11_缩回);
///////
///////
///////

FB_Cylinder_instance[12](
	iEnable:=TRUE,
	iName:="测试2_产品固定气缸CY12_1",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8304_2_测试2_产品固定气缸CY12_1_锁紧位,
	iSensor_Home:= IX8304_2_测试2_产品固定气缸CY12_1_锁紧位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[12],
	oValve_Work=> QX8304_2_测试2_产品固定气缸CY12_锁紧,
	oValve_Home=> QX8304_2_测试2_产品固定气缸CY12_锁紧);
///////
///////
///////

FB_Cylinder_instance[13](
	iEnable:=TRUE,
	iName:="测试2_产品封堵A上下气缸CY13",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8304_6_测试2_产品封堵A上下气缸CY13_上升位,
	iSensor_Home:= IX8304_6_测试2_产品封堵A上下气缸CY13_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[13],
	oValve_Work=> QX8304_6_测试2_产品封堵A上下气缸CY13_上升,
	oValve_Home=> QX8304_6_测试2_产品封堵A上下气缸CY13_上升);
///////
///////
///////

FB_Cylinder_instance[14](
	iEnable:=TRUE,
	iName:="测试2_产品封堵A侧推气缸CY14",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8305_0_测试2_产品封堵A侧推气缸CY14_伸出位,
	iSensor_Home:= IX8305_1_测试2_产品封堵A侧推气缸CY14_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[14],
	oValve_Work=> QX8305_0_测试2_产品封堵A侧推气缸CY14_伸出,
	oValve_Home=> QX8305_1_测试2_产品封堵A侧推气缸CY14_缩回);
///////
///////
///////

FB_Cylinder_instance[15](
	iEnable:=TRUE,
	iName:="测试2_产品封堵B上下气缸CY15",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8305_2_测试2_产品封堵B上下气缸CY15_上升位,
	iSensor_Home:= IX8305_2_测试2_产品封堵B上下气缸CY15_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[15],
	oValve_Work=> QX8305_2_测试2_产品封堵B上下气缸CY15_上升,
	oValve_Home=> QX8305_2_测试2_产品封堵B上下气缸CY15_上升);
///////
///////
///////

FB_Cylinder_instance[16](
	iEnable:=TRUE,
	iName:="测试2_驱动齿轮气缸CY16",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8305_4_测试2_驱动齿轮气缸CY16_伸出位,
	iSensor_Home:= IX8305_5_测试2_驱动齿轮气缸CY16_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[16],
	oValve_Work=> QX8305_4_测试2_驱动齿轮气缸CY16_伸出,
	oValve_Home=> QX8305_5_测试2_驱动齿轮气缸CY16_缩回);
///////
///////
///////

FB_Cylinder_instance[17](
	iEnable:=TRUE,
	iName:="测试2_固定夹爪气缸CY17",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8305_6_测试2_固定夹爪气缸CY17_夹紧位,
	iSensor_Home:= IX8305_7_测试2_固定夹爪气缸CY17_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[17],
	oValve_Work=> QX8305_6_测试2_固定夹爪气缸CY17_夹紧,
	oValve_Home=> QX8305_7_测试2_固定夹爪气缸CY17_缩回);
///////
///////
///////

FB_Cylinder_instance[18](
	iEnable:=TRUE,
	iName:="测试2_插管测试气缸CY18",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8306_0_测试2_插管测试气缸CY18_上升位,
	iSensor_Home:= IX8306_0_测试2_插管测试气缸CY18_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[18],
	oValve_Work=> QX8306_0_测试2_插管测试气缸CY18_上升,
	oValve_Home=> QX8306_0_测试2_插管测试气缸CY18_上升);
///////
///////
///////

FB_Cylinder_instance[19](
	iEnable:=TRUE,
	iName:="测试2_拔管解扣气缸CY19",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8306_2_测试2_拔管解扣气缸CY19_上升位,
	iSensor_Home:= IX8306_2_测试2_拔管解扣气缸CY19_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[19],
	oValve_Work=> QX8306_2_测试2_拔管解扣气缸CY19_上升,
	oValve_Home=> QX8306_2_测试2_拔管解扣气缸CY19_上升);
///////
///////
///////

FB_Cylinder_instance[20](
	iEnable:=TRUE,
	iName:="缓存NG2_侧边定位气缸CY20",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8306_4_缓存NG2_侧边定位气缸CY20_伸出位,
	iSensor_Home:= IX8306_5_缓存NG2_侧边定位气缸CY20_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[20],
	oValve_Work=> QX8306_4_缓存NG2_侧边定位气缸CY20_伸出,
	oValve_Home=> QX8306_5_缓存NG2_侧边定位气缸CY20_缩回);
///////
///////
///////

FB_Cylinder_instance[21](
	iEnable:=TRUE,
	iName:="测试3_产品侧边定位气缸CY21",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8400_0_测试3_产品侧边定位气缸CY21_伸出位,
	iSensor_Home:= IX8400_1_测试3_产品侧边定位气缸CY21_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[21],
	oValve_Work=> QX8400_0_测试3_产品侧边定位气缸CY21_伸出,
	oValve_Home=> QX8400_1_测试3_产品侧边定位气缸CY21_缩回);
///////
///////
///////

FB_Cylinder_instance[22](
	iEnable:=TRUE,
	iName:="测试3_产品固定气缸CY22_1",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8400_2_测试3_产品固定气缸CY22_1_锁紧位,
	iSensor_Home:= IX8400_2_测试3_产品固定气缸CY22_1_锁紧位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[22],
	oValve_Work=> QX8400_2_测试3_产品固定气缸CY22_锁紧,
	oValve_Home=> QX8400_2_测试3_产品固定气缸CY22_锁紧);
///////
///////
///////

FB_Cylinder_instance[23](
	iEnable:=TRUE,
	iName:="测试3_产品封堵A上下气缸CY23",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8400_6_测试3_产品封堵A上下气缸CY23_上升位,
	iSensor_Home:= IX8400_6_测试3_产品封堵A上下气缸CY23_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[23],
	oValve_Work=> QX8400_6_测试3_产品封堵A上下气缸CY23_上升,
	oValve_Home=> QX8400_6_测试3_产品封堵A上下气缸CY23_上升);
///////
///////
///////

FB_Cylinder_instance[24](
	iEnable:=TRUE,
	iName:="测试3_产品封堵A侧推气缸CY24",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8401_0_测试3_产品封堵A侧推气缸CY24_伸出位,
	iSensor_Home:= IX8401_1_测试3_产品封堵A侧推气缸CY24_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[24],
	oValve_Work=> QX8401_0_测试3_产品封堵A侧推气缸CY24_伸出,
	oValve_Home=> QX8401_1_测试3_产品封堵A侧推气缸CY24_缩回);
///////
///////
///////

FB_Cylinder_instance[25](
	iEnable:=TRUE,
	iName:="测试3_产品封堵B上下气缸CY25",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8401_2_测试3_产品封堵B上下气缸CY25_上升位,
	iSensor_Home:= IX8401_2_测试3_产品封堵B上下气缸CY25_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[25],
	oValve_Work=> QX8401_2_测试3_产品封堵B上下气缸CY25_上升,
	oValve_Home=> QX8401_2_测试3_产品封堵B上下气缸CY25_上升);
///////
///////
///////

FB_Cylinder_instance[26](
	iEnable:=TRUE,
	iName:="测试3_驱动齿轮气缸CY26",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8401_4_测试3_驱动齿轮气缸CY26_伸出位,
	iSensor_Home:= IX8401_5_测试3_驱动齿轮气缸CY26_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[26],
	oValve_Work=> QX8401_4_测试3_驱动齿轮气缸CY26_伸出,
	oValve_Home=> QX8401_5_测试3_驱动齿轮气缸CY26_缩回);
///////
///////
///////

FB_Cylinder_instance[27](
	iEnable:=TRUE,
	iName:="测试3_固定夹爪气缸CY27",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8401_6_测试3_固定夹爪气缸CY27_夹紧位,
	iSensor_Home:= IX8401_7_测试3_固定夹爪气缸CY27_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[27],
	oValve_Work=> QX8401_6_测试3_固定夹爪气缸CY27_夹紧,
	oValve_Home=> QX8401_7_测试3_固定夹爪气缸CY27_缩回);
///////
///////
///////

FB_Cylinder_instance[28](
	iEnable:=TRUE,
	iName:="测试3_插管测试气缸CY28",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8402_0_测试3_插管测试气缸CY28_上升位,
	iSensor_Home:= IX8402_0_测试3_插管测试气缸CY28_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[28],
	oValve_Work=> QX8402_0_测试3_插管测试气缸CY28_上升,
	oValve_Home=> QX8402_0_测试3_插管测试气缸CY28_上升);
///////
///////
///////

FB_Cylinder_instance[29](
	iEnable:=TRUE,
	iName:="测试3_拔管解扣气缸CY29",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8402_2_测试3_拔管解扣气缸CY29_上升位,
	iSensor_Home:= IX8402_2_测试3_拔管解扣气缸CY29_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[29],
	oValve_Work=> QX8402_2_测试3_拔管解扣气缸CY29_上升,
	oValve_Home=> QX8402_2_测试3_拔管解扣气缸CY29_上升);
///////
///////
///////

FB_Cylinder_instance[30](
	iEnable:=TRUE,
	iName:="缓存NG3_侧边定位气缸CY30",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8402_4_缓存NG3_侧边定位气缸CY30_伸出位,
	iSensor_Home:= IX8402_5_缓存NG3_侧边定位气缸CY30_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[30],
	oValve_Work=> QX8402_4_缓存NG3_侧边定位气缸CY30_伸出,
	oValve_Home=> QX8402_5_缓存NG3_侧边定位气缸CY30_缩回);
///////
///////
///////

FB_Cylinder_instance[31](
	iEnable:=TRUE,
	iName:="测试4_产品侧边定位气缸CY31",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8404_0_测试4_产品侧边定位气缸CY31_伸出位,
	iSensor_Home:= IX8404_1_测试4_产品侧边定位气缸CY31_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[31],
	oValve_Work=> QX8404_0_测试4_产品侧边定位气缸CY31_伸出,
	oValve_Home=> QX8404_1_测试4_产品侧边定位气缸CY31_缩回);
///////
///////
///////

FB_Cylinder_instance[32](
	iEnable:=TRUE,
	iName:="测试4_产品固定气缸CY32_1",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8404_2_测试4_产品固定气缸CY32_1_锁紧位,
	iSensor_Home:= IX8404_2_测试4_产品固定气缸CY32_1_锁紧位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[32],
	oValve_Work=> QX8404_2_测试4_产品固定气缸CY32_锁紧,
	oValve_Home=> QX8404_2_测试4_产品固定气缸CY32_锁紧);
///////
///////
///////

FB_Cylinder_instance[33](
	iEnable:=TRUE,
	iName:="测试4_产品封堵A上下气缸CY33",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8404_6_测试4_产品封堵A上下气缸CY33_上升位,
	iSensor_Home:= IX8404_6_测试4_产品封堵A上下气缸CY33_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[33],
	oValve_Work=> QX8404_6_测试4_产品封堵A上下气缸CY33_上升,
	oValve_Home=> QX8404_6_测试4_产品封堵A上下气缸CY33_上升);
///////
///////
///////

FB_Cylinder_instance[34](
	iEnable:=TRUE,
	iName:="测试4_产品封堵A侧推气缸CY34",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8405_0_测试4_产品封堵A侧推气缸CY34_伸出位,
	iSensor_Home:= IX8405_1_测试4_产品封堵A侧推气缸CY34_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[34],
	oValve_Work=> QX8405_0_测试4_产品封堵A侧推气缸CY34_伸出,
	oValve_Home=> QX8405_1_测试4_产品封堵A侧推气缸CY34_缩回);
///////
///////
///////

FB_Cylinder_instance[35](
	iEnable:=TRUE,
	iName:="测试4_产品封堵B上下气缸CY35",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8405_2_测试4_产品封堵B上下气缸CY35_上升位,
	iSensor_Home:= IX8405_2_测试4_产品封堵B上下气缸CY35_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[35],
	oValve_Work=> QX8405_2_测试4_产品封堵B上下气缸CY35_上升,
	oValve_Home=> QX8405_2_测试4_产品封堵B上下气缸CY35_上升);
///////
///////
///////

FB_Cylinder_instance[36](
	iEnable:=TRUE,
	iName:="测试4_驱动齿轮气缸CY36",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8405_4_测试4_驱动齿轮气缸CY36_伸出位,
	iSensor_Home:= IX8405_5_测试4_驱动齿轮气缸CY36_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[36],
	oValve_Work=> QX8405_4_测试4_驱动齿轮气缸CY36_伸出,
	oValve_Home=> QX8405_5_测试4_驱动齿轮气缸CY36_缩回);
///////
///////
///////

FB_Cylinder_instance[37](
	iEnable:=TRUE,
	iName:="测试4_固定夹爪气缸CY37",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8405_6_测试4_固定夹爪气缸CY37_夹紧位,
	iSensor_Home:= IX8405_7_测试4_固定夹爪气缸CY37_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[37],
	oValve_Work=> QX8405_6_测试4_固定夹爪气缸CY37_夹紧,
	oValve_Home=> QX8405_7_测试4_固定夹爪气缸CY37_缩回);
///////
///////
///////

FB_Cylinder_instance[38](
	iEnable:=TRUE,
	iName:="测试4_插管测试气缸CY38",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8406_0_测试4_插管测试气缸CY38_上升位,
	iSensor_Home:= IX8406_0_测试4_插管测试气缸CY38_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[38],
	oValve_Work=> QX8406_0_测试4_插管测试气缸CY38_上升,
	oValve_Home=> QX8406_0_测试4_插管测试气缸CY38_上升);
///////
///////
///////

FB_Cylinder_instance[39](
	iEnable:=TRUE,
	iName:="测试4_拔管解扣气缸CY39",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8406_2_测试4_拔管解扣气缸CY39_上升位,
	iSensor_Home:= IX8406_2_测试4_拔管解扣气缸CY39_上升位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[39],
	oValve_Work=> QX8406_2_测试4_拔管解扣气缸CY39_上升,
	oValve_Home=> QX8406_2_测试4_拔管解扣气缸CY39_上升);
///////
///////
///////

FB_Cylinder_instance[40](
	iEnable:=TRUE,
	iName:="缓存NG4_侧边定位气缸CY40",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8406_4_缓存NG4_侧边定位气缸CY40_伸出位,
	iSensor_Home:= IX8406_5_缓存NG4_侧边定位气缸CY40_缩回位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[40],
	oValve_Work=> QX8406_4_缓存NG4_侧边定位气缸CY40_伸出,
	oValve_Home=> QX8406_5_缓存NG4_侧边定位气缸CY40_缩回);
///////
///////
///////

FB_Cylinder_instance[41](
	iEnable:=TRUE,
	iName:="上料机械手夹爪CY41",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8500_0_上料机械手夹爪CY41_夹紧位,
	iSensor_Home:= IX8500_0_上料机械手夹爪CY41_夹紧位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[41],
	oValve_Work=> QX8500_0_上料机械手夹爪CY41_夹紧,
	oValve_Home=> QX8500_0_上料机械手夹爪CY41_夹紧);
///////
///////
///////

FB_Cylinder_instance[45](
	iEnable:=TRUE,
	iName:="码垛机械手夹爪CY45",
	iMode:= DB8000_Control.Mode,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iSafeDoor:= DB8000_Control.Machine.EmgSafetyRelay,
	iLightCurtain:= DB8000_Control.Machine.LightCurtainRelay,
	iClock_100ms:= CPU_Clock.Clock_100ms_R,
	iSensor_Work:= IX8600_0_码垛机械手夹爪CY45_夹紧位,
	iSensor_Home:= IX8600_0_码垛机械手夹爪CY45_夹紧位,
	iIC_Home:= TRUE,
	iIC_Work:= TRUE,
	iValveModel:= 0,
	ioCylinder:= DB8050_DriveControl.CylCtrl[45],
	oValve_Work=> QX8600_0_码垛机械手夹爪CY45_夹紧,
	oValve_Home=> QX8600_0_码垛机械手夹爪CY45_夹紧);
///////
///////
///////
