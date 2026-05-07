// 主装配流程
// 生成时间：2026-05-07 13:55:50
// DriveDB：DB7050_DriveControl

//清除流程步
IF NOT DB7000_Control.Mode.Status.HomeOK THEN
    Auto[1].Step:=0;
    Auto[1].Running:=FALSE;
END_IF

//单元周期计时
IF Auto[1].Running AND CPU_Clock.Clock_100ms_R THEN
    Auto[1].CycleTime:=Auto[1].CycleTime+1;
END_IF

//工程启动条件
Start[1]:=FALSE;

//工程启动
IF DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.HomeOK
    AND Init[1].Complete AND NOT Auto[1].Running THEN
    IF (Start[1] AND NOT DB7000_Control.Mode.Status.StationMode) OR
        (Auto[1].Start AND DB7000_Control.Mode.Status.StationMode) THEN
        Auto[1].Running:=TRUE;
        Auto[1].Step:=10;
        Auto[1].CycleTime:=0;
        Auto[1].Comment:="主装配流程 启动";
    END_IF
END_IF

RunAgin://再次执行Case条件命令，节省一个扫描周期
Auto[1].StepBefor:=Auto[1].Step;

// 流程不暂停条件
Auto[1].NoPausedRunning:=TRUE;

//工程运转中
IF (DB7000_Control.Mode.Status.AutoRunning AND DB7000_Control.Mode.Status.StepRunning)  OR Auto[1].NoPausedRunning THEN
    CASE Auto[1].Step OF
        10:
            Auto[1].Comment:="搬运1_1旋转气缸 取料+上料1侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.搬运1_1旋转气缸CY03].Cmd.AutoToHome := TRUE;
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.搬运1_1旋转气缸CY03].Status.InHome
                AND DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=20;
            END_IF
        20:
            Auto[1].Comment:="上料1侧边定位气缸 伸出+搬运1_1旋转气缸 取料+电批3真空Vac01_吸真空 吸附";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.搬运1_1旋转气缸CY03].Cmd.AutoToHome := TRUE;
            DB7050_DriveControl.VacCtrl[Enum_OP70_Vac.电批3真空Vac01_吸真空VAC01].Cmd.AutoToWork := TRUE;
            IF true THEN
                DB7070_Fault.Stop.感应器_NotDetect:=TRUE;
            END_IF
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Status.InWork
                AND DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.搬运1_1旋转气缸CY03].Status.InHome
                AND DB7050_DriveControl.VacCtrl[Enum_OP70_Vac.电批3真空Vac01_吸真空VAC01].Status.InWork THEN
                Auto[1].Step:=30;
            END_IF
        30:
            Auto[1].Comment:="上料1侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=40;
            END_IF
        40:
            Auto[1].Comment:="上料1侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=30;
            END_IF
        50:
            Auto[1].Comment:="同步X2轴 回原点";
            DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.同步X2轴AXIS02].Cmd.Home := TRUE;
            IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.同步X2轴AXIS02].Status.Intialed THEN
                Auto[1].Step:=60;
            END_IF
        60:
            Auto[1].Comment:="上料1侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=70;
            END_IF
        70:
            Auto[1].Comment:="上料1侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=80;
            END_IF
        80:
            Auto[1].Comment:="上料1侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=90;
            END_IF
        90:
            Auto[1].Comment:="上料1侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=100;
            END_IF
        100:
            Auto[1].Comment:="上料1侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=110;
            END_IF
        110:
            Auto[1].Comment:="上料X1轴 移动到放料位+搬运1_1夹爪气缸 夹紧+上料1侧边定位气缸 伸出+上料1侧边定位气缸 伸出";
            DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.上料X1轴AXIS01].Cmd.AutoABS := 2;
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.搬运1_1夹爪气缸CY04].Cmd.AutoToWork := TRUE;
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.AxisCtrl[Enum_OP70_Axis.上料X1轴AXIS01].Status.InPoint[2]
                AND DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.搬运1_1夹爪气缸CY04].Status.InWork
                AND DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料1侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=120;
            END_IF
        1000:
            Auto[1].Comment:="自动运行结束";
            Auto[1].Running:=FALSE;
            Auto[1].Step:=0;
    ELSE
        ;
    END_CASE
END_IF

//CASE命令中步跳转之后，会在下一个扫描周期后再执行下一流程命令
//当满足跳转条件之后，再次执行流程步
IF Auto[1].StepBefor<>Auto[1].Step THEN
    JMP RunAgin;
END_IF

