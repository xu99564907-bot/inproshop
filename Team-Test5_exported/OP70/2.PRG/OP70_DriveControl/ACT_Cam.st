
// 
// //凸轮表赋值
// 
// //起始位置
// Cam_OP07_X2_X3_A[0].dX:=0;
// Cam_OP07_X2_X3_A[0].dY:=0;
// Cam_OP07_X2_X3_A[0].dV:=1;
// Cam_OP07_X2_X3_A[0].dA:=0;
// 
// //取料位置
// Cam_OP07_X2_X3_A[1].dX:=DB7050_DriveControl.AxisCtrl[2].Parm._ABS[1].Position;
// Cam_OP07_X2_X3_A[1].dY:=DB7050_DriveControl.AxisCtrl[3].Parm._ABS[1].Position;
// Cam_OP07_X2_X3_A[1].dV:=1;
// Cam_OP07_X2_X3_A[1].dA:=0;
// 
// //放料位置
// Cam_OP07_X2_X3_A[2].dX:=DB7050_DriveControl.AxisCtrl[2].Parm._ABS[2].Position;
// Cam_OP07_X2_X3_A[2].dY:=DB7050_DriveControl.AxisCtrl[3].Parm._ABS[2].Position;
// Cam_OP07_X2_X3_A[2].dV:=1;
// Cam_OP07_X2_X3_A[2].dA:=0;
// 
// //最终位置
// Cam_OP07_X2_X3_A[3].dX:=600;
// Cam_OP07_X2_X3_A[3].dY:=600;
// Cam_OP07_X2_X3_A[3].dV:=1;
// Cam_OP07_X2_X3_A[3].dA:=0;
// 
// //凸轮表参数
// Cam_OP07_X2_X3.nElements:=4;//点位数量
// Cam_OP07_X2_X3.xStart:=0;//主轴起始位置
// Cam_OP07_X2_X3.xEnd:=600;//主轴结束位置
// 
// //电子凸轮轴实例化
// FB_Cam_Instance[1](
// 	ioMaster:= Axis_同步X2轴, 
// 	ioSlave:= Axis_同步X3轴, 
// 	ioCam:= DB7050_DriveControl.CamCtrl[1], 
// 	ioCamTable:= Cam_OP07_X2_X3, 
// 	iEstop:= DB7000_Control.Machine.EmgSafetyRelay, 
// 	iEn_Control:= DB7050_DriveControl.AxisCtrl[2].Status.InPoint[1] AND  DB7050_DriveControl.AxisCtrl[3].Status.InPoint[1]);
// 

