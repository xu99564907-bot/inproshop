TYPE Str_OP30_Product :
STRUCT
	ProductSpecifications:STRING(20);//产品规格型号
	ProductCode:STRING(20);//产品料号
	MaterialName:ARRAY[0..10]OF WSTRING(20);//辅料名称
	MaterialCode:ARRAY[0..10]OF STRING(20);//辅料料号
END_STRUCT
END_TYPE
