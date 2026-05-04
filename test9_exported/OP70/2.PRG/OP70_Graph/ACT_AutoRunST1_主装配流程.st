// 主装配流程
// 生成时间：2026-05-04 10:06:13
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
            Auto[1].Comment:="上料侧边定位气缸 伸出+上料侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            DB7070_FaultStop.Pick_失败 := true;
            IF TRUE THEN
                Auto[1].Step:=1000;
            ELSIF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=20;
            END_IF
        20:
            Auto[1].Comment:="上料侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=30;
            END_IF
        30:
            Auto[1].Comment:="上料侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=40;
            END_IF
        40:
            Auto[1].Comment:="上料侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=50;
            END_IF
        50:
            Auto[1].Comment:="上料侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=1000;
            END_IF
        60:
            Auto[1].Comment:="上料侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=70;
            END_IF
        70:
            Auto[1].Comment:="上料侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=80;
            END_IF
        80:
            Auto[1].Comment:="上料侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=90;
            END_IF
        90:
            Auto[1].Comment:="上料侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=100;
            END_IF
        100:
            Auto[1].Comment:="上料侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=110;
            END_IF
        110:
            Auto[1].Comment:="上料侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=120;
            END_IF
        120:
            Auto[1].Comment:="上料侧边定位气缸 伸出";
            DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Cmd.AutoToWork := TRUE;
            IF TRUE THEN
                Auto[1].Step:=1000;
            ELSIF TRUE THEN
                Auto[1].Step:=1000;
            ELSIF DB7050_DriveControl.CylCtrl[Enum_OP70_Cyl.上料侧边定位气缸CY01].Status.InWork THEN
                Auto[1].Step:=130;
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

