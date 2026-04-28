


FB_Motor_Instance[1](
	iName:="上层流线",
	iEstop:=DB8000_Control.Machine.EmgSafetyRelay,
	iAlam:=, //控制器报警
	iAuto:= DB8000_Control.Mode.Status.AutoMode, 
	iReset:= DB8000_Control.Mode.Out.ErrorReset, 
	iTimeDelay:= T#1S, 
	iMode:= 1, 
	ioMotor:= DB8050_DriveControl.Motor[1], 
	oMotorFor=>  , //正转
	oMotorBack=>, //反转
	oReset=> );//复位信号
	

 

FB_Motor_Instance[1](
	iName:="工位1",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[1],
	oMotorFor=> QX8100_3_工位1_上电机正转,
	oMotorBack=> QX8100_4_工位1_上电机反转,
	oReset=> QX8100_3_工位1_上电机正转);
///////
///////
///////

FB_Motor_Instance[2](
	iName:="工位10",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[2],
	oMotorFor=> QX8109_3_工位10_上电机正转,
	oMotorBack=> QX8109_4_工位10_上电机反转,
	oReset=> QX8109_3_工位10_上电机正转);
///////
///////
///////

FB_Motor_Instance[3](
	iName:="工位11",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[3],
	oMotorFor=> QX8110_3_工位11_上电机正转,
	oMotorBack=> QX8110_4_工位11_上电机反转,
	oReset=> QX8110_3_工位11_上电机正转);
///////
///////
///////

FB_Motor_Instance[4](
	iName:="工位12",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[4],
	oMotorFor=> QX8111_3_工位12_上电机正转,
	oMotorBack=> QX8111_4_工位12_上电机反转,
	oReset=> QX8111_3_工位12_上电机正转);
///////
///////
///////

FB_Motor_Instance[5](
	iName:="工位13",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[5],
	oMotorFor=> QX8112_3_工位13_上电机正转,
	oMotorBack=> QX8112_4_工位13_上电机反转,
	oReset=> QX8112_3_工位13_上电机正转);
///////
///////
///////

FB_Motor_Instance[6](
	iName:="工位14",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[6],
	oMotorFor=> QX8113_3_工位14_上电机正转,
	oMotorBack=> QX8113_4_工位14_上电机反转,
	oReset=> QX8113_3_工位14_上电机正转);
///////
///////
///////

FB_Motor_Instance[7](
	iName:="工位15",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[7],
	oMotorFor=> QX8114_3_工位15_上电机正转,
	oMotorBack=> QX8114_4_工位15_上电机反转,
	oReset=> QX8114_3_工位15_上电机正转);
///////
///////
///////

FB_Motor_Instance[8](
	iName:="工位16",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[8],
	oMotorFor=> QX8115_3_工位16_上电机正转,
	oMotorBack=> QX8115_4_工位16_上电机反转,
	oReset=> QX8115_3_工位16_上电机正转);
///////
///////
///////

FB_Motor_Instance[9](
	iName:="工位17",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[9],
	oMotorFor=> QX8116_3_工位17_上电机正转,
	oMotorBack=> QX8116_4_工位17_上电机反转,
	oReset=> QX8116_3_工位17_上电机正转);
///////
///////
///////

FB_Motor_Instance[10](
	iName:="工位18",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[10],
	oMotorFor=> QX8117_3_工位18_上电机正转,
	oMotorBack=> QX8117_4_工位18_上电机反转,
	oReset=> QX8117_3_工位18_上电机正转);
///////
///////
///////

FB_Motor_Instance[11](
	iName:="工位19",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[11],
	oMotorFor=> QX8118_3_工位19_上电机正转,
	oMotorBack=> QX8118_4_工位19_上电机反转,
	oReset=> QX8118_3_工位19_上电机正转);
///////
///////
///////

FB_Motor_Instance[12](
	iName:="工位2",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[12],
	oMotorFor=> QX8101_3_工位2_上电机正转,
	oMotorBack=> QX8101_4_工位2_上电机反转,
	oReset=> QX8101_3_工位2_上电机正转);
