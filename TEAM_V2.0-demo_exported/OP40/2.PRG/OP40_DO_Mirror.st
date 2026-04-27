PROGRAM OP40_DO_Mirror
VAR
	i:INT;//循环用变量
	Page:INT;
	Monitor:ARRAY[0..15] OF Str_IOMonitor;
	Status:WORD;
	Map:BOOL;
	Startlamp1:BOOL;
	Startlamp2:BOOL;
END_VAR




ACT_MAP();
ACT_Comment();
ACT_Status();
