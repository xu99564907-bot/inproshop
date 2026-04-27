
// //电批1
// FB_ElectricScrewdriver_Instance[1](
// 	ioESDCtrl:= DB7050_DriveControl.ESDCtrl[1], 
// 	iName:= "侧面1电批", 
// 	iEstop:= DB7000_Control.Machine.EmgSafetyRelay, 
// 	iSafeDoor:= DB7000_Control.Machine.SafetyDoorRelay, 
// 	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay, 
// 	iMode:= DB7000_Control.Mode, 
// 	iNG:= IX7005_5_电批1_结果NG, 
// 	iOK:= IX7005_4_电批1_结果OK, 
// 	iERROR:= IX7005_6_电批1_ERROR, 
// 	oPowerOn=> QX7005_4_电批1_使能, 
// 	oStart=> QX7005_5_电批1_启动, 
// 	oReset=> );
// 	
// //电批2
// FB_ElectricScrewdriver_Instance[2](
// 	ioESDCtrl:= DB7050_DriveControl.ESDCtrl[2], 
// 	iName:= "侧面2电批", 
// 	iEstop:= DB7000_Control.Machine.EmgSafetyRelay, 
// 	iSafeDoor:= DB7000_Control.Machine.SafetyDoorRelay, 
// 	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay, 
// 	iMode:= DB7000_Control.Mode, 
// 	iNG:= IX7006_5_电批2_结果NG, 
// 	iOK:= IX7006_4_电批2_结果OK, 
// 	iERROR:= IX7006_6_电批2_ERROR, 
// 	oPowerOn=> QX7006_4_电批2_使能, 
// 	oStart=> QX7006_5_电批2_启动, 
// 	oReset=> );
// 	
// //电批3
// FB_ElectricScrewdriver_Instance[3](
// 	ioESDCtrl:= DB7050_DriveControl.ESDCtrl[3], 
// 	iName:= "底面螺丝电批", 
// 	iEstop:= DB7000_Control.Machine.EmgSafetyRelay, 
// 	iSafeDoor:= DB7000_Control.Machine.SafetyDoorRelay, 
// 	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay, 
// 	iMode:= DB7000_Control.Mode, 
// 	iNG:= IX7007_5_电批3_结果NG, 
// 	iOK:= IX7007_4_电批3_结果OK, 
// 	iERROR:= IX7007_6_电批3_ERROR, 
// 	oPowerOn=> QX7007_4_电批3_使能, 
// 	oStart=> QX7007_5_电批3_启动, 
// 	oReset=> );
// 	
// //电批4
// FB_ElectricScrewdriver_Instance[4](
// 	ioESDCtrl:= DB7050_DriveControl.ESDCtrl[4], 
// 	iName:= "底面螺母电批", 
// 	iEstop:= DB7000_Control.Machine.EmgSafetyRelay, 
// 	iSafeDoor:= DB7000_Control.Machine.SafetyDoorRelay, 
// 	iLightCurtain:= DB7000_Control.Machine.LightCurtainRelay, 
// 	iMode:= DB7000_Control.Mode, 
// 	iNG:= IX7008_5_电批4_结果NG, 
// 	iOK:= IX7008_4_电批4_结果OK, 
// 	iERROR:= IX7008_6_电批4_ERROR, 
// 	oPowerOn=> QX7008_4_电批4_使能, 
// 	oStart=> QX7008_5_电批4_启动, 
// 	oReset=> );
// 	
// 
// // //电批数值映射到QW区域
// // %QW104:=INT_TO_WORD(DB7050_DriveControl.ESDCtrl[1].Parm.Velocity);
// // %QW105:=INT_TO_WORD(DB7050_DriveControl.ESDCtrl[1].Parm.Torque);
// // 
// // %QW106:=INT_TO_WORD(DB7050_DriveControl.ESDCtrl[2].Parm.Velocity);
// // %QW107:=INT_TO_WORD(DB7050_DriveControl.ESDCtrl[2].Parm.Torque);
// // 
// // %QW108:=INT_TO_WORD(DB7050_DriveControl.ESDCtrl[3].Parm.Velocity);
// // %QW109:=INT_TO_WORD(DB7050_DriveControl.ESDCtrl[3].Parm.Torque);
// // 	
// // %QW110:=INT_TO_WORD(DB7050_DriveControl.ESDCtrl[4].Parm.Velocity);
// // %QW111:=INT_TO_WORD(DB7050_DriveControl.ESDCtrl[4].Parm.Torque);
// 
// 
// 
// 	
// //螺丝供钉机自动供钉		
// IF DB7000_Control.Mode.Status.AutoRunning THEN
// 	IF NOT DB7050_DriveControl.ScrewCtrl[1].Status.Done THEN
// 		IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.电批1上下气缸].Status.InHome
// 			AND  DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z1].Status.InPoint[1] THEN
// 			DB7050_DriveControl.ScrewCtrl[1].Cmd.AutoStart:=TRUE;
// 		END_IF
// 	END_IF
// 	IF NOT DB7050_DriveControl.ScrewCtrl[2].Status.Done THEN
// 		IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.电批2上下气缸].Status.InHome
// 			AND  DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z2].Status.InPoint[1] THEN
// 			DB7050_DriveControl.ScrewCtrl[2].Cmd.AutoStart:=TRUE;
// 		END_IF
// 	END_IF	
// 	IF NOT DB7050_DriveControl.ScrewCtrl[3].Status.Done THEN
// 		IF  DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.电批3鸟嘴上下气缸].Status.InHome
// 			AND DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.电批3整体上下气缸].Status.InHome
// 			AND  DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.Z3].Status.InPoint[1] THEN
// 			DB7050_DriveControl.ScrewCtrl[3].Cmd.AutoStart:=TRUE;
// 		END_IF
// 	END_IF	
// END_IF
// 	
// //供钉机1
// FB_ScrewFeeder_Instance[1](
// 	ioScewFeederCtrl:= DB7050_DriveControl.ScrewCtrl[1], 
// 	iName:= "侧面1供钉机", 
// 	iMode:= DB7000_Control.Mode, 
// 	iSensor:= IX7005_3_供钉机1_钉到位检测, 
// 	iReady:= IX7005_1_供钉机1_备钉完成, 
// 	iERROR:= IX7005_0_供钉机1_缺钉报警, 
// 	iClear:= DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.电批1上下气缸].DevStatus.Valve_Work, 
// 	iTimeOut:= T#5S, 
// 	oStart=> QX7005_0_供钉机1_启动供钉, 
// 	oReset=> , 
// 	oError=> , 
// 	oErrorID=> );
// 	
// //供钉机2
// FB_ScrewFeeder_Instance[2](
// 	ioScewFeederCtrl:= DB7050_DriveControl.ScrewCtrl[2], 
// 	iName:= "侧面2供钉机", 
// 	iMode:= DB7000_Control.Mode, 
// 	iSensor:= IX7006_3_供钉机2_钉到位检测, 
// 	iReady:= IX7006_1_供钉机2_备钉完成, 
// 	iERROR:= IX7006_0_供钉机2_缺钉报警, 
// 	iClear:= DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.电批2上下气缸].DevStatus.Valve_Work, 
// 	iTimeOut:= T#5S, 
// 	oStart=> QX7006_0_供钉机2_启动供钉, 
// 	oReset=> , 
// 	oError=> , 
// 	oErrorID=> );	
// 	
// 	
// //供钉机3
// FB_ScrewFeeder_Instance[3](
// 	ioScewFeederCtrl:= DB7050_DriveControl.ScrewCtrl[3], 
// 	iName:= "反面供钉机", 
// 	iMode:= DB7000_Control.Mode, 
// 	iSensor:= IX7007_3_供钉机3_钉到位检测, 
// 	iReady:= IX7007_1_供钉机3_备钉完成, 
// 	iERROR:= IX7007_0_供钉机3_缺钉报警, 
// 	iClear:= DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.电批3鸟嘴上下气缸].DevStatus.Valve_Work, 
// 	iTimeOut:= T#5S, 
// 	oStart=> QX7007_0_供钉机3_启动供钉, 
// 	oReset=> , 
// 	oError=> , 
// 	oErrorID=> );		
// 	
// 	
// //供钉机4
// DB7050_DriveControl.ScrewCtrl[4].Status.Ready:=IX7008_0_供钉机4_备钉完成;
// 	
// 	
// 	
// 	
// 	