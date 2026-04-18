<%
	String sGroupName = (String)ARJspCurr.getCurrentGroup();
	String applangcode =  (String) session.getAttribute("applangcode");
	FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
	
	String sBODDate             = (securityInfo.bodDate).substring(0,10);
	String format               = ProfileProperties.getProperty(sProfileId,"amountFormat");
	
	finbranchUtil.ONSMultiRecHandler2 mrh = (finbranchUtil.ONSMultiRecHandler2)ARJspCurr.getInputWithGroup("payCreditMRH",null);		
	gcode.utils.ONSList salPayCreditDet_LL = (gcode.utils.ONSList)ARJspCurr.getInputWithGroup("salPayCreditDet_LL",null);	
	String sCurrCount = (String)ARJspCurr.getInputWithGroup("salPayCreditDet_CurrCount","0");
	int iSerialNo = Integer.parseInt(sCurrCount);
	int iTotalRecNo = salPayCreditDet_LL !=null ? salPayCreditDet_LL.size() : 0;
	String sIsOldRecord = ( (iTotalRecNo > 0) && (iTotalRecNo > iSerialNo) ) ? "true" : "false";
	gcode.iface.IsalPayCreditDetLL dummyRec= (gcode.iface.IsalPayCreditDetLL)(gcode.utils.ONSClassFactory.getValueObject(null,"gcode.dataobjects.salPayCreditDetLL"));
	
    	String arrOutPut[][]=
    	{
		{"operAcctNo","text",""}
		,{"creditAmt","text","amt"}
		,{"creditCrcyCode","text",""}
		,{"tranParticulars","text",""}
		,{"delFlg","text",""}
   	};
	String  sMultiRecName   = "salPayCreditDet";
%>

<script language="JavaScript">		
	var sIsOldRecord = "<%=ParseValue.checkString(sIsOldRecord)%>";
	var sBODDate    = '<%=ParseValue.checkString(sBODDate)%>';
	var iTotalSize = "<%=ParseValue.checkString(iTotalRecNo)%>";
</script>