///////
///////
///////

FB_Motor_Instance[13](
	iName:="工位20",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[13],
	oMotorFor=> QX8119_3_工位20_上电机正转,
	oMotorBack=> QX8119_4_工位20_上电机反转,
	oReset=> QX8119_3_工位20_上电机正转);
///////
///////
///////

FB_Motor_Instance[14](
	iName:="工位21",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[14],
	oMotorFor=> QX8120_3_工位21_上电机正转,
	oMotorBack=> QX8120_4_工位21_上电机反转,
	oReset=> QX8120_3_工位21_上电机正转);
///////
///////
///////

FB_Motor_Instance[15](
	iName:="工位22",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[15],
	oMotorFor=> QX8121_3_工位22_上电机正转,
	oMotorBack=> QX8121_4_工位22_上电机反转,
	oReset=> QX8121_3_工位22_上电机正转);
///////
///////
///////

FB_Motor_Instance[16](
	iName:="工位23",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[16],
	oMotorFor=> QX8122_3_工位23_上电机正转,
	oMotorBack=> QX8122_4_工位23_上电机反转,
	oReset=> QX8122_3_工位23_上电机正转);
///////
///////
///////

FB_Motor_Instance[17](
	iName:="工位24",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[17],
	oMotorFor=> QX8123_3_工位24_上电机正转,
	oMotorBack=> QX8123_4_工位24_上电机反转,
	oReset=> QX8123_3_工位24_上电机正转);
///////
///////
///////

FB_Motor_Instance[18](
	iName:="工位25",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[18],
	oMotorFor=> QX8124_3_工位25_上电机正转,
	oMotorBack=> QX8124_4_工位25_上电机反转,
	oReset=> QX8124_3_工位25_上电机正转);
///////
///////
///////

FB_Motor_Instance[19](
	iName:="工位26",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[19],
	oMotorFor=> QX8125_3_工位26_上电机正转,
	oMotorBack=> QX8125_4_工位26_上电机反转,
	oReset=> QX8125_3_工位26_上电机正转);
///////
///////
///////

FB_Motor_Instance[20](
	iName:="工位27",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[20],
	oMotorFor=> QX8126_3_工位27_上电机正转,
	oMotorBack=> QX8126_4_工位27_上电机反转,
	oReset=> QX8126_3_工位27_上电机正转);
///////
///////
///////

FB_Motor_Instance[21](
	iName:="工位28",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[21],
	oMotorFor=> QX8127_3_工位28_上电机正转,
	oMotorBack=> QX8127_4_工位28_上电机反转,
	oReset=> QX8127_3_工位28_上电机正转);
///////
///////
///////

FB_Motor_Instance[22](
	iName:="工位29",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[22],
	oMotorFor=> QX8128_3_工位29_上电机正转,
	oMotorBack=> QX8128_4_工位29_上电机反转,
	oReset=> QX8128_3_工位29_上电机正转);
///////
///////
///////

FB_Motor_Instance[23](
	iName:="工位3",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[23],
	oMotorFor=> QX8102_3_工位3_上电机正转,
	oMotorBack=> QX8102_4_工位3_上电机反转,
	oReset=> QX8102_3_工位3_上电机正转);
///////
///////
///////

FB_Motor_Instance[24](
	iName:="工位30",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[24],
	oMotorFor=> QX8129_3_工位30_上电机正转,
	oMotorBack=> QX8129_4_工位30_上电机反转,
	oReset=> QX8129_3_工位30_上电机正转);
///////
///////
///////

FB_Motor_Instance[25](
	iName:="工位31",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[25],
	oMotorFor=> QX8130_3_工位31_上电机正转,
	oMotorBack=> QX8130_4_工位31_上电机反转,
	oReset=> QX8130_3_工位31_上电机正转);
///////
///////
///////

FB_Motor_Instance[26](
	iName:="工位32",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[26],
	oMotorFor=> QX8131_3_工位32_上电机正转,
	oMotorBack=> QX8131_4_工位32_上电机反转,
	oReset=> QX8131_3_工位32_上电机正转);
