VAR_GLOBAL
	TcpClient:ARRAY[0..9] OF Str_TcpClient;
	TcpSever:ARRAY[0..9] OF Str_TcpClient;
	From_OPXX AT %MW2000:Str_OP80_TO_OPXX;
	TO_OPXX AT %MW1000:Str_OPXX_TO_OP80;
	FromMaster AT %MW3000:Str_FromMaster;
END_VAR
