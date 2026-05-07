// 初始化流程
// 生成时间：2026-05-07 13:57:47
// DriveDB：DB7050_DriveControl

//延时时间
IntitalTimeDelay[1,0](IN:=Init[1].Step=5,PT:=T#500MS);
IntitalTimeDelay[1,1]();
IntitalTimeDelay[1,2]();
IntitalTimeDelay[1,3]();
IntitalTimeDelay[1,4]();
IntitalTimeDelay[1,5]();

//初始化完成状态清除
IF DB7070_Fault.EstopTotal OR DB7070_Fault.StopTotal OR DB7000_Control.Mode.Status.ManualMode OR DB7000_Control.Mode.Out.Stop THEN
    Init[1].Step:=0;
    Init[1].Running:=FALSE;
END_IF

//启动回原
IF DB7000_Control.Mode.Out.HomeStart_R AND NOT Init[1].Running THEN
    Init[1].Running:=TRUE;
    Init[1].Complete:=FALSE;
    Init[1].Step:=5;
    Init[1].Comment:="初始化开始";
END_IF

IF Init[1].Running THEN

    CASE Init[1].Step OF
        5 :
            Init[1].Comment:="初始化开始判定";
            IF IntitalTimeDelay[1,0].Q THEN
                IF Auto[1].Disable THEN
                    Init[1].Step:=1000;
                ELSE
                    Init[1].Step:=10;
                END_IF
            END_IF

        10:
            Init[1].Comment:="上料避位升降气缸 下降+搬运1_1旋转气缸 取料";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料避位升降气缸CY02].Cmd.AutoToHome := TRUE;
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.搬运1_1旋转气缸CY03].Cmd.AutoToHome := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料避位升降气缸CY02].Status.InHome
                AND DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.搬运1_1旋转气缸CY03].Status.InHome THEN
                Init[1].Step:=20;
            END_IF
        20:
            Init[1].Comment:="搬运1_1夹爪气缸 夹紧+搬运1_1夹爪气缸 夹紧";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.搬运1_1夹爪气缸CY04].Cmd.AutoToWork := TRUE;
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.搬运1_1夹爪气缸CY04].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.搬运1_1夹爪气缸CY04].Status.InWork THEN
                Init[1].Step:=30;
            END_IF

        1000:
            Init[1].Comment:="工位初始化完成，等待下工位完成";
            Init[1].Complete:=TRUE;
            IF Init[1].Complete AND Init[2].Complete AND Init[3].Complete AND Init[4].Complete AND Init[5].Complete AND Init[6].Complete THEN
                DB7000_Control.Mode.Status.HomeOK:=TRUE;
                Init[1].Running:=FALSE;
                Init[1].Step:=0;
            END_IF
    ELSE
        ;
    END_CASE

END_IF