///////
///////
///////

FB_Motor_Instance[27](
	iName:="工位33",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[27],
	oMotorFor=> QX8132_3_工位33_上电机正转,
	oMotorBack=> QX8132_4_工位33_上电机反转,
	oReset=> QX8132_3_工位33_上电机正转);
///////
///////
///////

FB_Motor_Instance[28](
	iName:="工位34",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[28],
	oMotorFor=> QX8133_3_工位34_上电机正转,
	oMotorBack=> QX8133_4_工位34_上电机反转,
	oReset=> QX8133_3_工位34_上电机正转);
///////
///////
///////

FB_Motor_Instance[29](
	iName:="工位35",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[29],
	oMotorFor=> QX8134_3_工位35_上电机正转,
	oMotorBack=> QX8134_4_工位35_上电机反转,
	oReset=> QX8134_3_工位35_上电机正转);
///////
///////
///////

FB_Motor_Instance[30](
	iName:="工位36",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[30],
	oMotorFor=> QX8135_3_工位36_上电机正转,
	oMotorBack=> QX8135_4_工位36_上电机反转,
	oReset=> QX8135_3_工位36_上电机正转);
///////
///////
///////

FB_Motor_Instance[31](
	iName:="工位37",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[31],
	oMotorFor=> QX8136_3_工位37_上电机正转,
	oMotorBack=> QX8136_4_工位37_上电机反转,
	oReset=> QX8136_3_工位37_上电机正转);
///////
///////
///////

FB_Motor_Instance[32](
	iName:="工位38",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[32],
	oMotorFor=> QX8137_3_工位38_上电机正转,
	oMotorBack=> QX8137_4_工位38_上电机反转,
	oReset=> QX8137_3_工位38_上电机正转);
///////
///////
///////

FB_Motor_Instance[33](
	iName:="工位39",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[33],
	oMotorFor=> QX8138_3_工位39_上电机正转,
	oMotorBack=> QX8138_4_工位39_上电机反转,
	oReset=> QX8138_3_工位39_上电机正转);
///////
///////
///////

FB_Motor_Instance[34](
	iName:="工位4",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[34],
	oMotorFor=> QX8103_3_工位4_上电机正转,
	oMotorBack=> QX8103_4_工位4_上电机反转,
	oReset=> QX8103_3_工位4_上电机正转);
///////
///////
///////

FB_Motor_Instance[35](
	iName:="工位40",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[35],
	oMotorFor=> QX8139_3_工位40_上电机正转,
	oMotorBack=> QX8139_4_工位40_上电机反转,
	oReset=> QX8139_3_工位40_上电机正转);
///////
///////
///////

FB_Motor_Instance[36](
	iName:="工位41",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[36],
	oMotorFor=> QX8200_3_工位41_上电机正转,
	oMotorBack=> QX8200_4_工位41_上电机反转,
	oReset=> QX8200_3_工位41_上电机正转);
///////
///////
///////

FB_Motor_Instance[37](
	iName:="工位42",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[37],
	oMotorFor=> QX8201_3_工位42_上电机正转,
	oMotorBack=> QX8201_4_工位42_上电机反转,
	oReset=> QX8201_3_工位42_上电机正转);
///////
///////
///////

FB_Motor_Instance[38](
	iName:="工位43",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[38],
	oMotorFor=> QX8202_3_工位43_上电机正转,
	oMotorBack=> QX8202_4_工位43_上电机反转,
	oReset=> QX8202_3_工位43_上电机正转);
///////
///////
///////

FB_Motor_Instance[39](
	iName:="工位44",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[39],
	oMotorFor=> QX8203_3_工位44_上电机正转,
	oMotorBack=> QX8203_4_工位44_上电机反转,
	oReset=> QX8203_3_工位44_上电机正转);
///////
///////
///////

FB_Motor_Instance[40](
	iName:="工位45",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[40],
	oMotorFor=> QX8204_3_工位45_上电机正转,
	oMotorBack=> QX8204_4_工位45_上电机反转,
	oReset=> QX8204_3_工位45_上电机正转);
