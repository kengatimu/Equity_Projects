<%@ page import="applcommon.ParseValue" %>
<%@ page import="finbranchUtil.CustomMultiRecHandler2"%>
<%@ page import="finbranchUtil.CustomMultiRecHandlerInfo"%>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="Customize" isEntryPoint="false" />



<%
		String sCustMultiRecName2 ="custMRH2";
		finbranchUtil.CustomMultiRecHandler2 custMrh2 = (finbranchUtil.CustomMultiRecHandler2)ARJspCurr.getInputWithGroup(sCustMultiRecName2,null);
		if(custMrh2 == null) {
				custMrh2 = new finbranchUtil.CustomMultiRecHandler2();
				finbranchUtil.CustomMultiRecHandlerInfo m2 = new finbranchUtil.CustomMultiRecHandlerInfo();
				m2.setIsInGroup(true);
				m2.setMultiRecName(sCustMultiRecName2);
				m2.setRecordsPerPage(5);
				m2.setMultiRecType("L");
				m2.setPageName("hoccm_det2");
				m2.setContextManager(ARJspCurr);
				m2.setAddDisableModes(new String[] {"D","I","U","V"});

				custMrh2.setMultiRecHandlerInfo(m2);
				String arrCustOutPut2[][]=
				{
						{"d2InstAmt","text","Y"},
						{"d2InstNum","text","Y"},
						{"d2InstDate","text","Y"},
						{"d2PayingAcctNum","text","Y"},
						{"d2BankCode","text","Y"},
						{"d2TranCode","text","Y"},
						{"d2BatchNum","text","Y"},
						{"d2TranId","text","Y"},
						{"d2InstFreetext","text","Y"},
						{"d2BrCode","text","Y"},
				};
				custMrh2.setOutPutArr(arrCustOutPut2);
				ARJspCurr.setInputWithGroup(sCustMultiRecName2,custMrh2);
				custMrh2.prepareCustDataMap();
				custMrh2.callCustomMultiRecHandler();
		}

		String sFuncCode2 = (String)ARJspCurr.getInputWithGroup("funcCode","");
		custMrh2.getMultiRecHandlerInfo().setFunctionCode(sFuncCode2);

%>




<script language="javascript">
	var sMultiRecName2 	= "<%=ParseValue.checkString(sCustMultiRecName2)%>";
</script>
