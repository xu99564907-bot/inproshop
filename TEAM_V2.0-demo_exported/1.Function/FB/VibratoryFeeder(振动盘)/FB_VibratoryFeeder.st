FUNCTION_BLOCK FB_VibratoryFeeder
VAR_INPUT
	iAutoMode:BOOL;//自动模式
	iEstop:BOOL;//急停
	iSenserLinear:BOOL;//直振满料传感器
	iSenserCircular:BOOL;//圆振缺料传感器

END_VAR
VAR_OUTPUT
	oLinear:BOOL;//直振启动
	oCircular:BOOL;//圆振启动
	oCircularEmptyError:BOOL;//圆振缺料提示
	oTimeOut:BOOL;//出料超时-卡料
END_VAR
VAR_IN_OUT
	ioFeeder:Str_VibratoryFeeder;
END_VAR
VAR
	LinearFullDelay:TON;
	CircularEmptyDelay:TON;
END_VAR

//复位手动控制信号
IF iAutoMode THEN
    ioFeeder.Cmd.ManuLinearStart := FALSE;
    ioFeeder.Cmd.ManuCircularStart := FALSE;
ELSE
    oLinear := ioFeeder.Cmd.ManuLinearStart;
    oCircular := ioFeeder.Cmd.ManuCircularStart;
END_IF;

//自动控制逻辑
//直振未满料时，圆振一直振
//直振未触发停止时，一直振
LinearFullDelay(IN := iSenserLinear,
                 PT := );
CircularEmptyDelay(IN :=  iSenserCircular,
                    PT := );
//自动控制
IF iAutoMode THEN
    IF ioFeeder.Cmd.AutoLinearStop THEN
        oLinear := FALSE;
    ELSE
        oLinear := TRUE;
    END_IF;
    IF NOT LinearFullDelay.Q THEN
        oCircular := TRUE;
    ELSE
        oCircular := FALSE;
    END_IF;
END_IF;

//急停复位控制信号
IF NOT iEstop THEN
    oLinear := FALSE;
    oCircular := FALSE;
END_IF;

//缺料提示
oCircularEmptyError := CircularEmptyDelay.Q AND iAutoMode;