///////
///////
///////

FB_Motor_Instance[41](
	iName:="工位46",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[41],
	oMotorFor=> QX8205_3_工位46_上电机正转,
	oMotorBack=> QX8205_4_工位46_上电机反转,
	oReset=> QX8205_3_工位46_上电机正转);
///////
///////
///////

FB_Motor_Instance[42](
	iName:="工位47",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[42],
	oMotorFor=> QX8206_3_工位47_上电机正转,
	oMotorBack=> QX8206_4_工位47_上电机反转,
	oReset=> QX8206_3_工位47_上电机正转);
///////
///////
///////

FB_Motor_Instance[43](
	iName:="工位48",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[43],
	oMotorFor=> QX8207_3_工位48_上电机正转,
	oMotorBack=> QX8207_4_工位48_上电机反转,
	oReset=> QX8207_3_工位48_上电机正转);
///////
///////
///////

FB_Motor_Instance[44](
	iName:="工位49",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[44],
	oMotorFor=> QX8208_3_工位49_上电机正转,
	oMotorBack=> QX8208_4_工位49_上电机反转,
	oReset=> QX8208_3_工位49_上电机正转);
///////
///////
///////

FB_Motor_Instance[45](
	iName:="工位5",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[45],
	oMotorFor=> QX8104_3_工位5_上电机正转,
	oMotorBack=> QX8104_4_工位5_上电机反转,
	oReset=> QX8104_3_工位5_上电机正转);
///////
///////
///////

FB_Motor_Instance[46](
	iName:="工位50",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[46],
	oMotorFor=> QX8209_3_工位50_上电机正转,
	oMotorBack=> QX8209_4_工位50_上电机反转,
	oReset=> QX8209_3_工位50_上电机正转);
///////
///////
///////

FB_Motor_Instance[47](
	iName:="工位51",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[47],
	oMotorFor=> QX8210_3_工位51_上电机正转,
	oMotorBack=> QX8210_4_工位51_上电机反转,
	oReset=> QX8210_3_工位51_上电机正转);
///////
///////
///////

FB_Motor_Instance[48](
	iName:="工位52",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[48],
	oMotorFor=> QX8211_3_工位52_上电机正转,
	oMotorBack=> QX8211_4_工位52_上电机反转,
	oReset=> QX8211_3_工位52_上电机正转);
///////
///////
///////

FB_Motor_Instance[49](
	iName:="工位53",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[49],
	oMotorFor=> QX8212_3_工位53_上电机正转,
	oMotorBack=> QX8212_4_工位53_上电机反转,
	oReset=> QX8212_3_工位53_上电机正转);
///////
///////
///////

FB_Motor_Instance[50](
	iName:="工位54",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[50],
	oMotorFor=> QX8213_3_工位54_上电机正转,
	oMotorBack=> QX8213_4_工位54_上电机反转,
	oReset=> QX8213_3_工位54_上电机正转);
///////
///////
///////

FB_Motor_Instance[51](
	iName:="工位55",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[51],
	oMotorFor=> QX8214_3_工位55_上电机正转,
	oMotorBack=> QX8214_4_工位55_上电机反转,
	oReset=> QX8214_3_工位55_上电机正转);
///////
///////
///////

FB_Motor_Instance[52](
	iName:="工位56",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[52],
	oMotorFor=> QX8215_3_工位56_上电机正转,
	oMotorBack=> QX8215_4_工位56_上电机反转,
	oReset=> QX8215_3_工位56_上电机正转);
///////
///////
///////

FB_Motor_Instance[53](
	iName:="工位57",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[53],
	oMotorFor=> QX8216_3_工位57_上电机正转,
	oMotorBack=> QX8216_4_工位57_上电机反转,
	oReset=> QX8216_3_工位57_上电机正转);
///////
///////
///////

FB_Motor_Instance[54](
	iName:="工位58",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[54],
	oMotorFor=> QX8217_3_工位58_上电机正转,
	oMotorBack=> QX8217_4_工位58_上电机反转,
	oReset=> QX8217_3_工位58_上电机正转);
