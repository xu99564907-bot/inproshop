
		//注释 导入标签时选择一个字占用两个字符，然后选择Unicode编码！					
	IF Page > 0 THEN						
		CASE Page OF								
			1:
				;

			ELSE					
				Monitor[0].Comment		:="	未配置IO	";
				Monitor[1].Comment		:="	未配置IO	";
				Monitor[2].Comment		:="	未配置IO	";
				Monitor[3].Comment		:="	未配置IO	";
				Monitor[4].Comment		:="	未配置IO	";
				Monitor[5].Comment		:="	未配置IO	";
				Monitor[6].Comment		:="	未配置IO	";
				Monitor[7].Comment		:="	未配置IO	";
				Monitor[8].Comment		:="	未配置IO	";
				Monitor[9].Comment		:="	未配置IO	";
				Monitor[10].Comment	:="	未配置IO	";
				Monitor[11].Comment	:="	未配置IO	";
				Monitor[12].Comment	:="	未配置IO	";
				Monitor[13].Comment	:="	未配置IO	";
				Monitor[14].Comment	:="	未配置IO	";
				Monitor[15].Comment	:="	未配置IO	";
		END_CASE;					
	END_IF						