///////
///////
///////

FB_Motor_Instance[55](
	iName:="工位59",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[55],
	oMotorFor=> QX8218_3_工位59_上电机正转,
	oMotorBack=> QX8218_4_工位59_上电机反转,
	oReset=> QX8218_3_工位59_上电机正转);
///////
///////
///////

FB_Motor_Instance[56](
	iName:="工位6",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[56],
	oMotorFor=> QX8105_3_工位6_上电机正转,
	oMotorBack=> QX8105_4_工位6_上电机反转,
	oReset=> QX8105_3_工位6_上电机正转);
///////
///////
///////

FB_Motor_Instance[57](
	iName:="工位60",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[57],
	oMotorFor=> QX8219_3_工位60_上电机正转,
	oMotorBack=> QX8219_4_工位60_上电机反转,
	oReset=> QX8219_3_工位60_上电机正转);
///////
///////
///////

FB_Motor_Instance[58](
	iName:="工位61",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[58],
	oMotorFor=> QX8220_3_工位61_上电机正转,
	oMotorBack=> QX8220_4_工位61_上电机反转,
	oReset=> QX8220_3_工位61_上电机正转);
///////
///////
///////

FB_Motor_Instance[59](
	iName:="工位62",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[59],
	oMotorFor=> QX8221_3_工位62_上电机正转,
	oMotorBack=> QX8221_4_工位62_上电机反转,
	oReset=> QX8221_3_工位62_上电机正转);
///////
///////
///////

FB_Motor_Instance[60](
	iName:="工位63",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[60],
	oMotorFor=> QX8222_3_工位63_上电机正转,
	oMotorBack=> QX8222_4_工位63_上电机反转,
	oReset=> QX8222_3_工位63_上电机正转);
///////
///////
///////

FB_Motor_Instance[61](
	iName:="工位64",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[61],
	oMotorFor=> QX8223_3_工位64_上电机正转,
	oMotorBack=> QX8223_4_工位64_上电机反转,
	oReset=> QX8223_3_工位64_上电机正转);
///////
///////
///////

FB_Motor_Instance[62](
	iName:="工位65",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[62],
	oMotorFor=> QX8224_3_工位65_上电机正转,
	oMotorBack=> QX8224_4_工位65_上电机反转,
	oReset=> QX8224_3_工位65_上电机正转);
///////
///////
///////

FB_Motor_Instance[63](
	iName:="工位66",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[63],
	oMotorFor=> QX8225_3_工位66_上电机正转,
	oMotorBack=> QX8225_4_工位66_上电机反转,
	oReset=> QX8225_3_工位66_上电机正转);
///////
///////
///////

FB_Motor_Instance[64](
	iName:="工位67",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[64],
	oMotorFor=> QX8226_3_工位67_上电机正转,
	oMotorBack=> QX8226_4_工位67_上电机反转,
	oReset=> QX8226_3_工位67_上电机正转);
///////
///////
///////

FB_Motor_Instance[65](
	iName:="工位68",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[65],
	oMotorFor=> QX8227_3_工位68_上电机正转,
	oMotorBack=> QX8227_4_工位68_上电机反转,
	oReset=> QX8227_3_工位68_上电机正转);
///////
///////
///////

FB_Motor_Instance[66](
	iName:="工位69",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[66],
	oMotorFor=> QX8228_3_工位69_上电机正转,
	oMotorBack=> QX8228_4_工位69_上电机反转,
	oReset=> QX8228_3_工位69_上电机正转);
///////
///////
///////

FB_Motor_Instance[67](
	iName:="工位7",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[67],
	oMotorFor=> QX8106_3_工位7_上电机正转,
	oMotorBack=> QX8106_4_工位7_上电机反转,
	oReset=> QX8106_3_工位7_上电机正转);
///////
///////
///////

FB_Motor_Instance[68](
	iName:="工位70",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[68],
	oMotorFor=> QX8229_3_工位70_上电机正转,
	oMotorBack=> QX8229_4_工位70_上电机反转,
	oReset=> QX8229_3_工位70_上电机正转);
///////
///////
///////

FB_Motor_Instance[69](
	iName:="工位71",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[69],
	oMotorFor=> QX8230_3_工位71_上电机正转,
	oMotorBack=> QX8230_4_工位71_上电机反转,
	oReset=> QX8230_3_工位71_上电机正转);
///////
///////
///////

FB_Motor_Instance[70](
	iName:="工位72",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[70],
	oMotorFor=> QX8231_3_工位72_上电机正转,
	oMotorBack=> QX8231_4_工位72_上电机反转,
	oReset=> QX8231_3_工位72_上电机正转);
///////
///////
///////

FB_Motor_Instance[71](
	iName:="工位73",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[71],
	oMotorFor=> QX8232_3_工位73_上电机正转,
	oMotorBack=> QX8232_4_工位73_上电机反转,
	oReset=> QX8232_3_工位73_上电机正转);
///////
///////
///////

FB_Motor_Instance[72](
	iName:="工位74",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[72],
	oMotorFor=> QX8233_3_工位74_上电机正转,
	oMotorBack=> QX8233_4_工位74_上电机反转,
	oReset=> QX8233_3_工位74_上电机正转);
///////
///////
///////

FB_Motor_Instance[73](
	iName:="工位75",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[73],
	oMotorFor=> QX8234_3_工位75_上电机正转,
	oMotorBack=> QX8234_4_工位75_上电机反转,
	oReset=> QX8234_3_工位75_上电机正转);
///////
///////
///////

FB_Motor_Instance[74](
	iName:="工位76",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[74],
	oMotorFor=> QX8235_3_工位76_上电机正转,
	oMotorBack=> QX8235_4_工位76_上电机反转,
	oReset=> QX8235_3_工位76_上电机正转);
///////
///////
///////

FB_Motor_Instance[75](
	iName:="工位77",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[75],
	oMotorFor=> QX8236_3_工位77_上电机正转,
	oMotorBack=> QX8236_4_工位77_上电机反转,
	oReset=> QX8236_3_工位77_上电机正转);
///////
///////
///////

FB_Motor_Instance[76](
	iName:="工位78",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[76],
	oMotorFor=> QX8237_3_工位78_上电机正转,
	oMotorBack=> QX8237_4_工位78_上电机反转,
	oReset=> QX8237_3_工位78_上电机正转);
///////
///////
///////

FB_Motor_Instance[77](
	iName:="工位79",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[77],
	oMotorFor=> QX8238_3_工位79_上电机正转,
	oMotorBack=> QX8238_4_工位79_上电机反转,
	oReset=> QX8238_3_工位79_上电机正转);
///////
///////
///////

FB_Motor_Instance[78](
	iName:="工位8",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[78],
	oMotorFor=> QX8107_3_工位8_上电机正转,
	oMotorBack=> QX8107_4_工位8_上电机反转,
	oReset=> QX8107_3_工位8_上电机正转);
///////
///////
///////

FB_Motor_Instance[79](
	iName:="工位80",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[79],
	oMotorFor=> QX8239_3_工位80_上电机正转,
	oMotorBack=> QX8239_4_工位80_上电机反转,
	oReset=> QX8239_3_工位80_上电机正转);
///////
///////
///////

FB_Motor_Instance[80](
	iName:="工位9",
	iAlam:= FALSE,
	iEstop:= DB8000_Control.Machine.EmgSafetyRelay,
	iAuto:= DB8000_Control.Mode.Status.AutoMode,
	iReset:= DB8000_Control.Mode.Out.ErrorReset,
	iTimeDelay:= T#5S,
	iMode:=1,
	ioMotor:= DB8050_DriveControl.Motor[80],
	oMotorFor=> QX8108_3_工位9_上电机正转,
	oMotorBack=> QX8108_4_工位9_上电机反转,
	oReset=> QX8108_3_工位9_上电机正转);
///////
///////
///////
